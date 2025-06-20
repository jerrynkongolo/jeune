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
    @State private var completed = false

    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    private var fastState: FastTimerState {
        if isRunning {
            if progress >= 1 { return .goalReached(progress: progress) }
            return .running(progress: progress)
        } else {
            if completed { return .completed(totalSeconds: elapsed) }
            return .idle(seconds: sinceLastFast)
        }
    }

    var body: some View {

        VStack(spacing: 12) {
            FastTimerCardView(
                state: fastState,
                startDate: startDateString,
                goalHours: goalHours,
                goalTime: goalDateString,
                editGoalAction: { showGoalPicker = true },
                startTimeAction: { showStartPicker = true },
                action: toggleFasting
            )

            if case .completed = fastState {
                upcomingSection
            }
        }


        .animation(.easeInOut(duration: 0.3), value: isRunning)

        .sheet(isPresented: $showGoalPicker) {
            GoalPickerSheet(goalHours: $goalHours)
                .presentationDetents([.fraction(0.5)])
        }
        .sheet(isPresented: $showStartPicker) {
            StartTimePickerSheet(startTime: $startTime)
                .presentationDetents([.fraction(0.5)])
        }
        .onReceive(timer) { _ in
            if isRunning {
                if let start = startTime {
                    elapsed = Int(Date().timeIntervalSince(start))
                } else {
                    elapsed = 0
                }
            } else if !completed {
                sinceLastFast += 1
            }
        }
        .onChange(of: startTime) { newValue in
            if isRunning, let start = newValue {
                withAnimation(.easeInOut(duration: 0.6)) {
                    elapsed = Int(Date().timeIntervalSince(start))
                }
            }
        }
    }

    private var progress: Double {
        guard goalHours > 0 else { return 0 }
        return Double(elapsed) / Double(goalHours * 3600)
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
            switch fastState {
            case .idle:
                isRunning = true
                elapsed = 0
                completed = false
                startTime = Date()
            case .running:
                isRunning = false
                elapsed = 0
                sinceLastFast = 0
                startTime = nil
            case .goalReached:
                isRunning = false
                completed = true
                sinceLastFast = 0
                // keep startTime to show fast details
            case .completed:
                completed = false
                elapsed = 0

            }
        }
    }

    private func startNewFast() {
        withAnimation(.easeInOut(duration: 0.3)) {
            isRunning = true
            completed = false
            elapsed = 0
            startTime = Date()
        }
    }

    private var upcomingSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Upcoming Fast")
                        .font(.jeuneCaptionBold)
                        .foregroundColor(.jeuneNearBlack)
                    Text("You have a \(goalHours) hours fast up next, enjoy your meals and start your timer when you are ready.")
                        .font(.footnote)
                        .foregroundColor(.jeuneDarkGray)
                }
                Spacer()
                Text("\(goalHours)H")
                    .font(.headline.weight(.bold))
                    .foregroundColor(.jeuneNearBlack)
            }

            HStack {
                Button(action: { showGoalPicker = true }) {
                    Text("Edit Goal")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.jeunePrimaryDarkColor)
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                        .background(Color.jeuneStatsBGColor)
                        .clipShape(Capsule())
                }

                Button(action: startNewFast) {
                    Text("Start")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                        .background(Color.jeunePrimaryDarkColor)
                        .clipShape(Capsule())
                }
            }
        }
        .jeuneCard()
    }

    private func format(date: Date) -> String {
        DateFormatter.jeuneTime24.string(from: date)
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
                Spacer()
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                }
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
        .background(Color.jeuneCanvasColor)
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
            .overlay(
                Text("When did you start fasting?")
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.black)
            )
            .padding()

            DatePicker("", selection: $tempDate, displayedComponents: [.date, .hourAndMinute])
                .datePickerStyle(.wheel)
                .labelsHidden()
                .padding(.horizontal)

            Text(fastedText)
                .font(.subheadline.weight(.semibold))
                .foregroundColor(.jeuneGrayColor)

            PrimaryCTAButton(title: "Save", background: .jeunePrimaryDarkColor) {
                withAnimation(.easeInOut(duration: 0.6)) {
                    startTime = tempDate
                }
                dismiss()
            }
            .padding(.horizontal)
        }
        .background(Color.jeuneCanvasColor)
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



