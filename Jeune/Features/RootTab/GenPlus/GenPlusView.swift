// GenPlusView.swift
import SwiftUI

struct GenPlusView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Image(systemName: "flame.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.jeunePrimaryDarkColor)
                Text("Jeune+")
                    .font(.title2.bold())
                Text("Subscribe to unlock premium features.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .navigationTitle("Jeune+")
            .background(Color.jeuneCanvasColor.ignoresSafeArea())
        }
    }
}

#Preview {
    GenPlusView()
}
