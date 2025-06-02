import SwiftUI

/// Grid calendar showing fasting durations as coloured dots.
/// Designed to fit 7 columns on small screens without overlapping.
struct FastCalendar: View {
    @Binding var selectedDate: Date
    var fasts: [Double] // fasting hours for each day

    private let spacing: CGFloat = 4
    private var columns: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: spacing), count: 7)
    }

    var body: some View {
        GeometryReader { geometry in
            let itemSize = (geometry.size.width - spacing * 6) / 7
            LazyVGrid(columns: columns, spacing: spacing) {
                ForEach(fasts.indices, id: \._self) { index in
                    Circle()
                        .fill(Color.jeunePrimaryColor)
                        .opacity(min(1, fasts[index] / 24))
                        .frame(width: itemSize, height: itemSize)
                }
            }
        }
        // Maintain aspect ratio so the grid doesn't overflow vertically.
        .aspectRatio(7/6, contentMode: .fit)
    }
}

#Preview {
    FastCalendar(selectedDate: .constant(Date()), fasts: Array(repeating: 8, count: 42))
        .padding()
}
