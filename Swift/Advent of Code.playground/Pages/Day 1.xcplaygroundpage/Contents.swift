import Foundation

let filePath = Bundle.main.path(forResource:"input_day1", ofType: "txt")
let contentData = FileManager.default.contents(atPath: filePath!)
let content = String(data:contentData!, encoding:String.Encoding.utf8)!.trimmingCharacters(in: .whitespacesAndNewlines)

let expenseReport = content.split(separator: "\n").map({ Int($0)! })

func findMatchingElement(for element: Int, with sum: Int) -> Int? {
    if element > sum { return nil }
    return expenseReport.first(where: { $0 == sum - element })
}

let matchingElement = expenseReport.first(where: { findMatchingElement(for: $0, with: 2020) != nil })!

print("Solution to part#1 \(matchingElement) and \(findMatchingElement(for: matchingElement, with: 2020)!): \(matchingElement * findMatchingElement(for: matchingElement, with: 2020)!)")

let matchingResultsTriple = expenseReport.compactMap { (element0) in
    expenseReport.compactMap { (element1) -> (Int, Int, Int)? in
        if element0 + element1 > 2020 { return nil }
        
        if let element3 = findMatchingElement(for: element0 + element1, with: 2020) {
            return (element0, element1, element3)
        } else {
            return nil
        }
    }
}

print(matchingResultsTriple)
