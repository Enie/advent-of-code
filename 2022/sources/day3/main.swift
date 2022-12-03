import Cocoa
import Accelerate

let characters: [String] = [
	"-",
	"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",
	"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"
]

func containsInAll(_ input: [String]) -> String {
	var strings = input
	var sharedString = strings.removeFirst()
	strings
		.forEach { 
			sharedString = Set($0.compactMap { character in sharedString.contains(character) ? "\(character)" : nil }).joined()
		}
		return sharedString
}

func splitInHalf(_ string: String) -> [String] {
	let indexHalf = string.index(string.startIndex, offsetBy: string.count/2)
	let indexLast = string.index(string.startIndex, offsetBy: string.count)
	return [String(string[string.startIndex..<indexHalf]), String(string[indexHalf..<indexLast])]
}

public func day3() {
	let lines = try! String(contentsOfFile: "\(FileManager.default.currentDirectoryPath)/inputs/day3.txt")
		.components(separatedBy: .newlines)
		
	let doubles = lines.map (splitInHalf)
		.map (containsInAll)
		.map { Double(characters.firstIndex(of:$0)!) }

	print(doubles)
	print("part 1: \(vDSP.sum(doubles))")


	let badges = stride(from: 0, to: lines.count, by: 3)
		.map { Array(lines[$0 ..< min($0 + 3, lines.count)]) }
		.map (containsInAll)
		.map { Double(characters.firstIndex(of:$0)!) }
		
	print(badges)
	print("part 2: \(vDSP.sum(badges))")
}

day3()


// part1: 7908
// part2: 2838