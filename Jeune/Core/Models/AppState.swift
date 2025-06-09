// AppState.swift
import SwiftUI
import Combine

/// Tabs available in ``RootTabView``.
enum RootTab: Hashable {
    case today
    case explore
    case me
    case plus
}

class AppState: ObservableObject {
    // Placeholder for global app state properties
    // e.g., @Published var currentUser: UserProfile?

    /// Indicates if the onboarding flow has been completed.
    @Published var onboardingCompleted: Bool = false

    /// Indicates if the user has successfully authenticated.
    @Published var isAuthenticated: Bool = false

    /// Currently selected tab in ``RootTabView``.
    @Published var selectedTab: RootTab = .today

    /// Selected segment in ``ExploreView``.
    @Published var exploreSegment: ExploreSegment = .home

    /// Starting screen when presenting ``AuthenticationFlow``.
    @Published var authStartScreen: AuthenticationFlow.Screen = .login

    init() {
        // Initialize state
    }
}
