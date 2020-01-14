//
//  MapRouter.swift
//  Alcobattle
//
//  Created by Oleh on 14/01/2020.
//Copyright © 2020 Oleh. All rights reserved.
//

import Foundation

// MARK: - MapRouter class
final class MapRouter: Router {
}

// MARK: - MapRouter API
extension MapRouter: MapRouterApi {
}

// MARK: - Map MVC Components
extension MapRouter {
    var viewModel: MapViewModelApi {
        // swiftlint:disable force_cast
        return _viewModel as! MapViewModelApi
        // swiftlint:enable force_cast
    }
}
