import Foundation

struct Monkey {
	var items: [Int64]
	var inspectionCount: Int
	var operation: (Int64) -> Int64
	var test: (Int64) -> Int
	var divisor: Int64
	
	init(lines: [String]) {
		self.items = lines[1]
			.components(separatedBy: .whitespaces)[2...]
			.map{ Int64($0.trimmingCharacters(in: [","]))! }
		self.inspectionCount = 0
		self.operation = {
			let tokens = lines[2].components(separatedBy: .whitespaces)
			let worryOperator = tokens[4]
			let operand = Int64(tokens[5]) ?? $0

			if worryOperator == "+" { return $0 + operand }
			else { return $0 * operand }
		}
		self.test = {
			$0 % Int64(lines[3].components(separatedBy: .whitespaces).last!)! == 0
				? Int(lines[4].components(separatedBy: .whitespaces).last!)!
				: Int(lines[5].components(separatedBy: .whitespaces).last!)!
		}
		self.divisor = Int64(lines[3].components(separatedBy: .whitespaces).last!)!
	}
}

func monkeyBusiness(monkeys: [Monkey], dividedByThree: Bool, roundsCount: Int) -> Int {
	var monkeys = monkeys
	let divisorProduct = monkeys[1...].map{$0.divisor}.reduce(monkeys[0].divisor, *)
	for _ in 0..<roundsCount {
		for index in monkeys.indices {
			let monkey = monkeys[index]
			monkeys[index].inspectionCount += monkey.items.count
			monkey.items.forEach { item in
				let worryLevel = dividedByThree
					? monkey.operation(item) / 3
					: monkey.operation(item) % divisorProduct
				let nextMonkey = monkey.test(worryLevel)
				monkeys[nextMonkey].items.append(worryLevel)
			}
			monkeys[index].items = []
		}
	}
	let topAchievers = monkeys.map(\.inspectionCount).sorted(by: >)
	return topAchievers[0] * topAchievers[1]
}

var monkeys = try! String(contentsOfFile: "\(FileManager.default.currentDirectoryPath)/inputs/day11.txt")
	.components(separatedBy: "\n\n")
	.map { $0.components(separatedBy: .newlines).map { $0.trimmingCharacters(in: .whitespaces) } }
	.map(Monkey.init)

print(monkeyBusiness(monkeys: monkeys, dividedByThree:true, roundsCount: 20))
print(monkeyBusiness(monkeys: monkeys, dividedByThree:false, roundsCount: 10000))

// part 1: 151312
// part 2: 51382025916
