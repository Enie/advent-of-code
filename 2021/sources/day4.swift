import Foundation

public func day4() {
    func toUInt8(_ value: String) -> UInt8 {UInt8(value)!}

    class BingoNumber {
        var value: UInt8 = 0
        var marked: Bool = false
        init(with value: UInt8) {self.value = value}
    }

    struct BingoRow {
        var numbers: [BingoNumber]
        var count: UInt8 { get {numbers.reduce(0) {$0 + $1.value}} }
        mutating func mark(number: UInt8) -> Bool {
            numbers.reduce(false){
                if $1.value == number {$1.marked = true; return true}
                return $0
            }
        }
    }

    struct BingoBoard {
        var rows: [BingoRow] = []
        init(with numbers: [[UInt8]]) {
            rows += numbers.map{BingoRow(numbers: $0.map{BingoNumber(with: $0)})}
            rows += Array(0...4).map{y in BingoRow(numbers: Array(0...4).map{x in BingoNumber(with: numbers[y][x])})}
        }
        mutating func mark(number: UInt8) -> Bool {
            return rows.enumerated().reduce(false) {result, enumeration in
                var row = rows[enumeration.offset]
                let bingo = row.mark(number: number)
                print(row.count)
                return row.count==5 || result
            }
        }
    }

    var input = try! String(contentsOfFile: Bundle.main.path(forResource: "day4", ofType: "txt")!)
        .components(separatedBy: "\n\n")

    let drawnNumbers = input.removeFirst().components(separatedBy: ",").map{UInt8($0)!}
    print(drawnNumbers)

    var boards = input.map{ bingoInput -> BingoBoard in
        let boardInput: [[UInt8]] = bingoInput
            .components(separatedBy: .newlines)
            .map{ lines -> [UInt8] in
                return lines.components(separatedBy: .whitespaces).filter{!$0.isEmpty}.map(toUInt8)
            }
        return BingoBoard(with: boardInput)
    }

    drawnNumbers.forEach { drawnNumber in
        if let winningBoard = boards.enumerated().filter({boards[$0.offset].mark(number: drawnNumber)}).first {
            print("BINGO!")
            let board = winningBoard.element
            print("thats a BINGO!", board.rows[0...4].map{$0.numbers.map{($0.value,$0.marked)}})
            let sum = board.rows[0...4].reduce(UInt8(0)) {partialSum, row in
                print(partialSum)
                return partialSum + row.numbers.reduce(UInt8(0)) {$0 + ($1.marked ? 0 : $1.value)}
            }
            print(sum * drawnNumber)
        }
    }

}
