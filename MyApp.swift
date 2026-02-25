import SwiftUI

@main
struct Gnosis: App {
    @StateObject var progress = UserProgress()
    @StateObject private var progressStore = ProgressStore()
    @StateObject private var userSettings = UserSettings()
    @State private var showStartBook: Bool = true

    var body: some Scene {
        WindowGroup {
            Group {
                if showStartBook {
                    StartBookView(onFinished: {
                        showStartBook = false
                    })
                } else {
                    RootView()
                }
            }
            .environmentObject(progress)
            .environmentObject(progressStore)
            .environmentObject(userSettings)
        }
    }
}

