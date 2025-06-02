// TodayView.swift
import SwiftUI

struct TodayView: View {
    var body: some View {
        NavigationView {
            Text("Today View")
                .font(.jeuneLargeTitle) // Uses font from Font+Jeune.swift
                .navigationTitle("Today")
        }
    }
}
