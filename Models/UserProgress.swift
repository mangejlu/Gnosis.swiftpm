
import Foundation

enum AppTab: Hashable {
    case home
    case chapters
    case progress
    case settings
}

class UserProgress: ObservableObject {
    @Published var streak: Int = 7
    @Published var stars: Int = 245

    @Published var selectedTab: AppTab = .chapters
}
