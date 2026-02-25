
import SwiftUI

struct IslandCardView: View {

    let book: Book

    var body: some View {

        ZStack {
            GlassCard {
                VStack(spacing: 15) {
                    Image("island_pinocchio")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 180)
                        .opacity(book.isLocked ? 0.4 : 1)

                    HStack {
                        Text(book.islandName)
                            .font(.title.bold())
                            .foregroundColor(.black)

                        Spacer()

                        if !book.isLocked {
                            Text("\(book.progress)/8")
                                .foregroundColor(AppTheme.primaryOrange)
                        }
                    }

                    if book.isLocked {
                        Text("🔒 Locked")
                            .foregroundColor(AppTheme.secondaryText)
                    } else {
                        Text("Join \(book.title) on a journey to discover why honesty matters most!")
                            .foregroundColor(AppTheme.secondaryText)

                        ProgressBarView(progress: Double(book.progress) / 8.0)
                    }
                }
            }
            .frame(maxWidth: 500)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)

            if !book.isLocked {
                NavigationLink(destination: ChaptersMapView(book: book)) {
                    EmptyView()
                }
                .opacity(0)
            

            }
        }
    }
}

