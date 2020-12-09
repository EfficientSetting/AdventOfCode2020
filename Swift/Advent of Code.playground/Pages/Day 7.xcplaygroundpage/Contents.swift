import Foundation

let filePath = Bundle.main.path(forResource:"input_day7", ofType: "txt")
let contentData = FileManager.default.contents(atPath: filePath!)
let content = String(data:contentData!, encoding:String.Encoding.utf8)!.trimmingCharacters(in: .whitespacesAndNewlines)

let bagRules = Dictionary(uniqueKeysWithValues: content.components(separatedBy: "\n").map { (element)  in
    (element.components(separatedBy: "bags contain").first!.trimmingCharacters(in: .whitespaces),
     String(element.components(separatedBy: "bags contain").last!.trimmingCharacters(in: .whitespaces).dropLast()))
}).mapValues { (value) in
    value.replacingOccurrences(of: "bags", with: "").replacingOccurrences(of: "bag", with: "").trimmingCharacters(in: .whitespaces)
}

//print(bagRules)

func findAllRules(for bagType: String) -> [String] {
    print("Checking Rules for Bag Type: \(bagType)")
    let rule = bagRules[bagType]!
    
    if rule.contains("no other") {
        return [bagType]
    }
    
    let dissectedRule = rule.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces)
                                                                .trimmingCharacters(in: .decimalDigits)
                                                                .trimmingCharacters(in: .whitespaces)
    }
    
    return dissectedRule.flatMap { (element) in
        findAllRules(for: element)
    }
}

print(findAllRules(for: "shiny gold").count)
