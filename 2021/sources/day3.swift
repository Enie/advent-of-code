import Foundation

public func day3() {
    let binaries = try! String(contentsOfFile: Bundle.main.path(forResource: "day3", ofType: "txt")!)
        .components(separatedBy: .newlines)

    // part1
    func countOnes(in array: [String]) -> [Int] {
        var count = Array(repeating: 0, count: array[0].count)
        array.forEach {
            $0.enumerated().forEach {
                count[$0] += $1 == "1" ? 1 : 0
            }
        }
        return count
    }
    let onesCount = countOnes(in: binaries)
    let threshold = binaries.count/2

    let gammaRate = Int(onesCount.reduce("", { "\($0)\($1 > threshold ? "1" : "0")" }), radix: 2)!
    let epsilonRate = Int(onesCount.reduce("", { "\($0)\($1 < threshold ? "1" : "0")" }), radix: 2)!
    let powerConsumption = gammaRate * epsilonRate
    print("power  consumption: ", powerConsumption)

    // part 2
    func findCommon(compare: (Int, Int) -> Bool) -> [String] {
        return Array(0..<binaries[0].count).reduce(into: binaries) { filtered, index in
            if filtered.count > 1 {
                let onesCount = countOnes(in: filtered)
                let threshold = filtered.count/2
                filtered = filtered.filter {
                    ($0.count != 0) && $0[String.Index(encodedOffset:index)] == (compare(onesCount[index], threshold) ? "1" : "0")
                }
            }
        }
    }

    let oxygenGeneratorRating = Int(findCommon(compare: >=)[0], radix: 2)!
    let co2ScrubberRating = Int(findCommon(compare: <)[0], radix: 2)!

    let lifeSupportRating = oxygenGeneratorRating * co2ScrubberRating
    print("life support rating: ", lifeSupportRating)
}
