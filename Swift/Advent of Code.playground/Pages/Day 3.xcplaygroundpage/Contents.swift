import Foundation

let filePath = Bundle.main.path(forResource:"input_day3", ofType: "txt")
let contentData = FileManager.default.contents(atPath: filePath!)
let content = String(data:contentData!, encoding:String.Encoding.utf8)!.trimmingCharacters(in: .whitespacesAndNewlines)

let puzzleInput = content.components(separatedBy: "\n")

func treesForSlope(right: Int, down: Int) -> Int {
    puzzleInput.enumerated().reduce(into: (position: 0, trees: 0)) { (result, arg1) in
        let (index, currentLine) = arg1 // Deconstructing the tuple from the enumerated() call
        
        // Position is always x: {result.position} y: index
        
        // Skipping lines when down > 1
        guard index % down == 0 else {
            print("Skipping line\(index): \(currentLine)")
            return
        }
        
        // Escape pass for very first pass
        if index == 0 {
            result.position += right
            return
        }
        
        if currentLine[result.position] == "#" {
            result.trees += 1
        }
        
        result.position += right
        if result.position >= currentLine.count {
            result.position -= currentLine.count
        }
        
//        print("New Position is \(result.position) in line\(index): \(currentLine)")
    }.trees
}

print("Part#1:")
print("Trees encountered on Slope 3/1: \(treesForSlope(right: 3, down: 1))")


print("Part#2:")
let treesOneOne = treesForSlope(right: 1, down: 1)
let treesThreeOne = treesForSlope(right: 3, down: 1)
let treesFiveOne = treesForSlope(right: 5, down: 1)
let treesSevenOne = treesForSlope(right: 7, down: 1)
let treesOneTwo = treesForSlope(right: 1, down: 2)
print("Trees encountered multiplied: \(treesOneOne * treesThreeOne * treesFiveOne * treesSevenOne * treesOneTwo)")
