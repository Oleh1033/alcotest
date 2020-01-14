//
//  RememberPassViewController.swift
//  Alcobattle
//
//  Created by Oleh on 27/08/2019.
//  Copyright © 2019 Oleh. All rights reserved.
//

import UIKit

class RememberPassViewController: UIViewController {

    
    @IBOutlet weak var emailInput: FloatingInput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        setView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func sendRememberEmail(_ sender: Any) {
        
        
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension RememberPassViewController {
    func setView() {
        self.emailInput.textLayer.string = "Email"
        self.emailInput.typeValidation = .email
        self.emailInput.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(sender: FloatingInput) {
        sender.validation()
    }
}
