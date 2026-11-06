import XCTest
@testable import TripPlannerCore

final class TripTests: XCTestCase {
    private let oneDay: TimeInterval = 86_400
    private let start = Date(timeIntervalSince1970: 1_800_000_000)
    private let castle = Place(name: "Castle", latitude: 38.7139, longitude: -9.1334)

    private func makeTrip(dayCount: Int = 3) throws -> Trip {
        let end = start.addingTimeInterval(oneDay * Double(dayCount - 1))
        return try Trip(name: "Lisbon", startDate: start, endDate: end)
    }

    func testRejectsEndDateBeforeStartDate() {
        XCTAssertThrowsError(
            try Trip(name: "Oops", startDate: start, endDate: start.addingTimeInterval(-oneDay))
        ) { error in
            XCTAssertEqual(error as? TripError, .invalidDateRange)
        }
    }

    func testRejectsEmptyNameWithNameBlankError() {
        var trip: Trip?
        XCTAssertThrowsError(trip = try Trip(name: "", startDate: start, endDate: start)) { error in
            XCTAssertEqual(error as? TripError, .nameBlank)
        }
        XCTAssertNil(trip)
    }

    func testRejectsWhitespaceOnlyNameWithNameBlankError() {
        var trip: Trip?
        XCTAssertThrowsError(trip = try Trip(name: " \t\n  ", startDate: start, endDate: start)) { error in
            XCTAssertEqual(error as? TripError, .nameBlank)
        }
        XCTAssertNil(trip)
    }

    func testAcceptsSingleDayTrip() throws {
        let trip = try Trip(name: "Day trip", startDate: start, endDate: start)
        XCTAssertTrue(trip.days.isEmpty)
    }

    func testAddsDayInsideTripDates() throws {
        var trip = try makeTrip()
        try trip.addDay(DayPlan(date: start.addingTimeInterval(oneDay)))
        XCTAssertEqual(trip.days.count, 1)
    }

    func testRejectsDayOutsideTripDates() throws {
        var trip = try makeTrip()
        XCTAssertThrowsError(try trip.addDay(DayPlan(date: start.addingTimeInterval(oneDay * 5)))) { error in
            XCTAssertEqual(error as? TripError, .dayOutsideTrip)
        }
        XCTAssertTrue(trip.days.isEmpty)
    }

    func testTotalDurationSumsEveryDayPlan() throws {
        var trip = try makeTrip()
        var first = DayPlan(date: start)
        try first.add(Stop(place: castle, durationMinutes: 90))
        var second = DayPlan(date: start.addingTimeInterval(oneDay))
        try second.add(Stop(place: castle, durationMinutes: 45))
        try trip.addDay(first)
        try trip.addDay(second)
        XCTAssertEqual(trip.totalDurationMinutes, 135)
    }
}
