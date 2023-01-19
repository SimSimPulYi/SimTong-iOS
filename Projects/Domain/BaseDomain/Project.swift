import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePaths.Domain.BaseDomain.rawValue,
    product: .framework,
    targets: [.unitTest],
    externalDependencies: [
        .SPM.Moya
    ],
    internalDependencies: [
        .Shared.GlobalThirdPartyLibrary,
        .Shared.UtilityModule
    ],
    resources: ["Resources/**"]
)
