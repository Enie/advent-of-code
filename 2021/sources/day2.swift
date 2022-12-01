import Foundation
import simd

public func day2() {
    let contents = try! String(contentsOfFile: Bundle.main.path(forResource: "day2", ofType: "txt")!)
    let lines = contents.components(separatedBy: .newlines)
    
    // part 1:
    var position: simd_int2 = simd_int2(0,0)
    position.x = lines.reduce(0, { partialResult, instruction in
        return partialResult + (instruction.contains("forward") ? Int32(instruction.components(separatedBy: " ").last!)! : 0)
    })
    position.y = lines.reduce(0, { partialResult, instruction in
        return partialResult
            - (instruction.contains("up") ? Int32(instruction.components(separatedBy: " ").last!)! : 0)
            + (instruction.contains("down") ? Int32(instruction.components(separatedBy: " ").last!)! : 0)
    })

    print(position.x*position.y)
    
    // part 2:
    var aim: Int32 = 0
    
    position = simd_int2(0,0)
    for line in lines {
        let instruction = line.components(separatedBy: " ")
        switch instruction.first {
        case "up":
            aim -= Int32(instruction.last!)!;
            break;
        case "down":
            aim += Int32(instruction.last!)!;
            break;
        case "forward":
            let thrust = Int32(instruction.last!)!
            position.x += thrust;
            position.y += thrust * aim;
            break;
        default: break;
        }
    }
    
    print(position.x*position.y)
}

//public func day2InOneLine() {
//    print(
//        try! String(contentsOfFile: Bundle.main.path(forResource: "day2", ofType: "txt")!)
//            .components(separatedBy: .newlines)
//            .reduce((position: simd_int2(0,0), aim: 0)) {
//                (
//                    position: simd($0.position.x + ($1.contains("forward") ? Int32($1.components(separatedBy: " ").last!)! : 0),
//                                   $0.position.y + $0.aim),
//                    aim: $0.aim - ($1.contains("up") ? Int32($1.components(separatedBy: " ").last!)! : 0)
//                        + ($1.contains("down") ? Int32($1.components(separatedBy: " ").last!)! : 0)
//                )
//            }
//    )
//}
