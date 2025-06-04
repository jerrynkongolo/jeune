import SwiftUI

struct FastingDemoView: View {
    @State private var isRunning = false
    @State private var elapsed: Int = 0
    @State private var sinceLastFast: Int = 7 * 3600 + 25 * 60 + 41
    @State private var goalHours = 16
    @State private var showGoalPicker = false

    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle()
                    .stroke(lineWidth: (DesignConstants.largeRingLineWidth * 0.9) * 0.85)
                    .foregroundColor(Color.jeuneStatsBGColor)
                    .frame(width: DesignConstants.largeRingDiameter * 0.8, height: DesignConstants.largeRingDiameter * 0.8)

                RingView(
                    progress: progress,
                    diameter: DesignConstants.largeRingDiameter * 0.8,
                    lineWidth: (DesignConstants.largeRingLineWidth * 0.9) * 0.85
                )

                Circle()
                    .stroke(Color.jeuneCardColor, lineWidth: 1)
                    .frame(width: DesignConstants.largeRingDiameter * 0.8, height: DesignConstants.largeRingDiameter * 0.8)

                VStack(spacing: 4) {
                    Text("SINCE LAST FAST")
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundColor(.secondary)
                        .textCase(.uppercase)

                    Text(timeString(isRunning ? elapsed : sinceLastFast))
                        .font(.system(size: 24, weight: .heavy))
                        .foregroundColor(.jeuneNearBlack)

                    Button(action: { showGoalPicker = true }) {
                        Text("EDIT \(goalHours)H GOAL")
                            .font(.caption.weight(.semibold))
                            .foregroundColor(.jeunePrimaryDarkColor)
                    }
                }
            }
            .padding(.top, 40)
            .padding(.bottom, 40)

            PrimaryCTAButton(
                title: isRunning ? "End Fast" : "Start Fasting",
                background: isRunning ? Color.jeuneStatsBGColor : Color.jeunePrimaryDarkColor,
                foreground: isRunning ? Color.jeunePrimaryDarkColor : Color.white
            ) {
                toggleFasting()
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .background(Color.jeuneCardColor)
        .cornerRadius(DesignConstants.cornerRadius)
        .shadow(
            color: DesignConstants.cardShadow,
            radius: DesignConstants.cardShadowRadius,
            x: 0,
            y: 0
        )
        .sheet(isPresented: $showGoalPicker) {
            GoalPickerSheet(goalHours: $goalHours)
        }
        .onReceive(timer) { _ in
            if isRunning {
                elapsed += 1
            } else {
                sinceLastFast += 1
            }
        }
    }

    private var progress: Double {
        guard goalHours > 0 else { return 0 }
        return min(Double(elapsed) / Double(goalHours * 3600), 1)
    }

    private func toggleFasting() {
        if isRunning {
            isRunning = false
            elapsed = 0
        } else {
            isRunning = true
            sinceLastFast = 0
        }
    }

    private func timeString(_ seconds: Int) -> String {
        let hrs = seconds / 3600
        let mins = (seconds % 3600) / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d:%02d", hrs, mins, secs)
    }
}

private struct GoalPickerSheet: View {
    @Binding var goalHours: Int
    @Environment(\.dismiss) var dismiss
    private let presets = [16, 18, 20, 24]

    var body: some View {
        NavigationStack {
            List(presets, id: \.self) { hours in
                Button("\(hours) hours") {
                    goalHours = hours
                    dismiss()
                }
            }
            .navigationTitle("Select Goal")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                }
            }
        }
    }
}

#Preview {
    FastingDemoView()
        .padding()
}
