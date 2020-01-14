//
//  CreateAccView.swift
//  Alcobattle
//
//  Created by Oleh on 13/01/2020.
//Copyright © 2020 Oleh. All rights reserved.
//

import UIKit

//MARK: CreateAccView Class
final class CreateAccView: PaperlessUserInterface {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: - CreateAccView API
extension CreateAccView: CreateAccViewApi {
}

// MARK: - CreateAccView MVC Components API
extension CreateAccView {
    var viewModel: CreateAccViewModelApi {
        // swiftlint:disable force_cast
        return _viewModel as! CreateAccViewModelApi
        // swiftlint:enable force_cast
    }
    var displayData: CreateAccDisplayData {
        // swiftlint:disable force_cast
        return _displayData as! CreateAccDisplayData
        // swiftlint:enable force_cast
    }
    
    var router: CreateAccRouterApi {
        // swiftlint:disable force_cast
        return _router as! CreateAccRouterApi
        // swiftlint:enable force_cast
    }
}
