# TripPlanner: product requirements (fictional)

TripPlanner is an offline-first iOS app that helps a Traveller plan a multi-day Trip. It is a
fictional product used as the target for the Sifu ticket pipeline; nothing here is real data.

## Requirements

| ID | Requirement | Status |
| --- | --- | --- |
| REQ-1 | A Traveller can create a Trip with a name, a start date and an end date. The name must not be blank and the end date must not precede the start date. | Implemented |
| REQ-2 | A Trip contains Day Plans. A Day Plan's date must fall within the Trip dates, inclusive. | Implemented |
| REQ-3 | A Day Plan holds an ordered list of Stops, at most 10 per Day Plan. | Planned |
| REQ-4 | Each Stop refers to one Place and has a Duration between 5 and 720 minutes. | Planned |
| REQ-5 | All data is stored on the device. No account and no network connection are needed to plan a Trip. | Constraint |
| REQ-6 | A Traveller can duplicate a Trip, including its Day Plans and Stops. | Planned |
| REQ-7 | When a Day Plan's total Duration exceeds 16 hours (960 minutes), the app shows a warning. It does not block the plan. | Planned |
| REQ-8 | A Traveller can export a Trip as a plain-text Itinerary. | Planned |
| REQ-9 | The app supports iOS 17 and later. | Constraint |
| REQ-10 | Version 1 never asks for location permission. | Constraint |
| REQ-11 | Every screen supports Dynamic Type and VoiceOver. | Constraint |

## Out of scope for version 1

Bookings, Companions (sharing a Trip with other Travellers), budgets and any server-side feature.

## Acceptance criteria style

Each ticket states its acceptance criteria as "Given / When / Then" lines that map to a test.
