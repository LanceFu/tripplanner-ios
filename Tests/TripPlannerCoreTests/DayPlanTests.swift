import XCTest
@testable import TripPlannerCore

final class DayPlanTests: XCTestCase {
    private let castle = Place(name: "Castle", latitude: 38.7139, longitude: -9.1334)
    private let date = Date(timeIntervalSince1970: 1_800_000_000)

    func testEmptyDayPlanHasZeroDuration() {
        XCTAssertEqual(DayPlan(date: date).totalDurationMinutes, 0)
    }

    func testStopsKeepTheOrderTheyWereAdded() throws {
        var plan = DayPlan(date: date)
        let first = Stop(place: castle, durationMinutes: 30)
        let second = Stop(place: castle, durationMinutes: 60)
        try plan.add(first)
        try plan.add(second)
        XCTAssertEqual(plan.stops.map(\.id), [first.id, second.id])
    }

    func testTotalDurationSumsStops() throws {
        var plan = DayPlan(date: date)
        try plan.add(Stop(place: castle, durationMinutes: 30))
        try plan.add(Stop(place: castle, durationMinutes: 60))
        XCTAssertEqual(plan.totalDurationMinutes, 90)
    }

    func testRejectsEleventhStopWithTooManyStopsError() throws {
        var plan = DayPlan(date: date)
        for _ in 0..<10 {
            try plan.add(Stop(place: castle, durationMinutes: 30))
        }
        let before = plan
        XCTAssertThrowsError(try plan.add(Stop(place: castle, durationMinutes: 30))) { error in
            XCTAssertEqual(error as? DayPlanError, .tooManyStops)
        }
        XCTAssertEqual(plan, before)
        XCTAssertEqual(plan.stops.count, 10)
    }
}
