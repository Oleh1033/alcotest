//
//  CreateAccViewModel.swift
//  Alcobattle
//
//  Created by Oleh on 13/01/2020.
//Copyright © 2020 Oleh. All rights reserved.
//

import Foundation

// MARK: - CreateAccViewModel Class
final class CreateAccViewModel: ViewModel {
}

// MARK: - CreateAccViewModel API
extension CreateAccViewModel: CreateAccViewModelApi {
}

// MARK: - CreateAcc MVC Components
extension CreateAccViewModel {
    var view: CreateAccViewApi {
        // swiftlint:disable force_cast
        return _view as! CreateAccViewApi
        // swiftlint:enable force_cast
    }
    var router: CreateAccRouterApi {
        // swiftlint:disable force_cast
        return _router as! CreateAccRouterApi
        // swiftlint:enable force_cast
    }
}
