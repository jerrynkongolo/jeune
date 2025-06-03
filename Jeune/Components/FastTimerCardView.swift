import SwiftUI

enum FastTimerState {
    case idle(days: Int)
    case running(progress: Double)   // 0.0‒1.0  (fraction of goal completed)
}

/// Card displaying the fasting-timer ring and CTA button.
struct FastTimerCardView: View {
    // MARK: – Inputs
    var state: FastTimerState

    /// Read-friendly “started at” time (e.g. “08:15 AM”).
    var startDate: String = "--"

    /// Target length of the fast, in hours.
    var goalHours: Int = 16

    /// Read-friendly time when the goal will be reached (e.g. “12:15 AM”).
    var goalTime: String = "--"

    /// Action for the primary button.
    var action: () -> Void

    // MARK: – Derived values
    private var progress: Double {
        switch state {
        case .idle:                 return 0
        case .running(let value):   return value
        }
    }

    private var buttonTitle: String {
        switch state {
        case .idle:    return "Start Fasting"
        case .running: return "Break Your Fast"
        }
    }

    private var buttonColor: Color {
        switch state {
        case .idle:    return .jeunePrimaryColor     // blue
        case .running: return .jeuneSuccessColor     // green
        }
    }

    // MARK: – UI
    var body: some View {
        VStack(spacing: 24) {

            // Ring with centre content overlayed
            ZStack {
                RingView(
                    progress:  progress,
                    diameter:  DesignConstants.largeRingDiameter,
                    lineWidth: DesignConstants.largeRingLineWidth
                )

                centreContent
            }

            // Stats (only while running)
            if case .running = state {
                statsRow
            }

            // CTA
            PrimaryCTAButton(
                title:      buttonTitle,
                background: buttonColor,
                action:     action
            )
            .padding(.horizontal, 16)
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

        // ── Idle ────────────────────────────────────────────────────────────────
        case .idle(let days):
            VStack(spacing: 4) {
                Text("SINCE LAST FAST")
                    .font(.caption.weight(.semibold))
                    .foregroundColor(.secondary)
                    .textCase(.uppercase)

                Text("\(days) days")
                    .font(.system(size: 56, weight: .heavy))
                    .foregroundColor(.jeuneNearBlack)

                Text("EDIT \(goalHours)H GOAL")
                    .font(.caption.weight(.semibold))
                    .foregroundColor(.jeunePrimaryColor)
            }

        // ── Running ─────────────────────────────────────────────────────────────
        case .running(let p):
            VStack(spacing: 6) {
                Text(timeString(from: p))
                    .font(.system(size: 56, weight: .heavy))
                    .foregroundColor(.jeuneNearBlack)

                Text("ELAPSED (\(Int(p * 100)) %)")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.jeuneDarkGray)
            }
        }
    }

    private var statsRow: some View {
        HStack(spacing: 12) {
            statCapsule(title: "STARTED",            value: startDate)
            statCapsule(title: "\(goalHours)H GOAL", value: goalTime)
        }
        .padding(8)
        .background(Color.jeuneStatsBGColor)
        .clipShape(Capsule())
        .padding(.horizontal, 16)
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
        .padding(8)
        .frame(minHeight: 48)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(red: 224/255, green: 224/255, blue: 224/255), lineWidth: 1)
        )
        .cornerRadius(10)
    }

    // MARK: – Helpers
    private func timeString(from progress: Double) -> String {
        let totalSeconds = Int(progress * 3_600 * Double(goalHours))
        let hrs   = totalSeconds / 3_600
        let mins  = (totalSeconds % 3_600) / 60
        let secs  =  totalSeconds % 60
        return String(format: "%02d:%02d:%02d", hrs, mins, secs)
    }
}

// MARK: – Preview
#Preview {
    FastTimerCardView(state: .idle(days: 135)) { }
        .padding()
}