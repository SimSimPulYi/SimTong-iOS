import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "APIKit",
    product: .staticFramework,
    dependencies: [
        .Project.Module.ThirdPartyLib,
        .Project.Module.ErrorModule,
        .Project.Module.KeychainModule,
        .Project.Module.Utility,
        .Project.Service.DataMappingModule,

        .SPM.Moya
    ]
)
