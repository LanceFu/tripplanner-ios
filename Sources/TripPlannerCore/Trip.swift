import Foundation

/// Reasons a Trip operation can be rejected.
public enum TripError: Error, Equatable {
    /// The Trip name is empty or contains only whitespace characters.
    case nameBlank
    case invalidDateRange
    case dayOutsideTrip
}

/// A Traveller's multi-day plan, made of Day Plans that fall within its dates.
public struct Trip: Identifiable, Equatable, Sendable {
    public let id: UUID
    public var name: String
    public let startDate: Date
    public let endDate: Date
    public private(set) var days: [DayPlan]

    private static let calendar: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "UTC") ?? TimeZone.current
        return calendar
    }()

    /// Creates a Trip. The name must not be blank and the end date must not precede the start date.
    public init(id: UUID = UUID(), name: String, startDate: Date, endDate: Date) throws {
        guard !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            throw TripError.nameBlank
        }
        guard Trip.dayStart(endDate) >= Trip.dayStart(startDate) else {
            throw TripError.invalidDateRange
        }
        self.id = id
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        self.days = []
    }

    /// Adds a Day Plan whose date falls within the Trip dates (inclusive).
    public mutating func addDay(_ day: DayPlan) throws {
        let date = Trip.dayStart(day.date)
        guard date >= Trip.dayStart(startDate), date <= Trip.dayStart(endDate) else {
            throw TripError.dayOutsideTrip
        }
        days.append(day)
    }

    /// Sum of the total Duration of every Day Plan, in minutes.
    public var totalDurationMinutes: Int {
        days.reduce(0) { $0 + $1.totalDurationMinutes }
    }

    private static func dayStart(_ date: Date) -> Date {
        calendar.startOfDay(for: date)
    }
}
