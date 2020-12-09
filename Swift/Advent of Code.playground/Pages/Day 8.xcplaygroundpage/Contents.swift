import Foundation

let filePath = Bundle.main.path(forResource:"input_day8", ofType: "txt")
let contentData = FileManager.default.contents(atPath: filePath!)
let content = String(data:contentData!, encoding:String.Encoding.utf8)!.trimmingCharacters(in: .whitespacesAndNewlines)

let assemblerCode = content.components(separatedBy: "\n")

var run = true
var instructionPointer = 0
var visitedInstructions = [Int]()
var accumulator = 0
while run {
    if visitedInstructions.contains(instructionPointer) {
        run = false
        break
    }
    visitedInstructions.append(instructionPointer)
    
    let command = assemblerCode[instructionPointer].components(separatedBy: " ").first!
    let signedInt = Int(assemblerCode[instructionPointer].components(separatedBy: " ").last!.trimmingCharacters(in: .whitespaces))!
    
    switch command {
    case "acc":
        accumulator += signedInt
        instructionPointer += 1
    case "jmp":
        instructionPointer += signedInt
    case "nop":
        instructionPointer += 1
    default:
        fatalError("This case shouldn't exist")
    }
}

print("The Accumulators value just before the infinite loop is: \(accumulator)")
