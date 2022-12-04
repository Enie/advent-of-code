import Cocoa

infix operator ⊂∨⊃
infix operator ∩

// 
extension ClosedRange {
	static func ⊂∨⊃(lhs: Self, rhs: Self) -> Bool {
		rhs.clamped(to: lhs) == rhs || lhs.clamped(to: rhs) == lhs
	}
}

extension ClosedRange {
	static func ∩(lhs: Self, rhs: Self) -> Bool {
		rhs.overlaps(lhs)
	}
}

func pair(from string: String) -> (ClosedRange<Int>,ClosedRange<Int>) {
	let rangeStrings = string.components(separatedBy: ",") 
	return (range(from: rangeStrings[0]), range(from: rangeStrings[1]))
}

func range(from string: String) -> ClosedRange<Int> {
	let components = string.components(separatedBy: "-")
	return Int(components[0])!...Int(components[1])!
}

public func day4() {
	let pairs = try! String(contentsOfFile: "\(FileManager.default.currentDirectoryPath)/inputs/day4.txt")
		.components(separatedBy: .newlines)
		.map ( pair )
		
	let containing = pairs
		.map ( ⊂∨⊃ )
		.filter { $0 }
		
	let overlapping = pairs
		// .map { $0.0.overlaps($0.1) }
		.map( ∩ )
		.filter { $0 }

	print(containing.count)
	print(overlapping.count)
}

day4()

// part 1: 571
// part 2: 917