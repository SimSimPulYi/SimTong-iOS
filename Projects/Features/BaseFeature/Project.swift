import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "BaseFeature",
    product: .staticFramework,
    dependencies: [
        .Project.Service.Domain,
        .Project.Module.Utility,
        .Project.UserInterfaces.DesignSystem,
        .Project.UserInterfaces.LocalizableManager,

        .SPM.Needle
    ]
)
