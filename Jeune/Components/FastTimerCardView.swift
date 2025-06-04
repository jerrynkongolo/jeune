import SwiftUI

enum FastTimerState {
    case idle(days: Int)
    case running(progress: Double)   // 0.0‒1.0  (fraction of goal completed)
}

/// Card displaying the fasting-timer ring and CTA button.
struct FastTimerCardView: View {
    // MARK: – Inputs
    var state: FastTimerState

    /// Start time for the fast.
    ///
    /// The string **must** be in the format `"EEE, HH:mm"` (e.g. `"SUN, 07:00"`).
    /// This allows the view to convert it to a user friendly display such as
    /// `"Sun, 7:00 AM"`.
    var startDate: String = "--"

    /// Target length of the fast, in hours.
    var goalHours: Int = 16

    /// Time when the fasting goal is reached.
    ///
    /// Provide the value using the same `"EEE, HH:mm"` format as `startDate` so
    /// the day of the week can be shown correctly.
    var goalTime: String = "--"

    /// Action for the primary button.
    var action: () -> Void

    // MARK: – Derived values
    private var progress: Double {
        switch state {
        case .idle: return 0
        case .running(let value): return value
        }
    }

    private var buttonTitle: String {
        switch state {
        case .idle: return "Start Fasting"
        case .running: return "End Fast"
        }
    }

    private var buttonColor: Color {
    switch state {
    case .idle:
        return .jeunePrimaryColor // deep red

    // Match the outer stats capsule when breaking fast
    case .running:
        return .jeuneStatsBGColor
    }
}

    private var buttonTextColor: Color {
        switch state {
        case .idle: return .white
        case .running: return .jeunePrimaryDarkColor
        }
    }

    // MARK: – UI
    var body: some View {
        VStack(spacing: 16) {
            // Ring with centre content overlaid
            ZStack {
                // Background track for the ring
                Circle()
                    .stroke(lineWidth: (DesignConstants.largeRingLineWidth * 0.9) * 0.85)
                    .foregroundColor(Color.jeuneRingTrackColor) // Color for the track
                    .frame(width: DesignConstants.largeRingDiameter * 0.8, height: DesignConstants.largeRingDiameter * 0.8)

                RingView(
                    progress: progress,
                    diameter: DesignConstants.largeRingDiameter * 0.8,
                    lineWidth: (DesignConstants.largeRingLineWidth * 0.9) * 0.85 // Further reduced thickness by 15%
                )

                centreContent
                // Removed specific padding; now governed by ZStack's padding
            }
            .padding(.top, 40) // Consistent 20pt padding for the ring area (top, bottom, leading, trailing)
            .padding(.bottom, 40)

            // Stats (only while running)
            if case .running = state {
                // Titles Row (Outside and above the gray stats capsule)
                HStack {
                    Text("STARTED")
                        .font(.system(size: 10, weight: .semibold)) // Changed to 10pt
                        .foregroundColor(.jeuneGrayColor)
                        .frame(maxWidth: .infinity, alignment: .center)

                    Text("\(goalHours)H GOAL")
                        .font(.system(size: 10, weight: .semibold)) // Changed to 10pt
                        .foregroundColor(.jeuneGrayColor)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding(.bottom, -13) // Space between titles and the gray stats capsule

                statsRow // This will now be the gray capsule with value pills
                    .padding(.bottom, -8) // Reduce space to CTA button below (16 default - 8 = 8pt gap)
            }

            // CTA Button
            PrimaryCTAButton(
                title: buttonTitle,
                background: buttonColor,
                foreground: buttonTextColor,
                action: action
            )
            // Horizontal padding removed to allow button to respect card's overall padding
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .background(Color.jeuneCardColor)
        .cornerRadius(DesignConstants.cornerRadius)
        .shadow(color: DesignConstants.cardShadow, radius: 20, y: 2)
    }

    // MARK: – Sub-views
    @ViewBuilder
    private var centreContent: some View {
        switch state {
        case .idle(let days):
            VStack(spacing: 4) {
                Text("SINCE LAST FAST")
                    .font(.caption.weight(.semibold))
                    .foregroundColor(.secondary)
                    .textCase(.uppercase)

                Text("\(days) days")
                    .font(.system(size: 52, weight: .heavy))
                    .foregroundColor(.jeuneNearBlack)

                Text("EDIT \(goalHours)H GOAL")
                    .font(.caption.weight(.semibold))
                    .foregroundColor(.jeunePrimaryColor)
            }

        case .running(let p):
            VStack(spacing: 6) {
                Text(timeString(from: p))
                    .font(.system(size: 36, weight: .heavy)) // Further reduced font size
                    .foregroundColor(.jeuneNearBlack)

                Text("ELAPSED (\(Int(p * 100)) %)")
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(.jeuneDarkGray)
                    .padding(.top, -12)
            }
        }
    }

    private func valuePill(value: String) -> some View {
        Text(value)
            .font(.system(size: 10, weight: .bold)) // Changed to 10pt and bold
            .foregroundColor(.jeunePrimaryColor) // Changed to primary color
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.vertical, 10) // Adjusted for vertical centering in 40pt height
            .frame(minHeight: 40)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(red: 224/255, green: 224/255, blue: 224/255), lineWidth: 1)
            )
    }

    /// Converts a time string provided in `"EEE, HH:mm"` format to a
    /// user-facing style like `"Mon, 9:30 AM"`.
    private func formatDisplayDateString(from stringValue: String) -> String {
        print("[Debug] formatDisplayDateString input: '\(stringValue)'")
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "EEE, HH:mm"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX") // For consistent parsing

        guard let date = inputFormatter.date(from: stringValue) else {
            print("[Debug] Failed to parse date string: '\(stringValue)'")
            // If parsing fails, return the original string or an error indicator
            // For example, if the input string is already in the desired format or unexpected
            // For now, we return the original string to be safe.
            // Consider logging an error here in a real app.
            return stringValue
        }

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "EEE, h:mm a" // e.g., Mon, 9:41 AM
        let formattedString = outputFormatter.string(from: date)
        print("[Debug] Parsed date: \(date), Formatted output: '\(formattedString)'")
        return formattedString
    }

    private var statsRow: some View {
        HStack(spacing: 12) { // Spacing between the two white value pills
            valuePill(value: formatDisplayDateString(from: startDate))
            valuePill(value: formatDisplayDateString(from: goalTime))
        }
        .padding(8) // Padding inside the gray outer capsule for the white pills
        .background(Color.jeuneStatsBGColor)
        .clipShape(Capsule())
        // .padding(.horizontal, 16) // User had this commented out, respecting that
    }

    private func statCapsule(title: String, value: String) -> some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.system(size: 11, weight: .semibold))
                .foregroundColor(.jeuneGrayColor)

            Text(value)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.jeuneNearBlack)
        }
        .frame(maxWidth: .infinity)
        .padding(.init(top: 4, leading: 8, bottom: 4, trailing: 8)) // Adjusted padding
        .frame(minHeight: 40) // Reduced height
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 20) // Adjusted for new height (pill shape)
                .stroke(Color(red: 224/255, green: 224/255, blue: 224/255), lineWidth: 1)
        )
        .cornerRadius(20) // Adjusted for new height (pill shape)
    }

    // MARK: – Helpers
    private func timeString(from progress: Double) -> String {
        let totalSeconds = Int(progress * 3_600 * Double(goalHours))
        let hrs = totalSeconds / 3_600
        let mins = (totalSeconds % 3_600) / 60
        let secs = totalSeconds % 60
        return String(format: "%02d:%02d:%02d", hrs, mins, secs)
    }
}

// MARK: – Preview
#Preview {
    FastTimerCardView(state: .idle(days: 135)) { }
        .padding()
}