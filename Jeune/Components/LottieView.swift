import SwiftUI
import Lottie

/// Wrapper to display a Lottie animation file from the app bundle.
struct LottieView: UIViewRepresentable {
    let name: String

    func makeUIView(context: Context) -> some UIView {
        let view = LottieAnimationView(name: name)
        view.contentMode = .scaleAspectFit
        view.loopMode = .loop
        view.play()
        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        // Nothing to update for now
    }
}

#Preview {
    LottieView(name: "sample")
        .frame(height: 100)
}
