import Foundation

/// The ordered Stops planned for one calendar day of a Trip.
public struct DayPlan: Identifiable, Equatable, Sendable {
    public let id: UUID
    public let date: Date
    public private(set) var stops: [Stop]

    public init(id: UUID = UUID(), date: Date, stops: [Stop] = []) {
        self.id = id
        self.date = date
        self.stops = stops
    }

    /// Sum of the Duration of every Stop, in minutes.
    public var totalDurationMinutes: Int {
        stops.reduce(0) { $0 + $1.durationMinutes }
    }

    /// Appends a Stop to the end of the Day Plan.
    public mutating func add(_ stop: Stop) {
        stops.append(stop)
    }
}
