// FastTimerCardView.swift
import SwiftUI

struct FastTimerCardView: View {
    // Placeholder ViewModel data - replace with actual ViewModel
    @State var progress: Double = 0.65 // Example progress
    @State var timeString: String = "14:36:42"
    @State var isFasting: Bool = true
    @State var elapsedLabel: String = "ELAPSED"
    @State var percentageLabel: String = "(112 %)" // Example, could be part of elapsedLabel or separate
    
    // Placeholder for stats - this would come from a ViewModel
    struct StatDetail: Identifiable {
        let id = UUID()
        var title: String
        var value: String
    }
    @State var stats: [StatDetail] = [
        StatDetail(title: "STARTED", value: "SUN, 19:00"),
        StatDetail(title: "13H GOAL", value: "MON, 08:00")
    ]

    private var ringProgressColor: Color {
        progress >= 1.0 ? Color.jeuneSuccessColor : Color.jeunePrimaryColor
    }
    
    private var ctaButtonColor: Color {
        isFasting ? Color.jeuneSuccessColor : Color.jeunePrimaryColor
    }
    private var ctaButtonText: String {
        isFasting ? "End Fast" : "Start Fast"
    }

    var body: some View {
        VStack(spacing: 0) { // Main container for the card content
            // Large Ring and Timer digits
            ZStack {
                Circle() // Track
                    .stroke(Color.jeuneRingTrackColor, lineWidth: 24)

                Circle() // Progress
                    .trim(from: 0, to: CGFloat(min(progress, 1.0)))
                    .stroke(ringProgressColor, style: StrokeStyle(lineWidth: 24, lineCap: .round))
                    .rotationEffect(.degrees(-90)) // Start from the top
                
                VStack(spacing: 2) { // Timer digits and sub-caption
                    Text(timeString)
                        .font(.system(size: 64, weight: .black, design: .rounded))
                        .foregroundColor(Color.primary) // Adapts to light/dark mode
                    
                    Text("\(elapsedLabel.uppercased()) \(percentageLabel)")
                        .font(.caption.weight(.semibold))
                        .foregroundColor(Color.jeuneGrayColor)
                }
            }
            .frame(width: 280, height: 280)
            .padding(.bottom, 24) // Spacing before stats or CTA

            // Stats Capsules Row (visible only when fasting)
            if isFasting && !stats.isEmpty {
                HStack(spacing: 8) {
                    ForEach(stats) { stat in
                        VStack {
                            Text(stat.title.uppercased())
                                .font(.caption2)
                                .foregroundColor(Color.jeuneGrayColor)
                            Text(stat.value)
                                .font(.subheadline.weight(.semibold))
                                .foregroundColor(Color.primary)
                        }
                        .frame(maxWidth: .infinity, minHeight: 48)
                        .padding(.vertical, 8) // Add some vertical padding inside capsule
                        .background(Color.jeuneStatsBGColor)
                        .cornerRadius(20)
                    }
                }
                .padding(.bottom, 24) // Spacing before CTA
            }

            // Primary CTA Button
            Button(action: {
                // CTA action - toggle fasting state or similar
                isFasting.toggle()
            }) {
                Text(ctaButtonText)
                    .font(.headline.weight(.semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 54)
                    .background(ctaButtonColor)
                    .clipShape(Capsule(style: .continuous)) // Pill radius 28pt (height 56 / 2)
            }
        }
        .padding(.horizontal, 16) // Inner horizontal padding for the card content
        .padding(.vertical, 24)   // Inner vertical padding for the card content
        .background(Color.jeuneCardColor) // Use a defined card background color, assuming white or system material
        .cornerRadius(24)
        .shadow(color: Color.black.opacity(0.10), radius: 20, x: 0, y: 2) // Shadow
        .padding(.horizontal, 16) // Outer horizontal padding from screen edge
    }
}

#if DEBUG
struct FastTimerCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FastTimerCardView(progress: 0.75, timeString: "10:25:15", isFasting: true, elapsedLabel: "ELAPSED", percentageLabel: "(75%)")
                .previewDisplayName("Fasting State")

            FastTimerCardView(progress: 0.0, timeString: "00:00:00", isFasting: false, elapsedLabel: "SINCE LAST FAST", percentageLabel: "", stats: [])
                .previewDisplayName("Not Fasting State")
            
            FastTimerCardView(progress: 1.0, timeString: "16:00:00", isFasting: true, elapsedLabel: "COMPLETED", percentageLabel: "(100%)")
                .previewDisplayName("Fasting Complete")
        }
        .padding()
        .background(Color.jeuneBGLightColor)
        .previewLayout(.sizeThatFits)
    }
}
#endif
