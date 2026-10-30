import Foundation

/// One planned visit to a Place, with a Duration in whole minutes.
public struct Stop: Identifiable, Equatable, Sendable {
    public let id: UUID
    public let place: Place
    public let durationMinutes: Int

    public init(id: UUID = UUID(), place: Place, durationMinutes: Int) {
        self.id = id
        self.place = place
        self.durationMinutes = durationMinutes
    }
}
