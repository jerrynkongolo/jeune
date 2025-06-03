// ToolbarPlusButtonView.swift
import SwiftUI

struct ToolbarPlusButtonView: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(Color.jeuneToolbarCircleColor)
                    .frame(width: 34, height: 34)

                Image(systemName: "plus")
                    .font(.system(.title2).weight(.medium)) // title2 weight, as per spec (medium is a good default for title2 symbols)
                    .foregroundColor(Color.jeunePrimaryColor)
            }
        }
    }
}

#if DEBUG
struct ToolbarPlusButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarPlusButtonView(action: { print("Plus button tapped") })
            .padding()
            .background(Color.gray.opacity(0.2))
            .previewLayout(.sizeThatFits)
    }
}
#endif
