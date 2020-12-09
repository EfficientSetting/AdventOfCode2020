import Foundation

let filePath = Bundle.main.path(forResource:"input_day6", ofType: "txt")
let contentData = FileManager.default.contents(atPath: filePath!)
let content = String(data:contentData!, encoding:String.Encoding.utf8)!.trimmingCharacters(in: .whitespacesAndNewlines)

let groups = content.components(separatedBy: "\n\n").map { (element) -> Set<Character> in
    let subGroups = element.components(separatedBy: "\n").map({ Set($0) })
    let intersections = subGroups.reduce(into: subGroups[0]) { (result, groupElement) in
        print("Finding Intersection for \(result.count) - \(result) and \(groupElement.count) - \(groupElement):\nIntersection: \(result.intersection(groupElement).count) - \(result.intersection(groupElement))")
        result = result.intersection(groupElement)
    }
    
    return intersections
}

groups.forEach { (element) in
    print(element.count)
}

print(groups.reduce(into: 0, { (result, element) in
    result += element.count
}))
