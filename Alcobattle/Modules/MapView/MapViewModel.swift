//
//  MapViewModel.swift
//  Alcobattle
//
//  Created by Oleh on 14/01/2020.
//Copyright © 2020 Oleh. All rights reserved.
//

import Foundation

// MARK: - MapViewModel Class
final class MapViewModel: ViewModel {
}

// MARK: - MapViewModel API
extension MapViewModel: MapViewModelApi {
}

// MARK: - Map MVC Components
extension MapViewModel {
    var view: MapViewApi {
        // swiftlint:disable force_cast
        return _view as! MapViewApi
        // swiftlint:enable force_cast
    }
    var router: MapRouterApi {
        // swiftlint:disable force_cast
        return _router as! MapRouterApi
        // swiftlint:enable force_cast
    }
}
