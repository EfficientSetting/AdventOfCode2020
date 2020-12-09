import Foundation

let filePath = Bundle.main.path(forResource:"input_day8", ofType: "txt")
let contentData = FileManager.default.contents(atPath: filePath!)
let content = String(data:contentData!, encoding:String.Encoding.utf8)!.trimmingCharacters(in: .whitespacesAndNewlines)

let assemblerCode = content.components(separatedBy: "\n")

var accumulator = 0
var instructionPointer = 0
var visitedInstructions = [Int]()
var replacedInstruction = [Int]()
var alreadyReplaced = false // Already replaced one command this cycle
while instructionPointer < assemblerCode.count {
    if visitedInstructions.contains(instructionPointer) {
        // Reset program
        accumulator = 0
        instructionPointer = 0
        visitedInstructions = [Int]()
        alreadyReplaced = false
    }
    visitedInstructions.append(instructionPointer)
    
    var command = assemblerCode[instructionPointer].components(separatedBy: " ").first!
    let signedInt = Int(assemblerCode[instructionPointer].components(separatedBy: " ").last!.trimmingCharacters(in: .whitespaces))!
    
    if !alreadyReplaced && !replacedInstruction.contains(instructionPointer) {
        switch command {
        case "jmp":
            print("Replacing instruction \(command) at \(instructionPointer) from jmp to nop")
            command = "nop"
        case "nop":
            print("Replacing instruction \(command) at \(instructionPointer) from nop to jmp")
            command = "jmp"
        default:
            break
        }
        
        alreadyReplaced = true
        replacedInstruction.append(instructionPointer)
    }
    
    switch command {
    case "acc":
        accumulator += signedInt
        instructionPointer += 1
    case "jmp":
        instructionPointer += signedInt
    case "nop":
        instructionPointer += 1
    default:
        break
    }
}

print("The Accumulators value after the program terminates is: \(accumulator)")
