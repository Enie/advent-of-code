import Foundation
import simd

func vector(from direction: String) -> simd_float2 {
	switch direction {
		case "U": return simd_float2(0,1)
		case "R": return simd_float2(1,0)
		case "D": return simd_float2(0,-1)
		case "L": return simd_float2(-1,0)
		default: return simd_float2()
	}
}

func simulate(_ knots: inout [simd_float2], _ motions: [String]) -> Int {
	var visitedPositions: Set<simd_float2> = [knots.last!]
	
	motions.forEach { motion in
		let tokens = motion.components(separatedBy: .whitespaces)
		let direction = vector(from: tokens[0])
		
		for _ in 1...(Int(tokens[1])!) {
			var head = knots[0]
			head = head + direction
			knots[0] = head
			
			for index in 1..<knots.count {
				var tail = knots[index]
				let delta = head - tail
				
				if simd_length(delta) > 2 {
					tail = tail + simd_normalize(simd_float2(delta.x, 0)) + simd_normalize(simd_float2(0, delta.y))
				} else if simd_length(delta) == 2 {
					tail = tail + simd_normalize(delta)
				}
				
				knots[index] = tail
				head = tail
			}
			visitedPositions.insert(knots.last!)
		}
	}
	return visitedPositions.count
}

public func day9() {
	let motions = try! String(contentsOfFile: "\(FileManager.default.currentDirectoryPath)/inputs/day9.txt")
		.components(separatedBy: .newlines)
		
	var knots = [simd_float2(), simd_float2()]
	var count = simulate(&knots, motions)
	print("Tail visited \(count) positions")
	
	knots = Array(repeating: simd_float2(), count: 10)
	count = simulate(&knots, motions)
	print("Tail visited \(count) positions")
}

day9()

// part 1: 6243
// part 2: 2630
