import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "MyPageFeature",
    product: .staticFramework,
    dependencies: [
        .Project.Features.BaseFeature
    ]
)