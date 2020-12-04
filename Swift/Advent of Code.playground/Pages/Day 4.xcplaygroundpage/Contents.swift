import Foundation

let filePath = Bundle.main.path(forResource:"input_day4", ofType: "txt")
let contentData = FileManager.default.contents(atPath: filePath!)
let content = String(data:contentData!, encoding:String.Encoding.utf8)!.trimmingCharacters(in: .whitespacesAndNewlines)

let passports = content.components(separatedBy: "\n\n").map({ $0.replacingOccurrences(of: "\n", with: " ") })
let validPassports = passports.filter { passportElement -> Bool in
    let passport = Dictionary(uniqueKeysWithValues: passportElement.components(separatedBy: " ").map {
                                ($0.components(separatedBy: ":").first!, $0.components(separatedBy: ":").last!)
    })
    
    let requiredKeys: Set = ["ecl", "pid", "eyr", "hcl", "byr", "iyr", "hgt"]
    if requiredKeys.isSubset(of: Set(passport.keys)) { return true } else { return false } // Could have avoided Sets and used allSatisfy - although it would have been slower
}

print("This many passports are valid: \(validPassports.count)")

let validPassportsWithValidation = validPassports.filter { (passportElement) -> Bool in
    let passport = Dictionary(uniqueKeysWithValues: passportElement.components(separatedBy: " ").map {
                                ($0.components(separatedBy: ":").first!, $0.components(separatedBy: ":").last!)
    })
    
    let birthYearRange = 1920...2002
    let issueYearRange = 2010...2020
    let expirationYearRange = 2020...2030
    let cmHeightRange = 150...193
    let inHeightRange = 59...76
    let hairColorRegex = try! NSRegularExpression(pattern: "^#[0-9a-f]{6}$")
    enum EyeColor: String, CaseIterable {
        case amb, blu, brn, gry, grn, hzl, oth
    }
    let passportIDCharacterSet = CharacterSet.decimalDigits
    
    guard let birthYear = passport["byr"], let birthYearInt = Int(birthYear), birthYearRange.contains(birthYearInt) else {
        print("BirthYear does not match: \(passport["byr"]!)")
        return false
    }
    
    guard let issueYear = passport["iyr"], let issueYearInt = Int(issueYear), issueYearRange.contains(issueYearInt) else {
        print("IssueYear does not match: \(passport["iyr"]!)")
        return false
    }
    
    guard let expirationYear = passport["eyr"], let expirationYearInt = Int(expirationYear), expirationYearRange.contains(expirationYearInt) else {
        print("ExpirationYear does not match: \(passport["eyr"]!)")
        return false
    }
    
    guard let height = passport["hgt"] else {
        print("Height does not match: \(passport["hgt"]!)")
        return false
    }
    
    guard (height.contains("cm") && !height.contains("in")) || (!height.contains("cm") && height.contains("in")) else {
        print("Height does not match cm or in: \(passport["hgt"]!)")
        return false
    }
    
    if height.contains("cm") {
        guard let heightInt = Int(height.replacingOccurrences(of: "cm", with: "")), cmHeightRange.contains(heightInt) else {
            print("Centimeter Height does not match: \(height)")
            return false
        }
    }
    
    if height.contains("in") {
        guard let heightInt = Int(height.replacingOccurrences(of: "in", with: "")), inHeightRange.contains(heightInt) else {
            print("Inch Height does not match: \(height)")
            return false
        }
    }
    
    guard let hairColor = passport["hcl"], !hairColorRegex.matches(in: hairColor, options: [], range: .init(location: 0, length: hairColor.count)).isEmpty else {
        print("HairColor does not match: \(passport["hcl"]!)")
        return false
    }
    
    guard let eyeColor = passport["ecl"], EyeColor(rawValue: eyeColor) != nil else {
        print("EyeColor does not match: \(passport["ecl"]!)")
        return false
    }
    
    guard let passportID = passport["pid"], passportID.rangeOfCharacter(from: passportIDCharacterSet.inverted) == nil, passportID.count == 9 else {
        print("PassportID does not match: \(passport["pid"]!)")
        return false
    }
    
    return true
}

print("This many passports are valid and have valid date: \(validPassportsWithValidation.count)")
