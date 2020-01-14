//
//  ForgotPassView.swift
//  Alcobattle
//
//  Created by Oleh on 13/01/2020.
//Copyright © 2020 Oleh. All rights reserved.
//

import UIKit

//MARK: ForgotPassView Class
final class ForgotPassView: PaperlessUserInterface {
    
    @IBOutlet weak var inputEmailView: FloatingInput!
    @IBOutlet weak var buttonSend: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func buttonSendAction(_ sender: Any) {
        
        print(inputEmailView.text)
    }
    
}

//MARK: - ForgotPassView API
extension ForgotPassView: ForgotPassViewApi {
}

// MARK: - ForgotPassView MVC Components API
extension ForgotPassView {
    var viewModel: ForgotPassViewModelApi {
        // swiftlint:disable force_cast
        return _viewModel as! ForgotPassViewModelApi
        // swiftlint:enable force_cast
    }
    var displayData: ForgotPassDisplayData {
        // swiftlint:disable force_cast
        return _displayData as! ForgotPassDisplayData
        // swiftlint:enable force_cast
    }
    
    var router: ForgotPassRouterApi {
        // swiftlint:disable force_cast
        return _router as! ForgotPassRouterApi
        // swiftlint:enable force_cast
    }
}
