import Foundation

extension DateFormatter {
    /// Formatter for a numeric day of month ("d").
    static let jeuneDayNumber: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "d"
        return f
    }()

    /// Short weekday formatter using English locale.
    static let jeuneShortWeekday: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "en_US_POSIX")
        f.setLocalizedDateFormatFromTemplate("EEE")
        return f
    }()

    /// Formatter for full weekday and 24‑hour time ("EEE, HH:mm").
    static let jeuneTime24: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "EEE, HH:mm"
        f.locale = Locale(identifier: "en_US_POSIX")
        return f
    }()
}
