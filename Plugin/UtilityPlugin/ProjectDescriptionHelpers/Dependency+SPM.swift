// swiftlint:disable all
import ProjectDescription

public extension TargetDependency {
    struct SPM {}
}

public extension TargetDependency.SPM {
    static let Lottie = TargetDependency.external(name: "Lottie")
}
