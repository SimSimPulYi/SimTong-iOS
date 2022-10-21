import NeedleFoundation
import SwiftUI

public protocol HomeDependency: Dependency {}

public final class HomeComponent: Component<HomeDependency> {
    public func makeView() -> some View {
        Text("A")
    }
}
