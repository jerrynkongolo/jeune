import SwiftUI

/// Demo fasting timer that mirrors the design of `FastTimerCardView` but uses
/// simple in-memory state.
struct FastingDemoView: View {
    @State private var isRunning = false
    @State private var elapsed: Int = 0
    @State private var sinceLastFast: Int = 7 * 3600 + 25 * 60 + 41
    @State private var goalHours = 16
    @State private var showGoalPicker = false
    @State private var startTime: Date?

    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        FastTimerCardView(
            state: isRunning ? .running(progress: progress) : .idle(seconds: sinceLastFast),
            startDate: startDateString,
            goalHours: goalHours,
            goalTime: goalDateString,
            editGoalAction: { showGoalPicker = true },
            action: toggleFasting
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

    private var startDateString: String {
        guard let start = startTime else { return "--" }
        return format(date: start)
    }

    private var goalDateString: String {
        guard let start = startTime else { return "--" }
        return format(date: start.addingTimeInterval(Double(goalHours) * 3600))
    }

    private func toggleFasting() {
        if isRunning {
            isRunning = false
            elapsed = 0
            sinceLastFast = 0
            startTime = nil
        } else {
            isRunning = true
            elapsed = 0
            startTime = Date()
        }
    }

    private func format(date: Date) -> String {
        let f = DateFormatter()
        f.dateFormat = "EEE, HH:mm"
        f.locale = Locale(identifier: "en_US_POSIX")
        return f.string(from: date)
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
