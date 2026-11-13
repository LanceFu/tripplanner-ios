import Foundation

/// Reasons a Day Plan operation can be rejected.
public enum DayPlanError: Error, Equatable, Sendable {
    /// The Day Plan already holds the maximum of 10 Stops.
    case tooManyStops
}

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

    /// The most Stops a Day Plan can hold.
    public static let maxStops = 10

    /// Appends a Stop to the end of the Day Plan.
    /// Throws `DayPlanError.tooManyStops`, leaving the Stops unchanged,
    /// when the Day Plan already holds `maxStops` Stops.
    public mutating func add(_ stop: Stop) throws {
        guard stops.count < DayPlan.maxStops else {
            throw DayPlanError.tooManyStops
        }
        stops.append(stop)
    }
}
