import Foundation

public struct SignupRequestDTO: Encodable {
    public init(
        name: String,
        employeeNumber: Int,
        email: String,
        password: String,
        nickname: String? = nil,
        profileImagePath: String? = nil,
        deviceToken: String
    ) {
        self.name = name
        self.employeeNumber = employeeNumber
        self.email = email
        self.password = password
        self.nickname = nickname
        self.profileImagePath = profileImagePath
        self.deviceToken = deviceToken
    }

    public let name: String
    public let employeeNumber: Int
    public let email: String
    public let password: String
    public let nickname: String?
    public let profileImagePath: String?
    public let deviceToken: String

    enum CodingKeys: String, CodingKey {
        case name, email, password, nickname
        case employeeNumber = "employee_number"
        case profileImagePath = "profile_image_path"
        case deviceToken = "device_token"
    }
}
