# Jeune

This repository contains the source for **Jeune**, an example SwiftUI application used for UI experiments and previews.

## FastTimerCardView

`FastTimerCardView` displays a fasting timer with start and goal times. The view expects the `startDate` and `goalTime` strings that are passed into it to conform to the following format:

```
"EEE, HH:mm"
```

- `EEE` – Three letter abbreviation for the day of the week (e.g. `MON`, `TUE`).
- `HH` – Hour in 24‑hour format (`00`‑`23`).
- `mm` – Minute (`00`‑`59`).

The component converts these strings to a user‑friendly display such as `Mon, 9:30 AM`. Ensure any data source populating these values uses the specified format; otherwise, the day of the week will not appear correctly.
