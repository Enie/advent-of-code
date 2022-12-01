import Foundation

public func speedTest(repeatitionCount: Int = 50, perform: () -> ()) {
    var durationAccumulator: Double = 0
    for _ in 0..<repeatitionCount {
        let start = Date()
        perform()
        durationAccumulator += Date().timeIntervalSince(start) * 1000
    }
    
    print("time in ms: \(durationAccumulator/Double(repeatitionCount))")
}
