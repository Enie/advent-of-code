import Foundation

extension Array where Element == String {
	func rotate() -> [String] {
		self.reduce(into: [String](repeating: "", count:self[0].count )) { (current, row) in
			row.enumerated().forEach {
				current[$0] += String($1)
			}
		}
	}
}

public func day5() {
	let inputs = try! String(contentsOfFile: "\(FileManager.default.currentDirectoryPath)/inputs/day5.txt")
		.components(separatedBy: "\n\n")
	
	let instructions = inputs[1]
		.components(separatedBy: .newlines)
	
	var crates9000 = inputs[0]
		.components(separatedBy: .newlines)
		.rotate()
		.map{$0.reversed()}
		.filter{$0[0] != " "} // remove columns that have no value
		.map{$0[1...]} // remove crate index
		.map{$0.filter{$0 != " "}} // remove whitespaces
		
	var crates9001 = crates9000
		
	instructions.forEach { instruction in
		let parameters = instruction
			.components(separatedBy: .whitespaces)
			.enumerated()
			.filter{!$0.offset.isMultiple(of: 2)}
			.map(\.element)
			.map{Int($0)!}
		
		crates9000[parameters[2]-1] += crates9000[parameters[1]-1].suffix(parameters[0]).reversed()
		crates9000[parameters[1]-1].removeLast(parameters[0])
		
		crates9001[parameters[2]-1] += crates9001[parameters[1]-1].suffix(parameters[0])
		crates9001[parameters[1]-1].removeLast(parameters[0])
	}
	
	let topCrates9000 = crates9000
		.map{String($0.suffix(1))}
		.joined()
		
	let topCrates9001 = crates9001
		.map{String($0.suffix(1))}
		.joined()
	
	print(topCrates9000)
	print(topCrates9001)
	// print(overlapping.count)
}

day5()


// part 1: FCVRLMVQP
// part 2: RWLWGJGFD