// JeuneHomeView.swift
import SwiftUI

struct JeuneHomeView: View {
    // ViewModel and State properties will be added here later
    // For example: @StateObject private var viewModel = JeuneHomeViewModel()
    // Placeholder for streak count, will be moved to ViewModel
    @State private var streakCount: Int = 3 
    // Placeholder for logo name, ensure this asset exists in Assets.xcassets
    private let logoName = "jeuneLogoMark" 

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) { // Overall spacing handled by padding on components
                    // Custom Toolbar
                    HStack {
                        StreakBadgeView(streakCount: streakCount)
                        
                        Spacer()
                        
                        Image(logoName) // Assumes 'jeuneLogoMark' asset exists
                            .resizable()
                            .scaledToFit()
                            .frame(height: 32)
                        
                        Spacer()
                        
                        ToolbarPlusButtonView {
                            // Action for plus button
                            print("Plus button tapped")
                        }
                    }
                    .padding(.horizontal) // Standard horizontal padding for toolbar items
                    .padding(.top) // Padding from the top safe area
                    .padding(.bottom, 12) // Gap to WeekdayMiniRingStrip

                    WeekdayMiniRingStripView()
                        .padding(.bottom, 20) // Gap to FastTimerCardView

                    FastTimerCardView() // Placeholder data will be used from its own @State for now
                        .padding(.bottom, 24) // Gap to ChallengeCardView

                    ChallengeCardView() // Placeholder data will be used from its own @State for now
                        .padding(.bottom, 20) // Final padding at the bottom of the scroll content
                    
                    // Spacer() // Ensures content pushes to the top - may not be needed if content fills screen
                }
                .padding(.bottom) // Add some overall bottom padding to the VStack content inside ScrollView
            }
            .background(Color.jeuneBGLightColor.ignoresSafeArea()) // Or your canvas color
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarHidden(true) // Hide default navigation bar as we have a custom one
        }
        .navigationViewStyle(.stack)
    }
}

#if DEBUG
struct JeuneHomeView_Previews: PreviewProvider {
    static var previews: some View {
        JeuneHomeView()
            .environmentObject(AppState()) // If your view or subviews need it
    }
}
#endif
