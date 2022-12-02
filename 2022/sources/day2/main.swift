import Cocoa
import Accelerate

// positive modulo for negative dividends
func mod(_ a: Int, _ n: Int) -> Int {
	precondition(n > 0, "modulus must be positive")
	let r = a % n
	return r >= 0 ? r : r + n
}

enum Shape: Float {
	case グー = 1, パー = 2, チョキ = 3
}

let shapes: [String:Shape] = [
	"A": .グー, 
	"B": .パー,
	"C": .チョキ,
	"X": .グー, 
	"Y": .パー,
	"Z": .チョキ,
]

func points(for strategy: Round) -> Float {
	var points: Float = 0
	if strategy.offense == strategy.defense {
		points = 3
	}
	if (strategy.offense == .チョキ && strategy.defense == .グー) ||
		(strategy.offense == .グー && strategy.defense == .パー) ||
		(strategy.offense == .パー && strategy.defense == .チョキ) {
		points = 6
	}
	return points + strategy.defense.rawValue
}

func strategy(for row: [String]) -> Round {
	let expectedResult = row[1]
	var defense: Shape = .グー
	let offense = shapes[row[0]]!
	if expectedResult == "X" { defense = Shape(rawValue: Float(mod(Int(offense.rawValue-2),3) + 1))! }
	else if expectedResult == "Y" { defense = offense }
	else if expectedResult == "Z" { defense = Shape(rawValue: Float(mod(Int(offense.rawValue),3) + 1))! }
	
	return Round(offense: offense, defense: defense)
}

struct Round {
	var offense: Shape
	var defense: Shape
}

public func day2() {
	// let scores = "A Y\nB X\nC Z"
	let rows = try! String(contentsOfFile: "\(FileManager.default.currentDirectoryPath)/inputs/day2.txt")
		.components(separatedBy: .newlines)
		.map { $0.components(separatedBy: .whitespaces) }
		
	let scoresA = rows
		.map { Round(offense: shapes[$0[0]]!, defense: shapes[$0[1]]!) }
		.map { points(for: $0) }
	print("scores for method A: \(vDSP.sum(scoresA))")
	
	let scoresB = rows
		.map { strategy(for: $0) }
		.map { points(for: $0) }
	print("scores for method B: \(vDSP.sum(scoresB))")
}


day2()

// result a: 11386
// result b: 13600