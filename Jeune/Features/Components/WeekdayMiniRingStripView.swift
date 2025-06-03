// WeekdayMiniRingStripView.swift
import SwiftUI

struct WeekdayMiniRingStripView: View {
    // Placeholder data - this would typically come from a ViewModel
    struct DayProgress {
        let id = UUID()
        let label: String
        let progress: Double
        var isComplete: Bool { progress >= 1.0 }
    }

    // Sample data for 7 days
    @State private var days: [DayProgress] = [
        .init(label: "Mon", progress: 1.0),
        .init(label: "Tue", progress: 0.8),
        .init(label: "Wed", progress: 1.0),
        .init(label: "Thu", progress: 0.3),
        .init(label: "Fri", progress: 0.0),
        .init(label: "Sat", progress: 1.0),
        .init(label: "Sun", progress: 0.6)
    ]

    var body: some View {
        HStack(spacing: 16) { // Spacing between cells
            ForEach(days, id: \.id) { dayData in
                MiniRingView(dayLabel: dayData.label, progress: dayData.progress, isComplete: dayData.isComplete)
            }
        }
        .padding(.horizontal) // Add horizontal padding to the strip itself if needed, or manage in parent view
    }
}

#if DEBUG
struct WeekdayMiniRingStripView_Previews: PreviewProvider {
    static var previews: some View {
        WeekdayMiniRingStripView()
            .padding()
            .background(Color.jeuneBGLightColor)
            .previewLayout(.sizeThatFits)
    }
}
#endif
