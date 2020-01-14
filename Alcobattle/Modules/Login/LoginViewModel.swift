//
//  LoginViewModel.swift
//  Alcobattle
//
//  Created by Oleh on 13/01/2020.
//Copyright © 2020 Oleh. All rights reserved.
//

import Foundation

// MARK: - LoginViewModel Class
final class LoginViewModel: ViewModel {
}

// MARK: - LoginViewModel API
extension LoginViewModel: LoginViewModelApi {
}

// MARK: - Login MVC Components
extension LoginViewModel {
    var view: LoginViewApi {
        // swiftlint:disable force_cast
        return _view as! LoginViewApi
        // swiftlint:enable force_cast
    }
    var router: LoginRouterApi {
        // swiftlint:disable force_cast
        return _router as! LoginRouterApi
        // swiftlint:enable force_cast
    }
}
