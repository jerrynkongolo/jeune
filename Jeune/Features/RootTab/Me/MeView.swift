// MeView.swift
import SwiftUI

/// Displays user metrics and a heat-map style calendar of recent fasts.
struct MeView: View {
    @State private var selectedDate: Date = .init()

    // Placeholder fast data representing fasting duration for each day
    // in the 7×6 grid shown by ``FastCalendar``.
    private var fasts: [Double] = Array(repeating: 0, count: 42)

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    header

                    FastCalendar(selectedDate: $selectedDate, fasts: fasts)
                }
                .padding(.horizontal)
            }
            .navigationTitle("Me")
        }
    }

    /// The header showing the latest weight and a plus button.
    private var header: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Current weight")
                    .font(.caption)
                Text("72 kg")
                    .font(.title)
                    .bold()
            }
            Spacer()
            Button(action: { /* add weight action */ }) {
                Image(systemName: "plus")
                    .padding(8)
                    .background(Color.jeunePrimaryColor)
                    .foregroundColor(.white)
                    .clipShape(Circle())
            }
        }
    }
}

#Preview {
    MeView()
}
