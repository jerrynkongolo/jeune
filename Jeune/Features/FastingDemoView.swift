import SwiftUI

/// Demo fasting timer that mirrors the design of `FastTimerCardView` but uses
/// simple in-memory state.
struct FastingDemoView: View {
    @State private var isRunning = false
    @State private var elapsed: Int = 0
    @State private var sinceLastFast: Int = 7 * 3600 + 25 * 60 + 41
    @State private var goalHours = 16
    @State private var showGoalPicker = false
    @State private var showStartPicker = false
    @State private var startTime: Date?

    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        FastTimerCardView(
            state: isRunning ? .running(progress: progress) : .idle(seconds: sinceLastFast),
            startDate: startDateString,
            goalHours: goalHours,
            goalTime: goalDateString,
            editGoalAction: { showGoalPicker = true },
            action: toggleFasting,
            startTimeAction: { showStartPicker = true }
        )

        .animation(.easeInOut(duration: 0.3), value: isRunning)

        .sheet(isPresented: $showGoalPicker) {
            GoalPickerSheet(goalHours: $goalHours)
        }
        .sheet(isPresented: $showStartPicker) {
            StartTimePickerSheet(startTime: $startTime)
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


        withAnimation(.easeInOut(duration: 0.3)) {
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
    }

    private func format(date: Date) -> String {
        let f = DateFormatter()
        f.dateFormat = "EEE, HH:mm"
        f.locale = Locale(identifier: "en_US_POSIX")
        return f.string(from: date)
    }
}

private struct GoalOption: Identifiable {
    let id = UUID()
    let name: String
    let subtitle: String
    let hours: Int
    let color: Color
}

private struct GoalPickerSheet: View {
    @Binding var goalHours: Int
    @Environment(\.dismiss) var dismiss

    private let options: [GoalOption] = [
        GoalOption(name: "Circandia", subtitle: "Rhythm TRF", hours: 13, color: .purple),
        GoalOption(name: "Preset", subtitle: "Rhythm TRF", hours: 16, color: .pink),
        GoalOption(name: "Preset", subtitle: "Rhythm TRF", hours: 18, color: .green),
        GoalOption(name: "Preset", subtitle: "Rhythm TRF", hours: 20, color: .orange),
        GoalOption(name: "Preset", subtitle: "Rhythm TRF", hours: 36, color: .blue),
        GoalOption(name: "Custom", subtitle: "1-168", hours: 168, color: .teal)
    ]

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 3)

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                }
                Spacer()
            }
            .overlay(
                Text("Change Fast Goal")
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.black)
            )
            .padding()

            Divider()

            ScrollView {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(options) { option in
                        GoalCard(option: option) {
                            goalHours = option.hours
                            dismiss()
                        }
                    }
                }
                .padding()
            }
            .background(Color.jeuneCanvasColor)
        }
    }
}

private struct GoalCard: View {
    let option: GoalOption
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 4) {
                Text(option.name)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.white)
                Text(option.subtitle)
                    .font(.system(size: 11))
                    .foregroundColor(.white)

                Spacer()

                Text("\(option.hours)")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)

                HStack {
                    Text("hours")
                        .font(.system(size: 12))
                        .foregroundColor(Color.white.opacity(0.7))
                    Spacer()
                    Image(systemName: "info.circle")
                        .foregroundColor(.white)
                }
            }
            .padding()
            .frame(height: 150)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(option.color)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .buttonStyle(PlainButtonStyle())
    }
}

private struct StartTimePickerSheet: View {
    @Binding var startTime: Date?
    @Environment(\.dismiss) var dismiss

    @State private var tempDate: Date

    init(startTime: Binding<Date?>) {
        _startTime = startTime
        _tempDate = State(initialValue: startTime.wrappedValue ?? Date())
    }

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Spacer()
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                }
            }
            .padding()

            HStack {
                Text("When did you start fasting?")
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.black)
                Spacer()
            }
            .padding(.horizontal)

            DatePicker("", selection: $tempDate, displayedComponents: [.date, .hourAndMinute])
                .datePickerStyle(.wheel)
                .labelsHidden()
                .padding(.horizontal)

            Text(fastedText)
                .font(.subheadline.weight(.semibold))
                .foregroundColor(.jeuneGrayColor)

            PrimaryCTAButton(title: "Save", background: .jeunePrimaryDarkColor) {
                startTime = tempDate
                dismiss()
            }
            .padding(.horizontal)
        }
    }

    private var fastedText: String {
        let diff = Date().timeIntervalSince(tempDate)
        let hours = Int(diff) / 3600
        let mins = (Int(diff) % 3600) / 60
        return "You fasted for \(hours)h \(mins)m"
    }
}

#Preview {
    FastingDemoView()
        .padding()

}



