import SwiftUI
import DesignSystem
import IntroFeature
import SignupFeature

@main
struct SimTongApp: App {

    init() {
        registerProviderFactories()
    }

    var body: some Scene {
        WindowGroup {
            AppComponent().signupComponent.makeView()
        }
    }
}
