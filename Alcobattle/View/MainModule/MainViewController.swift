//
//  MainViewController.swift
//  Alcobattle
//
//  Created by Oleh on 26/08/2019.
//  Copyright © 2019 Oleh. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var logOut: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Authorization.shared.isValidToken()
    }
    
    @IBAction func logOut(_ sender: Any) {
        CommonAuth.shared.logOut()
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") else { return }
        self.present(vc, animated: true, completion:  nil)
    }
}
