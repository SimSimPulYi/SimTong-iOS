import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "GuestFeature",
    product: .staticFramework,
    dependencies: [
        .Project.Features.BaseFeature
    ]
)
