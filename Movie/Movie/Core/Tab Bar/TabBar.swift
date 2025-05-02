import SwiftUI

struct TabBar: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    VStack {
                        Image(systemName: selectedTab == 0 ? "popcorn.fill" : "popcorn" )
                            .environment(\.symbolVariants, selectedTab == 0 ? .fill : .none)
                    }
                }
                .onAppear { selectedTab = 0 }
                .tag(0)
            
            FavoritesView()
                .tabItem {
                    VStack {
                        Image(systemName: selectedTab == 1 ? "heart.fill" : "heart" )
                            .environment(\.symbolVariants, selectedTab == 1 ? .fill : .none)
                    }
                }.onAppear { selectedTab = 1 }
                .tag(1)
            
            DownloadsView()
                .tabItem {
                    VStack {
                        Image(systemName: selectedTab == 2 ? "arrow.down.app.fill" : "arrow.down.app" )
                            .environment(\.symbolVariants, selectedTab == 2 ? .fill : .none)
                        //Text("Favorites")
                    }
                }.onAppear { selectedTab = 2 }
                .tag(2)
        }
        .tint(.primary)
        
    }
}

#Preview {
    TabBar()
}
