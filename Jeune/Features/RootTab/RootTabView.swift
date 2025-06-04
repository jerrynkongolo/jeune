// RootTabView.swift
import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView {
            JeuneHomeView()
                .tabItem {
                    VStack {
                        Image(systemName: "timer")
                        Text("Today")
                            .font(.system(size: 12, weight: .semibold))
                    }
                }

            ExploreView()
                .tabItem {
                    VStack {
                        Image(systemName: "safari")
                        Text("Explore")
                            .font(.system(size: 12, weight: .semibold))
                    }
                }

            MeView()
                .tabItem {
                    VStack {
                        Image(systemName: "person")
                        Text("Me")
                            .font(.system(size: 12, weight: .semibold))
                    }
                }
        }
        // Accent the selected tab with a bright orange that matches the logo.
        .accentColor(.orange)
    }
}
