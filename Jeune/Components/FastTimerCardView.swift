import SwiftUI

enum FastTimerState {
    case idle(days: Int)
    case running(progress: Double)
}

/// Card displaying the fasting timer ring and CTA button.
struct FastTimerCardView: View {
    var state: FastTimerState
    var startDate: String = "--"
    var goal: String = "16h"
    var action: () -> Void

    private var progress: Double {
        switch state {
        case .idle: return 0
        case .running(let p): return p
        }
    }

    private var buttonTitle: String {
        switch state {
        case .idle: return "Start Fasting"
        case .running: return "Break Your Fast"
        }
    }

    private var buttonColor: Color {
        switch state {
        case .idle: return .jeunePrimaryColor
        case .running: return .jeuneSuccessColor
        }
    }

    var body: some View {
        VStack(spacing: 24) {
            RingView(progress: progress,
                     diameter: DesignConstants.largeRingDiameter,
                     lineWidth: DesignConstants.largeRingLineWidth)

            centerContent

            if case .running = state {
                statsRow
            }

            PrimaryCTAButton(title: buttonTitle,
                              background: buttonColor,
                              action: action)
                .padding(.horizontal, 24)
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .background(Color.jeuneCardColor)
        .cornerRadius(DesignConstants.cornerRadius)
        .shadow(color: DesignConstants.cardShadow, radius: 10, y: 1)
    }

    @ViewBuilder
    private var centerContent: some View {
        switch state {
        case .idle(let days):
            VStack(spacing: 4) {
                Text("SINCE LAST FAST")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                    .textCase(.uppercase)
                Text("\(days) days")
                    .font(.system(size: 56, weight: .black, design: .rounded))
                Text("EDIT \(goal.uppercased()) GOAL")
                    .font(.caption2)
                    .foregroundColor(.jeunePrimaryColor)
            }
        case .running(let p):
            VStack(spacing: 4) {
                Text(timeString(from: p))
                    .font(.system(size: 56, weight: .black, design: .rounded))
                Text("ELAPSED (\(Int(p * 100)) %)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }

    private var statsRow: some View {
        HStack(spacing: 8) {
            statCapsule(title: "STARTED", value: startDate)
            statCapsule(title: "\(goal) GOAL", value: goal)
        }
        .padding(.horizontal, 24)
    }

    private func statCapsule(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.caption2)
                .foregroundColor(.secondary)
            Text(value)
                .font(.subheadline.weight(.semibold))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(8)
        .background(Color.jeuneBGLightColor)
        .cornerRadius(20)
    }

    private func timeString(from progress: Double) -> String {
        let totalSeconds = Int(progress * 3600 * 16)
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

#Preview {
    FastTimerCardView(state: .idle(days: 135)) {}
        .padding()
}
