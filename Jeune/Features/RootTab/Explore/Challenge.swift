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
        Challenge(tag: "Fasting", title: "7 Day Fasting Streak", duration: "7 days", participants: "300k active", image: "flame.fill"),
        Challenge(tag: "Fasting", title: "14 Day Intermittent Fast", duration: "14 days", participants: "250k active", image: "flame.fill"),
        Challenge(tag: "Fasting", title: "21 Day Cleanse", duration: "21 days", participants: "120k active", image: "drop.fill"),
        Challenge(tag: "Fasting", title: "30 Day Keto Fast", duration: "30 days", participants: "75k active", image: "leaf.fill"),
        Challenge(tag: "Fasting", title: "4x16 Hour Streak", duration: "4x16h", participants: "110k active", image: "timer"),
        Challenge(tag: "Fasting", title: "4x20 Hour Streak", duration: "4x20h", participants: "90k active", image: "timer"),
        Challenge(tag: "Fasting", title: "2x36 Hour Push", duration: "2x36h", participants: "80k active", image: "bolt.fill"),
        Challenge(tag: "Fasting", title: "Weekend Warrior", duration: "2 days", participants: "140k active", image: "sun.min"),
        Challenge(tag: "Fasting", title: "Lean Up Month", duration: "1 month", participants: "60k active", image: "hare.fill"),
        Challenge(tag: "Fasting", title: "3 Month Transformation", duration: "3 months", participants: "45k active", image: "sparkles")
    ]
}
#endif
