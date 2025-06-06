import SwiftUI

/// Displays user metrics and a heat-map style calendar of recent fasts.
struct MeView: View {
    @Environment(\.jeuneSafeAreaInsets) private var safeAreaInsets: EdgeInsets
    @State private var barOpacity: Double = 0
    @State private var showTitle = false
    @State private var showSettings = false

    /// Height of the navigation bar including the safe area.
    private var barHeight: CGFloat {
        safeAreaInsets.top + 44
    }


    var body: some View {
        NavigationStack {
            ScrollView {
                GeometryReader { geo in
                    Color.clear
                        .preference(key: ScrollOffsetKey.self,
                                    value: geo.frame(in: .named("scroll")).minY)
                        .frame(height: 0)
                }


                VStack(spacing: 24) {
                    // Reserve space for the floating header

                    Color.clear.frame(height: barHeight - 24)


                    profileCard
                    calendarSection
                    metricsSection
                    recentFastsSection
                }
                .padding(.horizontal)
                .padding(.bottom, 16)
            }
            .coordinateSpace(name: "scroll")
            .onPreferenceChange(NameOffsetKey.self) { y in
                // Debug prints
                print("--- Debug MeView --- Username global minY (y): \(y)")
                print("--- Debug MeView --- Calculated barHeight: \(barHeight)")
                print("--- Debug MeView --- Current safeAreaInsets.top: \(safeAreaInsets.top)")
                
                let visible = y <= barHeight
                print("--- Debug MeView --- Condition (y <= barHeight) is: \(visible)")
                
                withAnimation(.easeInOut(duration: 0.18)) {
                    barOpacity = visible ? 1 : 0
                    showTitle = visible
                }
                print("--------------------")
            }
            .background(Color.jeuneCanvasColor.ignoresSafeArea())
            .toolbarBackground(.ultraThinMaterial.opacity(barOpacity))
            .navigationTitle(showTitle ? "Username" : "")

            .navigationBarTitleDisplayMode(.inline)

            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(systemName: "paintbrush")
                        .fontWeight(.bold)
                        .foregroundColor(.jeuneDarkGray)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showSettings = true }) {
                        Image(systemName: "gearshape")
                            .fontWeight(.bold)
                            .foregroundColor(.jeuneDarkGray)
                    }
                }
            }
            .sheet(isPresented: $showSettings) {
                SettingsView()
            }
        }
    }

    /// Card displaying the user's avatar and stats.
    private var profileCard: some View {
        VStack(spacing: 4) {

            Color.clear.frame(height: 24)


            Text("Username") // GeometryReader removed from here
                .font(.title3.weight(.semibold))

            statsRow
        }
        .padding(.vertical, 16)
        .jeuneCard()
        .background( // GeometryReader attached to the VStack of profileCard
            GeometryReader { geo in
                Color.clear
                    .preference(key: NameOffsetKey.self,
                               value: geo.frame(in: .global).minY + 24.0) // Add offset for Username text
                    .onAppear {
                         print("--- Debug MeView --- GeoReader for profileCard CONTENT appeared. Initial global minY: \(geo.frame(in: .global).minY)")
                    }
                    .onChange(of: geo.frame(in: .global).minY) { oldValue, newValue in
                         print("--- Debug MeView --- GeoReader for profileCard CONTENT global minY changed to: \(newValue)")
                    }
            }
        )
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
        NavigationLink(destination: AchievementsView()) {
            VStack(spacing: 4) {
                Text("ACHIEVEMENTS")
                    .font(.jeuneCaption)
                    .foregroundColor(.jeuneGrayColor)

                HStack(spacing: -4) {
                    ForEach(0..<3) { _ in
                        Circle()
                            .fill(Color.jeunePrimaryDarkColor)
                            .overlay(
                                Circle()
                                    .stroke(Color.white, lineWidth: 1)
                            )
                            .frame(width: 20, height: 20)
                    }
                    Text("+34")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(.black)
                        .padding(.leading, 4)
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
    }

    private var calendarSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            SectionHeaderView(title: "Calendar")
            calendarCard
        }
    }

    private var metricsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            SectionHeaderView(title: "Weekly Metrics", actionTitle: "Manage Weight")
            metricsCard
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
            LegendItem(color: .jeuneNutritionColor, label: "Nutrition")
            LegendItem(color: .jeuneActivityColor, label: "Activity")
            LegendItem(color: .jeuneRestorationColor, label: "Restoration")
            LegendItem(color: .jeuneSleepColor, label: "Sleep")
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

    // MARK: - Recent Fasts Section

    private var recentFastsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            SectionHeaderView(title: "Recent Fasts")
            recentFastsCard
        }
    }

    private var recentFastsCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("AVERAGE")
                        .font(.jeuneCaption)
                        .foregroundColor(.jeuneGrayColor)

                    Text("16h 26m")
                        .font(.title3.weight(.bold))
                        .foregroundColor(.jeuneNearBlack)
                }
                Spacer()
                Text("May 1 - Jun 5")
                    .font(.jeuneCaptionBold)
                    .foregroundColor(.jeuneGrayColor)
            }

            fastBarGraph

                .frame(height: 100)

            fastLegend
                .frame(maxWidth: .infinity, alignment: .center)

            Button(action: {}) {
                Text("Add Fast")
                    .font(.footnote.weight(.semibold))
                    .foregroundColor(.white)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 16)
                    .background(Color.jeunePrimaryDarkColor)
                    .clipShape(Capsule())
            }
            .frame(maxWidth: .infinity)

        }
        .jeuneCard()
    }

    private var fastBarGraph: some View {

        GeometryReader { geo in
            let width = geo.size.width * 0.7
            HStack(alignment: .bottom, spacing: 0) {
                ForEach(fastData.indices, id: \.self) { index in
                    if index != 0 {
                        Spacer(minLength: 0)
                        Rectangle()
                            .fill(Color.jeuneGrayColor.opacity(0.3))
                            .frame(width: 1, height: 70)
                        Spacer(minLength: 0)
                    }

                    FastBar(day: fastData[index])
                }
            }
            .frame(width: width, height: 100, alignment: .bottom)
            .frame(maxWidth: .infinity)
        }

    }

    private var fastLegend: some View {
        HStack(spacing: 16) {
            LegendItem(color: .jeuneSuccessColor, label: "Goal Met")
            LegendItem(color: .jeuneGrayColor, label: "Goal Not Met")
        }
    }

    private var fastData: [FastDay] {
        [

            FastDay(hours: "18h", date: "5/01", completed: true),
            FastDay(hours: "17h", date: "5/02", completed: true),
            FastDay(hours: "15h", date: "5/03", completed: false),
            FastDay(hours: "19h", date: "5/04", completed: true),
            FastDay(hours: "16h", date: "5/05", completed: false),
            FastDay(hours: "20h", date: "5/06", completed: true),
            FastDay(hours: "18h", date: "5/07", completed: true)

        ]
    }

    private struct FastDay {

        var hours: String
        var date: String
        var completed: Bool
    }

    private struct FastBar: View {
        var day: FastDay

        var body: some View {
            VStack(spacing: 4) {
                Text(day.hours)
                    .font(.caption2.weight(.semibold))
                    .foregroundColor(.jeuneNearBlack)

                Capsule()
                    .fill(day.completed ? Color.jeuneSuccessColor : Color.jeuneRingTrackColor)
                    .frame(width: 12, height: day.completed ? 70 : 40)

                Text(day.date)
                    .font(.caption2)
                    .foregroundColor(.jeuneGrayColor)
            }
        }
    }



    /// Preference key for tracking the Y position of the username.
    private struct NameOffsetKey: PreferenceKey {
        static var defaultValue: CGFloat = CGFloat.infinity // Ensures title is initially hidden
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = nextValue()
        }
    }

    /// Preference key used to monitor the scroll offset of the ScrollView.
    private struct ScrollOffsetKey: PreferenceKey {
        static var defaultValue: CGFloat = 0
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = nextValue()
        }
    }



}

#Preview {
    MeView()
}
