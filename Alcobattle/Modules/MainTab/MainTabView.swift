//
//  MainTabView.swift
//  Alcobattle
//
//  Created by Oleh on 14/01/2020.
//Copyright © 2020 Oleh. All rights reserved.
//

import UIKit

//MARK: MainTabView Class
final class MainTabView: PaperlessUserInterface {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "onboardingView"
    }
    @IBAction func mapViewAction(_ sender: Any) {
        router.goMapView()
    }
    @IBAction func historyAction(_ sender: Any) {
        router.goToHistory()
    }
    
}

//MARK: - MainTabView API
extension MainTabView: MainTabViewApi {
}

// MARK: - MainTabView MVC Components API
extension MainTabView {
    var viewModel: MainTabViewModelApi {
        // swiftlint:disable force_cast
        return _viewModel as! MainTabViewModelApi
        // swiftlint:enable force_cast
    }
    var displayData: MainTabDisplayData {
        // swiftlint:disable force_cast
        return _displayData as! MainTabDisplayData
        // swiftlint:enable force_cast
    }
    
    var router: MainTabRouterApi {
        // swiftlint:disable force_cast
        return _router as! MainTabRouterApi
        // swiftlint:enable force_cast
    }
}
