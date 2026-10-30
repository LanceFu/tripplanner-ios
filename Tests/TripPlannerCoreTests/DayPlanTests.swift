import XCTest
@testable import TripPlannerCore

final class DayPlanTests: XCTestCase {
    private let castle = Place(name: "Castle", latitude: 38.7139, longitude: -9.1334)
    private let date = Date(timeIntervalSince1970: 1_800_000_000)

    func testEmptyDayPlanHasZeroDuration() {
        XCTAssertEqual(DayPlan(date: date).totalDurationMinutes, 0)
    }

    func testStopsKeepTheOrderTheyWereAdded() {
        var plan = DayPlan(date: date)
        let first = Stop(place: castle, durationMinutes: 30)
        let second = Stop(place: castle, durationMinutes: 60)
        plan.add(first)
        plan.add(second)
        XCTAssertEqual(plan.stops.map(\.id), [first.id, second.id])
    }

    func testTotalDurationSumsStops() {
        var plan = DayPlan(date: date)
        plan.add(Stop(place: castle, durationMinutes: 30))
        plan.add(Stop(place: castle, durationMinutes: 60))
        XCTAssertEqual(plan.totalDurationMinutes, 90)
    }
}
