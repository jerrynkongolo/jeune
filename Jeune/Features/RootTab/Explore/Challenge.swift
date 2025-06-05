import Foundation

struct Challenge: Identifiable {
    let id = UUID()
    let tag: String
    let title: String
    let duration: String
    let participants: String
    let image: String
}

#if DEBUG
extension Challenge {
    static let sampleChallenges: [Challenge] = [
        Challenge(tag: "Fasting",
                  title: "7 Day Fasting Streak",
                  duration: "7 days",
                  participants: "300k active",
                  image: "jeune7days"),
        Challenge(tag: "Fasting",
                  title: "14 Day Intermittent Fast",
                  duration: "14 days",
                  participants: "250k active",
                  image: "jeune14days"),
        Challenge(tag: "Fasting",
                  title: "4×16 Hour Streak",
                  duration: "4×16h",
                  participants: "110k active",
                  image: "jeune16hours"),
        Challenge(tag: "Fasting",
                  title: "4×20 Hour Streak",
                  duration: "4×20h",
                  participants: "90k active",
                  image: "jeune20hours"),
        Challenge(tag: "Fasting",
                  title: "2×36 Hour Push",
                  duration: "2×36h",
                  participants: "80k active",
                  image: "jeune36hours")
    ]
}
#endif
