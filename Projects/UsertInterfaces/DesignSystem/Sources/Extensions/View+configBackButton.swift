import SwiftUI

public extension View {
    func configBackButton(willDismiss: @escaping () -> Void = {}, dismiss: DismissAction) -> some View {
        self
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button {
                        willDismiss()
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .frame(width: 9, height: 16)
                            .foregroundColor(.gray09)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
    }
}

extension UINavigationController: ObservableObject, UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
