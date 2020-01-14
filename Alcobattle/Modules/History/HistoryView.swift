//
//  HistoryView.swift
//  Alcobattle
//
//  Created by Oleh on 14/01/2020.
//Copyright © 2020 Oleh. All rights reserved.
//

import UIKit

//MARK: HistoryView Class
final class HistoryView: PaperlessUserInterface {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func mainTabAction(_ sender: Any) {
        router.goToMainTab()
    }
    @IBAction func mapViewAction(_ sender: Any) {
        router.goToMapView()
    }
}

//MARK: - HistoryView API
extension HistoryView: HistoryViewApi {
}

// MARK: - HistoryView MVC Components API
extension HistoryView {
    var viewModel: HistoryViewModelApi {
        // swiftlint:disable force_cast
        return _viewModel as! HistoryViewModelApi
        // swiftlint:enable force_cast
    }
    var displayData: HistoryDisplayData {
        // swiftlint:disable force_cast
        return _displayData as! HistoryDisplayData
        // swiftlint:enable force_cast
    }
    
    var router: HistoryRouterApi {
        // swiftlint:disable force_cast
        return _router as! HistoryRouterApi
        // swiftlint:enable force_cast
    }
}
