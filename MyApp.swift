import SwiftUI


@main
struct Gnosis: App {
    @StateObject var progress = UserProgress()
    @StateObject private var progressStore = ProgressStore()
    @AppStorage("hasCompletedStartBook") private var hasCompletedStartBook: Bool = false
    @AppStorage("hasSeenStartBook") private var hasSeenStartBook: Bool = false

    var body: some Scene {
        WindowGroup {
            Group {
                if hasSeenStartBook {
                    RootView()
                } else {
                    StartBookView(onFinished: {
                        hasSeenStartBook = true
                        hasCompletedStartBook = true
                    })
                }
            }
            .environmentObject(progress)
            .environmentObject(progressStore)
        }
    }
}

