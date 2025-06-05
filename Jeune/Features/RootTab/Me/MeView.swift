import SwiftUI

/// Displays user metrics and a heat-map style calendar of recent fasts.
struct MeView: View {
    @Environment(\.jeuneSafeAreaInsets) private var safeAreaInsets: EdgeInsets
    @State private var showHeader = false


    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 40) {
                    toolbar
                    profileCard
                    calendarSection
                    metricsSection
                }
                .padding(.top, 4)
                .padding(.horizontal)
                .padding(.bottom, 16)
            }
            .coordinateSpace(name: "scroll")
            .onPreferenceChange(NameOffsetKey.self) { y in
                withAnimation(.easeInOut(duration: 0.2)) {
                    showHeader = y < safeAreaInsets.top
                }
            }
            .background(Color.jeuneCanvasColor.ignoresSafeArea())
            .navigationBarHidden(true)
            .overlay(alignment: .top) { appBar.opacity(showHeader ? 1 : 0) }
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
        VStack(spacing: 4) {
            Color.clear.frame(height: 24)

            Text("Username")
                .font(.title3.weight(.semibold))
                .background(
                    GeometryReader { geo in
                        Color.clear.preference(key: NameOffsetKey.self, value: geo.frame(in: .named("scroll")).maxY)
                    }
                )

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
            Spacer()
            statBlock(title: "Total Fast", value: "1,000")

            Spacer()

            achievementsBlock

            Spacer()

            statBlock(title: "Current Streak", value: "4")
            Spacer()
        }
    }

    /// Generic stat block with title and value.
    private func statBlock(title: String, value: String) -> some View {
        VStack(spacing: 4) {
            Text(title.uppercased())
                .font(.jeuneCaption)
                .foregroundColor(.jeuneGrayColor)
            Text(value)
                .font(.title3.weight(.bold))
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

    private var calendarSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            sectionHeader(title: "Calendar")
            calendarCard
        }
    }

    private var metricsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            sectionHeader(title: "Weekly Metrics", action: "Manage Weight")
            metricsCard
        }
    }

    private func sectionHeader(title: String, action: String = "See All") -> some View {
        HStack {
            Text(title)
                .font(.callout.weight(.semibold))
            Spacer()
            Text(action.uppercased())
                .font(.jeuneCaptionBold)
                .foregroundColor(.jeunePrimaryDarkColor)
        }
    }

    private var calendarCard: some View {
        VStack(spacing: 16) {
            weekRow(start: 0)
            weekRow(start: 7)
            calendarLegend
        }
        .jeuneCard()
    }

    private func weekRow(start: Int) -> some View {
        HStack(spacing: 32) {
            ForEach(0..<7) { index in
                let date = Calendar.current.date(byAdding: .day, value: start + index, to: Date())!

                DateRingView(date: date, color: calendarColors.randomElement()!)

            }
        }
    }

    private var calendarColors: [Color] {

        [.jeuneNutritionColor, .jeuneActivityColor, .jeuneRestorationColor, .jeuneSleepColor] 

    }

    private var calendarLegend: some View {
        HStack(spacing: 16) {
            legendItem(color: .jeuneNutritionColor, label: "Nutrition")
            legendItem(color: .jeuneActivityColor, label: "Activity")
            legendItem(color: .jeuneRestorationColor, label: "Restoration")
            legendItem(color: .jeuneSleepColor, label: "Sleep")
        }
    }

    private func legendItem(color: Color, label: String) -> some View {
        HStack(spacing: 4) {
            Circle()
                .fill(color)
                .frame(width: 8, height: 8)
            Text(label)
                .font(.jeuneCaptionBold)
                .foregroundColor(.jeuneGrayColor)
        }
    }

    private var metricsCard: some View {
        HStack {
            metricsBlock(title: "Weight", value: "87.5 kg")
            Spacer()
            metricsBlock(title: "Avg Fat Burning", value: "2h 30m")
            Spacer()
            metricsBlock(title: "Avg Sleep", value: "5h 45m")
        }
        .jeuneCard()
    }

    private func metricsBlock(title: String, value: String) -> some View {
        VStack(spacing: 4) {
            Text(title.uppercased())
                .font(.jeuneCaption)
                .foregroundColor(.jeuneGrayColor)
            Text(value)
                .font(.title3.weight(.bold))
                .foregroundColor(.jeuneNearBlack)
        }
    }

    /// Floating app bar that appears when scrolling up past the username.
    private var appBar: some View {
        HStack {
            Image(systemName: "paintbrush")
                .fontWeight(.bold)
                .foregroundColor(.jeuneDarkGray)

            Spacer()

            Text("Username")
                .font(.callout.weight(.semibold))
                .foregroundColor(.jeuneNearBlack)

            Spacer()

            Image(systemName: "gearshape")
                .fontWeight(.bold)
                .foregroundColor(.jeuneDarkGray)
        }
        .padding(.top, safeAreaInsets.top)
        .padding(.horizontal)
        .padding(.bottom, 12)
        .frame(maxWidth: .infinity)
        .background(Color.white.ignoresSafeArea(edges: .top))
        .shadow(color: Color.black.opacity(0.15), radius: 2, x: 0, y: 2)
    }

    /// Preference key for tracking the Y position of the username.
    private struct NameOffsetKey: PreferenceKey {
        static var defaultValue: CGFloat = 0
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = nextValue()
        }
    }



}

#Preview {
    MeView()
}
