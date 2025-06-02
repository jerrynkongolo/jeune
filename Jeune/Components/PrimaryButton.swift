import SwiftUI

struct PrimaryButton: View {
    let title: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.jeunePrimaryColor)
                .cornerRadius(12)
        }
        .padding(.horizontal, 40)
    }
}

#Preview {
    PrimaryButton(title: "Continue") {}
}
