import SwiftUI


enum FastTimerState: Equatable {

    /// Idle state showing the time since the last fast in seconds.
    case idle(seconds: Int)
    /// Running state with progress fraction 0.0 - 1.0
    case running(progress: Double)
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

    /// Tapping "EDIT" while idle triggers this action. Optional.
    var editGoalAction: (() -> Void)? = nil

    /// Action for the primary button.
    var action: () -> Void

    /// Formatter used to parse `startDate` and `goalTime` strings.
    private static let inputFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "EEE, HH:mm"
        f.locale = Locale(identifier: "en_US_POSIX")
        return f
    }()

    /// Formatter used to display times to the user.
    private static let outputFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "EEE, h:mm a"
        return f
    }()

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
        return .jeunePrimaryDarkColor // deep red

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
                    .foregroundColor(Color.jeuneStatsBGColor) // Match button and capsule grey
                    .frame(width: DesignConstants.largeRingDiameter * 0.8, height: DesignConstants.largeRingDiameter * 0.8)

                RingView(
                    progress: progress,
                    diameter: DesignConstants.largeRingDiameter * 0.8,
                    lineWidth: (DesignConstants.largeRingLineWidth * 0.9) * 0.85 // Further reduced thickness by 15%
                )

                // Thin divider that shows the card's background colour
                Circle()
                    .stroke(Color.jeuneCardColor, lineWidth: 1)
                    .frame(width: DesignConstants.largeRingDiameter * 0.8, height: DesignConstants.largeRingDiameter * 0.8)

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
                    .font(.jeuneCaption)
                        .foregroundColor(.jeuneGrayColor)
                        .frame(maxWidth: .infinity, alignment: .center)

                    Text("\(goalHours)H GOAL")
                    .font(.jeuneCaption)
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
        .jeuneCard()
        .animation(.easeInOut(duration: 0.3), value: state)
    }

    // MARK: – Sub-views
    @ViewBuilder
    private var centreContent: some View {
        switch state {
        case .idle(let seconds):
            VStack(spacing: 4) {
                Text("SINCE LAST FAST")
                    .font(.jeuneCaption)
                    .foregroundColor(.secondary)
                    .textCase(.uppercase)

                Text(timeString(fromSeconds: seconds))

                    .font(.system(size: 36, weight: .heavy))

                    .foregroundColor(.jeuneNearBlack)

                if let editAction = editGoalAction {
                    Button(action: editAction) {
                        Text("EDIT \(goalHours)H GOAL")
                            .font(.jeuneCaption)
                            .foregroundColor(.jeunePrimaryDarkColor)
                    }
                } else {
                    Text("EDIT \(goalHours)H GOAL")
                        .font(.jeuneCaption)
                        .foregroundColor(.jeunePrimaryDarkColor)
                }
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
            .font(.jeuneCaptionBold)
            .foregroundColor(.jeunePrimaryDarkColor) // Changed to primary color
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
        guard let date = Self.inputFormatter.date(from: stringValue) else {
            return stringValue
        }
        return Self.outputFormatter.string(from: date)
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

    private func timeString(fromSeconds seconds: Int) -> String {
        let hrs = seconds / 3600
        let mins = (seconds % 3600) / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d:%02d", hrs, mins, secs)
    }
}

// MARK: – Preview
#Preview {
    FastTimerCardView(state: .idle(seconds: 3_600)) { }
        .padding()
}