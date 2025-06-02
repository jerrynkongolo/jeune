// AppState.swift
import SwiftUI
import Combine

class AppState: ObservableObject {
    // Placeholder for global app state properties
    // e.g., @Published var currentUser: UserProfile?

    /// Indicates if the onboarding flow has been completed.
    @Published var onboardingCompleted: Bool = false

    init() {
        // Initialize state
    }
}
