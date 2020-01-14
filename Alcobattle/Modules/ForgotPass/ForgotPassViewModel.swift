//
//  ForgotPassViewModel.swift
//  Alcobattle
//
//  Created by Oleh on 13/01/2020.
//Copyright © 2020 Oleh. All rights reserved.
//

import Foundation

// MARK: - ForgotPassViewModel Class
final class ForgotPassViewModel: ViewModel {
}

// MARK: - ForgotPassViewModel API
extension ForgotPassViewModel: ForgotPassViewModelApi {
}

// MARK: - ForgotPass MVC Components
extension ForgotPassViewModel {
    var view: ForgotPassViewApi {
        // swiftlint:disable force_cast
        return _view as! ForgotPassViewApi
        // swiftlint:enable force_cast
    }
    var router: ForgotPassRouterApi {
        // swiftlint:disable force_cast
        return _router as! ForgotPassRouterApi
        // swiftlint:enable force_cast
    }
}
