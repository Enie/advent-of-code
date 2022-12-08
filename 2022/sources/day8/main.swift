import Foundation
import Accelerate

extension Array where Element: Collection, Element.Index == Int {
	func vertical(at horizontalIndex: Int) -> Array<Element.Iterator.Element> {
		self.map { $0[horizontalIndex] }
	}
}

func score(h: Float, up: [Float], down: [Float], left: [Float], right: [Float]) -> Int {
	var score = (left.reversed().firstIndex { $0 >= h } ?? left.count-1) + 1
	score *= (right.firstIndex { $0 >= h } ?? right.count-1) + 1
	score *= (down.reversed().firstIndex { $0 >= h } ?? down.count-1) + 1
	score *= (up.firstIndex { $0 >= h } ?? up.count-1) + 1
	return score
}

public func day8() {
	let trees = try! String(contentsOfFile: "\(FileManager.default.currentDirectoryPath)/inputs/day8.txt")
		.components(separatedBy: .newlines)
		.map { row in row.map { Float("\($0)")! } }

	var maxScenicScore = 0
	let visibleCount = trees
		.map { row in
			let y = trees.firstIndex(of: row)!
			let enumeratedRow = row.enumerated()
			return enumeratedRow.map { x, height in
				let left = Array(row[...(x-1)])
				let right = Array(row[(x+1)...])
				let up = Array(trees[(y+1)...]).vertical(at: x)
				let down = Array(trees[...(y-1)]).vertical(at: x)

				maxScenicScore = max(score(h: height, up: up, down: down, left: left, right: right), maxScenicScore)
				
				if vDSP.maximum(left) < height { return true }
				if vDSP.maximum(right) < height { return true }
				if vDSP.maximum(down) < height { return true }
				if vDSP.maximum(up) < height { return true }
				return false
			}
		}
		.reduce(0) { sum, row in 
			return sum + row.reduce(0) { $0 + ($1 ? 1 : 0 ) }
		}
		
	print(visibleCount)
	print(maxScenicScore)
}

day8()

// part 1: 1854
// part 2: 527340
