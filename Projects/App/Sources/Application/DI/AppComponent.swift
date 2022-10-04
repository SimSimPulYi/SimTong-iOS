import NeedleFoundation
import SwiftUI
import RootFeature
import IntroFeature
import FindAuthInfoFeature

final class AppComponent: BootstrapComponent {
    func makeRootView() -> some View {
        rootComponent.makeView()
    }

    var rootComponent: RootComponent {
        RootComponent(parent: self)
    }

    var testComponent: FindingAuthInfoTabComponent {
        FindingAuthInfoTabComponent(parent: self)
    }
}

// MARK: - Auth
extension AppComponent {
    var introComponent: IntroComponent {
        IntroComponent(parent: self)
    }
}
