import SwiftUI

struct TodayView: View {
    @StateObject private var vm = TodayViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    FastingRingView(progress: $vm.progress)
                        .frame(width: 260, height: 260)
                        .padding(.top, 16)

                    VStack(spacing: 4) {
                        Text(vm.timeRemaining)
                            .font(.system(size: 56, weight: .black, design: .rounded))
                        Text(vm.zoneLabel)
                            .font(.caption)
                            .foregroundColor(.jeuneGrayColor)
                    }

                    PrimaryButton(title: vm.isRunning ? "End Fast" : "Start Fast") {
                        vm.primaryAction()
                    }
                    .frame(maxWidth: 240)

                    HStack(spacing: 12) {
                        StatCard(icon: "flame.fill", title: "Streak", value: "\(vm.streak) d")
                        StatCard(icon: "chart.bar", title: "Avg Fast", value: vm.avgFast)
                    }
                }
            }
            .navigationTitle("Today")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: vm.addEntry) { Image(systemName: "plus") }
                }
            }
        }
    }
}
