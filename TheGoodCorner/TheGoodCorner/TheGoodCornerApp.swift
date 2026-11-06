import SwiftUI

@main
struct TheGoodCornerApp: App {
    @StateObject private var container = DependencyContainer()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(container)
        }
    }
}
