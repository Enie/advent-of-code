import Foundation

func subroutine (buffer: [String], length: Int) -> Int {
	Set(buffer.suffix(length))
		.count == length ? buffer.count : 0

}

public func day6() {
	let input = try! String(contentsOfFile: "\(FileManager.default.currentDirectoryPath)/inputs/day6.txt")
		.map {String($0)}
	
	var startOfPacketMarker = 0
	var startOfMessageMarker = 0
	var index = 3
	while startOfMessageMarker == 0 {
		if startOfPacketMarker == 0 {
			startOfPacketMarker = subroutine(buffer: Array(input[0...index]), length: 4)
		}
		if index >= 14 {
			startOfMessageMarker = subroutine(buffer: Array(input[0...index]), length: 14)
		}
		index += 1
	}
	
	print("Start of packet: \(startOfPacketMarker)")
	print("Start of message \(startOfMessageMarker)")
}

day6()

// part 1: 1623
// part 2: 3774