//
//  CreateAccRouter.swift
//  Alcobattle
//
//  Created by Oleh on 13/01/2020.
//Copyright © 2020 Oleh. All rights reserved.
//

import Foundation

// MARK: - CreateAccRouter class
final class CreateAccRouter: Router {
}

// MARK: - CreateAccRouter API
extension CreateAccRouter: CreateAccRouterApi {
}

// MARK: - CreateAcc MVC Components
extension CreateAccRouter {
    var viewModel: CreateAccViewModelApi {
        // swiftlint:disable force_cast
        return _viewModel as! CreateAccViewModelApi
        // swiftlint:enable force_cast
    }
}
