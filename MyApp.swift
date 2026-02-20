import SwiftUI


@main
struct Gnosis: App {
    @StateObject var progress = UserProgress()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(progress)
        }
    }
}
