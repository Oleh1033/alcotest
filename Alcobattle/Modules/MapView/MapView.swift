//
//  MapView.swift
//  Alcobattle
//
//  Created by Oleh on 14/01/2020.
//Copyright © 2020 Oleh. All rights reserved.
//

import UIKit

//MARK: MapView Class
final class MapView: PaperlessUserInterface {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: - MapView API
extension MapView: MapViewApi {
}

// MARK: - MapView MVC Components API
extension MapView {
    var viewModel: MapViewModelApi {
        // swiftlint:disable force_cast
        return _viewModel as! MapViewModelApi
        // swiftlint:enable force_cast
    }
    var displayData: MapDisplayData {
        // swiftlint:disable force_cast
        return _displayData as! MapDisplayData
        // swiftlint:enable force_cast
    }
    
    var router: MapRouterApi {
        // swiftlint:disable force_cast
        return _router as! MapRouterApi
        // swiftlint:enable force_cast
    }
}
