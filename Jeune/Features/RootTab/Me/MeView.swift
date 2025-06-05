// MeView.swift
import SwiftUI

/// Displays user metrics and a heat-map style calendar of recent fasts.
struct MeView: View {
    @State private var selectedDate: Date = .init()

    /// Placeholder fast data representing fasting duration for each day
    /// in the 7×6 grid shown by ``FastCalendar``.
    private var fasts: [Double] = Array(repeating: 0, count: 42)

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    toolbar
                    profileCard
                    FastCalendar(selectedDate: $selectedDate, fasts: fasts)
                }
                .padding(.horizontal)
            }
            .background(Color.jeuneCanvasColor.ignoresSafeArea())
            .navigationBarHidden(true)
        }
    }

    /// Top bar with customisation and settings icons.
    private var toolbar: some View {
        HStack {
            Image(systemName: "paintbrush")
                .fontWeight(.bold)
                .foregroundColor(.jeuneDarkGray)

            Spacer()

            Image(systemName: "gearshape")
                .fontWeight(.bold)
                .foregroundColor(.jeuneDarkGray)
        }
    }

    /// Card displaying the user's avatar and stats.
    private var profileCard: some View {
        VStack(spacing: 12) {
            Color.clear.frame(height: 40)

            Text("Username")
                .font(.callout.weight(.semibold))

            statsRow
        }
        .padding(.vertical, 16)
        .jeuneCard()
        .overlay(alignment: .top) {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .foregroundColor(.jeuneGrayColor)
                .background(Circle().fill(Color.jeuneGrayColor.opacity(0.2)))
                .clipShape(Circle())
                .offset(y: -40)
        }
    }

    /// Row showing total fasts, achievements and current streak.
    private var statsRow: some View {
        HStack {
            statBlock(title: "Total Fast", value: "1,000")

            Spacer()

            achievementsBlock

            Spacer()

            statBlock(title: "Current Streak", value: "4")
        }
    }

    /// Generic stat block with title and value.
    private func statBlock(title: String, value: String) -> some View {
        VStack(spacing: 4) {
            Text(title.uppercased())
                .font(.jeuneCaption)
                .foregroundColor(.jeuneGrayColor)
            Text(value)
                .font(.headline.weight(.bold))
                .foregroundColor(.jeuneNearBlack)
        }
    }

    /// Achievements block showing placeholder overlapping icons.
    private var achievementsBlock: some View {
        VStack(spacing: 4) {
            Text("ACHIEVEMENTS")
                .font(.jeuneCaption)
                .foregroundColor(.jeuneGrayColor)

            HStack(spacing: -6) {
                ForEach(0..<3) { _ in
                    Circle()
                        .fill(Color.jeunePrimaryDarkColor)
                        .frame(width: 20, height: 20)
                }

                Text("+35")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.jeuneAccentColor)
                    .padding(.leading, 4)
            }
        }
    }
}

#Preview {
    MeView()
}
