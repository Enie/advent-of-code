// swiftc sources/speed.swift sources/day1/main.swift

import Cocoa
import Accelerate

public func day1a() {
    let bags = try! String(contentsOfFile: "\(FileManager.default.currentDirectoryPath)/inputs/day1.txt")
        .components(separatedBy: "\n\n")
    let sums = bags.map { bag in
        bag
            .components(separatedBy: "\n")
            .map { Int($0) ?? 0 }
            .reduce(0) { $0 + $1 }
    }
    let maximum = sums.max()!
    print(maximum)
}

public func day1b() {
    let bags = try! String(contentsOfFile: "\(FileManager.default.currentDirectoryPath)/inputs/day1.txt")
        .components(separatedBy: "\n\n")
    var sums = bags.map { bag in
        bag
            .components(separatedBy: "\n")
            .map { Int($0) ?? 0 }
            .reduce(0) { $0 + $1 }
    }
    sums.sort(by:>)
    print(sums[0] + sums[1] + sums[2])
}

public func day1aFast() {
    let bags = try! String(contentsOfFile: "\(FileManager.default.currentDirectoryPath)/inputs/day1.txt")
        .components(separatedBy: "\n\n")
    let sums = bags.map { bag in
        vDSP.sum(bag
            .components(separatedBy: "\n")
            .map { Float($0) ?? 0 }
        )
    }
    let maximum = vDSP.minimum(sums)
    print(maximum)
}

public func day1bFast() {
    let bags = try! String(contentsOfFile: "\(FileManager.default.currentDirectoryPath)/inputs/day1.txt")
        .components(separatedBy: "\n\n")
    var sums = bags.map { bag in
        vDSP.sum(bag
            .components(separatedBy: "\n")
            .map { Float($0) ?? 0 }
        )
    }
    vDSP.sort(&sums, sortOrder: .descending)
    print("sum of top three \(sums[0])")
    print("sum of top three \(sums[0] + sums[1] + sums[2])")
}


print("dumb a:")
speedTest() {
    day1a()
}
print("dumb b:")
speedTest() {
    day1b()
}
print("accelerated a:")
speedTest() {
    day1aFast()
}
print("accelerated b:")
speedTest() {
    day1bFast()
}