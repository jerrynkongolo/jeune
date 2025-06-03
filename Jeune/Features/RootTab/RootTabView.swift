// RootTabView.swift
import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView {
            JeuneHomeView()
                .tabItem { Label("Today", systemImage: "timer") }

            ExploreView()
                .tabItem { Label("Explore", systemImage: "safari") }

            MeView()
                .tabItem { Label("Me", systemImage: "person") }
        }
        // Accent the selected tab with the brand colour defined in Color+Jeune.
        .accentColor(.jeunePrimaryColor)
    }
}
