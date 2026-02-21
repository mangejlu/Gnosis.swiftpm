import SwiftUI


@main
struct Gnosis: App {
    @StateObject var progress = UserProgress()
    @StateObject private var progressStore = ProgressStore()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(progress)
                .environmentObject(progressStore)
        }
    }
}

