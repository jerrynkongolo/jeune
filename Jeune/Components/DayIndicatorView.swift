import SwiftUI

/// Circular day indicator used in the home screen week strip.
struct DayIndicatorView: View {
    enum State {
        case selected
        case inactive
        case completed
    }

    var label: String
    var state: State

    private var ringColor: Color {
        switch state {
        case .selected:  return .green
        case .inactive:  return .jeuneRingTrackColor
        case .completed: return .jeuneSuccessColor
        }
    }

    private var textColor: Color {
        switch state {
        case .selected:  return .black
        default:        return .gray
        }
    }

    var body: some View {
        VStack(spacing: 4) {
            Text(label)
                .font(.jeuneCaptionBold)
.foregroundColor(state == .selected ? .jeunePrimaryDarkColor : textColor)

            ZStack {
                // Use a consistent stroke width across all states so gray rings
                // match the thickness of the colored ones.
                let strokeWidth: CGFloat = 4 * 1.25
                let ringSize = (DesignConstants.miniRingDiameter + 8) * 0.7

                Circle()
                    .stroke(ringColor, lineWidth: strokeWidth)
                    .frame(width: ringSize, height: ringSize)

                if state == .selected {
                    Circle()
                        .fill(ringColor)
                        .frame(width: (DesignConstants.miniRingDiameter - 4) * 0.7,
                               height: (DesignConstants.miniRingDiameter - 4) * 0.7)
                }
            }
        }
    }
}

#Preview {
    HStack {
        DayIndicatorView(label: "TUE", state: .selected)
        DayIndicatorView(label: "WED", state: .inactive)
        DayIndicatorView(label: "MON", state: .completed)
    }
}
