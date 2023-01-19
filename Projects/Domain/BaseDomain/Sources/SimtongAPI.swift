import Foundation
import Moya

public protocol SimtongAPI: TargetType {
    var domain: SimtongDomain { get }
    var urlPath: String { get }
    var errorMapping: [Int: Error] { get }
}

extension SimtongAPI {
    public var baseURL: URL {
        URL(string: BaseURLInfo.baseURL) ?? URL(string: "https://www.google.com")!
    }

    public var path: String {
        "\(domain.asDomainPath)\(urlPath)"
    }

    public var headers: [String : String]? {
        ["Content-Type": "application/json"]
    }

    public var validationType: ValidationType {
        .successCodes
    }

    public var errorMapping: [Int: Error] {
        [
            400: NetworkStatusError.badRequest,
            401: NetworkStatusError.unauthorized,
            403: NetworkStatusError.forbidden,
            404: NetworkStatusError.notFound,
            409: NetworkStatusError.conflict,
            429: NetworkStatusError.tooManyRequest,
            500: NetworkStatusError.internalServerError
        ]
    }
}
