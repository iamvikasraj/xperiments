import SwiftUI

struct LiquidGlass: View {
    @State private var selected = 0

    var body: some View {
        TabView(selection: $selected) {
            Text("Home")
                .tag(0)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }

            Text("Search")
                .tag(1)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }

            Text("Wallet")
                .tag(2)
                .tabItem {
                    Image(systemName: "creditcard")
                    Text("Wallet")
                }

            Text("Profile")
                .tag(3)
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}

#Preview {
    LiquidGlass()
}
