import Foundation

let filePath = Bundle.main.path(forResource:"input_day5", ofType: "txt")
let contentData = FileManager.default.contents(atPath: filePath!)
let content = String(data:contentData!, encoding:String.Encoding.utf8)!.trimmingCharacters(in: .whitespacesAndNewlines)

let binaries = content.components(separatedBy: "\n").map { Int($0)! }

let seatIDs = binaries.enumerated().reduce(into: [Int]()) { (result, arg1) in
    let (index, element) = arg1
    
    guard index % 2 == 0 else {
        return
    }
    
    result.append(element * 8 + binaries[index + 1])
    print(element * 8 + binaries[index + 1])
}
