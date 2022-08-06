import SwiftUI

public struct DesignSystemPreview: View {
    public init() {}
    let list: [(String, AnyView)] = [
        ("Button", AnyView(STButtonPreview())),
        ("Checkbox", AnyView(STCheckboxPreview())),
        ("Color", AnyView(ColorsPreview())),
        ("Icon", AnyView(IconsPreview())),
        ("TextField", AnyView(STTextFieldPreview())),
        ("Typography", AnyView(STTypoPreview())),
        ("Toast", AnyView(ToastPreview())),
        ("RadioButton", AnyView(STRadioButtonPreview()))
    ]
    public var body: some View {
        NavigationView {
            List(list, id: \.0) { item in
                NavigationLink {
                    item.1
                } label: {
                    Text(item.0)
                }
            }
            .navigationTitle("Design System")
        }
    }
}

struct DesignSystemPreview_Previews: PreviewProvider {
    static var previews: some View {
        DesignSystemPreview()
    }
}
