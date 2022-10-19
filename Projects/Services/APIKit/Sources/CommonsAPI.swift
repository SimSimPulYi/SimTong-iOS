import Moya
import ErrorModule
import DataMappingModule

public enum CommonsAPI: SimTongAPI {
    case resetPassword(ResetPasswordRequestDTO)
    case reissueToken
    case findEmployeeNumber(FindEmployeeNumberRequestDTO)
    case spotList
    case changePassword(ChangePasswordRequestDTO)
    case checkDuplicateEmail(email: String)
}

public extension CommonsAPI {
    var domain: SimTongDomain {
        .commons
    }

    var urlPath: String {
        switch self {
        case .reissueToken:
            return "/token/reissue"

        case .findEmployeeNumber:
            return "/employee-number"

        case .spotList:
            return "/spot"

        case .resetPassword:
            return "/password"

        case .changePassword:
            return "/password"

        case .checkDuplicateEmail:
            return "/email/duplication"
        }
    }

    var method: Method {
        switch self {
        case .spotList, .findEmployeeNumber, .checkDuplicateEmail:
            return .get

        case .reissueToken, .resetPassword, .changePassword:
            return .put
        }
    }

    var task: Task {
        switch self {
        case .reissueToken, .spotList:
            return .requestPlain

        case let .findEmployeeNumber(req):
            return .requestParameters(parameters: [
                "name": req.name,
                "spotId": req.spotId,
                "email": req.email
            ], encoding: URLEncoding.queryString)

        case let .resetPassword(req):
            return .requestJSONEncodable(req)

        case let .changePassword(req):
            return .requestJSONEncodable(req)

        case let .checkDuplicateEmail(email):
            return .requestParameters(parameters: [
                "email": email
            ], encoding: URLEncoding.queryString)
        }
    }

    var jwtTokenType: JwtTokenType {
        switch self {
        case .changePassword:
            return .accessToken

        case .reissueToken:
            return .refreshToken

        default:
            return .none
        }
    }

    var errorMap: [Int: STError] {
        switch self {
        case .reissueToken:
            return [
                400: .unknown(),
                401: .unknown()
            ]

        case .findEmployeeNumber:
            return [
                400: .unknown(),
                404: .notFoundUserByFindEmployeeNumber
            ]

        case .spotList:
            return [
                500: .internalServerError
            ]

        case .resetPassword:
            return [
                400: .unknown(),
                401: .emailIsNotAuthorizedOrMismatch,
                404: .notFoundUserByResetPassword
            ]

        case .changePassword:
            return [
                400: .unknown(),
                401: .passwordMismatchByChangePassword
            ]

        case .checkDuplicateEmail:
            return [
                400: .unknown(),
                409: .alreadyExistsByEmailOverlap
            ]
        }
    }
}
