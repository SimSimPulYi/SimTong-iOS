import NeedleFoundation
import NetworkModule

// MARK: - Commons
extension AppComponent {
    public var remoteCommonsDataSource: any RemoteCommonsDataSource {
        shared {
            RemoteCommonsDataSourceImpl(keychain: keychain)
        }
    }
}

// MARK: - Files
extension AppComponent {
    public var remoteFilesDataSource: any RemoteFilesDataSource {
        shared {
            RemoteFilesDataSourceImpl(keychain: keychain)
        }
    }
}

// MARK: - Users
extension AppComponent {
    public var remoteUsersDataSource: any RemoteUsersDataSource {
        shared {
            RemoteUsersDataSourceImpl(keychain: keychain)
        }
    }
}

// MARK: - Emails
extension AppComponent {
    public var remoteEmailsDataSource: any RemoteEmailsDataSource {
        shared {
            RemoteEmailsDataSourceImpl(keychain: keychain)
        }
    }
}

// MARK: - Menu
extension AppComponent {
    public var remoteMenuDataSource: any RemoteMenuDataSource {
        shared {
            RemoteMenuDataSourceImpl(keychain: keychain)
        }
    }
}
