import DomainModule
import DataMappingModule

public struct ChangePasswordUseCaseImpl: ChangePasswordUseCase {
    private let usersRepository: any UsersRepository

    public init(usersRepository: any UsersRepository) {
        self.usersRepository = usersRepository
    }

    public func execute(req: ChangePasswordRequestDTO) async throws {
        try await usersRepository.changePassword(req: req)
    }
}
