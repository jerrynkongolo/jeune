import SwiftUI
import Combine

final class TodayViewModel: ObservableObject {
    @Published var progress: Double = 0
    @Published var isRunning: Bool = false
    @Published var streak: Int = 0
    @Published var avgFast: String = "--"

    private var timer: AnyCancellable?

    var timeRemaining: String {
        // Placeholder: represent hours remaining until complete
        let hours = Int((1.0 - min(progress, 1.0)) * 24)
        return "\(hours)h"
    }

    var zoneLabel: String {
        progress >= 1.0 ? "Complete" : "Fasting"
    }

    func primaryAction() {
        isRunning.toggle()
    }

    func addEntry() {
        // Placeholder for adding a fasting entry
    }
}
