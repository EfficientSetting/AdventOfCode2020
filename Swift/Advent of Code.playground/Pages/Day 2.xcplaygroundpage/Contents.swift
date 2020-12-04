import Foundation

let filePath = Bundle.main.path(forResource:"input_day2", ofType: "txt")
let contentData = FileManager.default.contents(atPath: filePath!)
let content = String(data:contentData!, encoding:String.Encoding.utf8)!.trimmingCharacters(in: .whitespacesAndNewlines)

let passwordInputs = content
    .split(separator: "\n")
    .map {
        ($0.split(separator: ":").first!, $0.split(separator: ":").last!.trimmingCharacters(in: .whitespaces))
    }
    .map { (key, value) -> ((min: Int, max: Int, char: String), password: String) in
        let quantifierMin = key.split(separator: "-").first!
        let quantifierMax = key.split(separator: "-").last!.split(separator: " ").first!
        let character = key.split(separator: " ").last!
        return ((min: Int(quantifierMin)!, max: Int(quantifierMax)!, char: String(character)), password: value)
    }

let validPasswordsPartI = passwordInputs.compactMap { (arg0) -> String? in
    let ((min, max, char), password) = arg0
    let range = min...max
    let characterCount = password.reduce(0, { String($1) == char ? $0 + 1 : $0 })
    
    if range.contains(characterCount) {
        return password
    } else {
        return nil
    }
}

print("The solution to part 1 of the puzzle is: \(validPasswordsPartI.count)")

let validPasswordsPartII = passwordInputs.compactMap { (arg0) -> String? in
    let ((min, max, char), password) = arg0
    let firstIndex = password.index(password.startIndex, offsetBy: min - 1)
    let secondIndex = password.index(password.startIndex, offsetBy: max - 1)
    
    if String(password[firstIndex]) == char && String(password[secondIndex]) == char {
        return nil
    } else if String(password[firstIndex]) == char || String(password[secondIndex]) == char {
        return password
    } else {
        return nil
    }
}

print("The solution to part 2 of the puzzle is: \(validPasswordsPartII.count)")
