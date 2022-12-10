import Foundation
import simd

extension Array {
	func map<T>(_ mappingFunction: @escaping (_ element: Element, _ index: Int, _ array: Array) -> T ) -> Array<T> {
		let indices = self.indices
		return indices.map {
			mappingFunction(self[$0], $0, self)
		}
	}
}

func cyclesFromString(string: String, index: Int, array: [String]) -> simd_int2 {
	let cycle = array[...index].reduce(0) { $0 + ($1 == "noop" ? 1 : 2) }
	return simd_int2 (
		Int32(cycle), // index is stored in simd_int2.x
		string == "noop" ? 0 : Int32(string.components(separatedBy:" ")[1])! // Value X is stored in simd_int2.y, just for fun
	)
}

public func day10() {
	let lines = try! String(contentsOfFile: "\(FileManager.default.currentDirectoryPath)/inputs/day10.txt")
		.components(separatedBy: .newlines)
		
	let cycles = lines
		.map(cyclesFromString)
		.map { simd_int2($0.x, $2[...$1].reduce(simd_int2(0,1), &+).y) }
		
	var sum = 0
	for cycle in stride(from: 20, to:222, by:40) {
		let index = cycles.firstIndex{ $0.x == cycle || $0.x == cycle-1 || $0.x == cycle-2 }!
		let signal = Int(cycles[index].y) * cycle
		sum += signal
	}
	
	print(sum)
	
	var position = 1
	var crt: [String] = ["","","","","",""]
	var crtLineIndex = 0
	for cycle in 1...240 {
		if let index = cycles.firstIndex(where: { $0.x == cycle }) {
			position = Int(cycles[index].y)	
		}
		
		crt[crtLineIndex] += [-1,0,1].contains(cycle%40 - position) ? "#" : "."
		
		if (cycle)%40 == 0 {
			crtLineIndex+=1
		}

	}

	crt.forEach{print($0)}
}

day10()

// part 1: 12640
// part 2: EHBZLRJR
