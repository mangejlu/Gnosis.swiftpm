import SwiftUI

struct RootView: View {

    var body: some View {
        NavigationStack {
            TabView {
                HomeView()
                    .navigationTitle("Home")
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }

                ProgressViewScreen()
                    .navigationTitle("Progress")
                    .tabItem {
                        Image(systemName: "trophy.fill")
                        Text("Progress")
                    }


            }
        }
        .accentColor(AppTheme.primaryOrange)
    }
}

