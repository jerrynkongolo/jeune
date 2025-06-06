// JeuneApp.swift
// Jeune
//
// Created by Jerry Nkongolo on 02/06/2025.
//

import SwiftUI

@main
struct JeuneApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            RootTabView()
                .preferredColorScheme(.light)
                .environmentObject(appState)
                .fullScreenCover(isPresented: Binding(
                    get: { !appState.onboardingCompleted },
                    set: { _ in }
                )) {
                    OnboardingFlow()
                        .preferredColorScheme(.light)
                        .environmentObject(appState)
                }
        }
    }
}
