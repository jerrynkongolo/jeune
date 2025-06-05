// RootTabView.swift
import SwiftUI

struct RootTabView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        TabView(selection: $appState.selectedTab) {
            JeuneHomeView()
                .tag(RootTab.today)
                .tabItem {
                    VStack {
                        Image(systemName: "timer")
                        Text("Today")
                            .font(.system(size: 12, weight: .semibold))
                    }
                }

            ExploreView()
                .tag(RootTab.explore)
                .tabItem {
                    VStack {
                        Image(systemName: "safari")
                        Text("Explore")
                            .font(.system(size: 12, weight: .semibold))
                    }
                }

            MeView()
                .tag(RootTab.me)
                .tabItem {
                    VStack {
                        Image(systemName: "person")
                        Text("Me")
                            .font(.system(size: 12, weight: .semibold))
                    }
                }

            GenPlusView()
                .tag(RootTab.plus)
                .tabItem {
                    VStack {
                        Image(systemName: "flame")
                        Text("Jeune+")
                            .font(.system(size: 12, weight: .semibold))
                    }
                }
        }
        // Accent the selected tab with the brand highlight colour.
        .accentColor(.jeuneAccentColor)
    }
}
