import SwiftUI
import DesignSystem
import IntroFeature

@main
struct SimTongApp: App {
    init() {
        registerProviderFactories()
    }

    var body: some Scene {
        WindowGroup {
            NavigationView {
                AppComponent().findAuthInfoComponent.makeView()
            }
        }
    }
}
