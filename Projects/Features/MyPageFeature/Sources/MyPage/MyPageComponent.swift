import DomainModule
import NeedleFoundation
import SwiftUI

public protocol MyPageDependency: Dependency {
    var fetchMyProfileUseCase: any FetchMyProfileUseCase { get }
    var logoutUseCase: any LogoutUseCase { get }
    var nicknameChangeComponent: NicknameChangeComponent { get }
    var emailModifyComponent: EmailModifyComponent { get }
    var spotChangeComponent: SpotChangeComponent { get }
    var passwordCheckComponent: PasswordCheckComponent { get }
}

public final class MyPageComponent: Component<MyPageDependency> {
    public func makeView() -> some View {
        MyPageView(
            viewModel: .init(
                fetchMyProfileUseCase: dependency.fetchMyProfileUseCase,
                logoutUseCase: dependency.logoutUseCase
            ),
            nicknameChangeComponent: dependency.nicknameChangeComponent,
            emailModifyComponent: dependency.emailModifyComponent,
            spotChangeComponent: dependency.spotChangeComponent,
            passwordCheckComponent: dependency.passwordCheckComponent
        )
    }
}
