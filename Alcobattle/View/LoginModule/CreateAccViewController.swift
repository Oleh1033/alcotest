//
//  CreateAccViewController.swift
//  Alcobattle
//
//  Created by Oleh on 27/08/2019.
//  Copyright © 2019 Oleh. All rights reserved.
//

import UIKit
import CommonCrypto

class CreateAccViewController: UIViewController {

    
    @IBOutlet weak var nameInput: FloatingInput!
    @IBOutlet weak var surnameInput: FloatingInput!
    @IBOutlet weak var emailInput: FloatingInput!
    @IBOutlet weak var passwordInput: FloatingInput!
    @IBOutlet weak var oneMoreTimePass: FloatingInput!
    @IBOutlet weak var createButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setVie()
        
        nameInput.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        surnameInput.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        emailInput.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        passwordInput.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        oneMoreTimePass.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
         
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func creatAction(_ sender: Any) {

        if  nameInput.validation() && surnameInput.validation() && emailInput.validation() && passwordInput.validation() {
            if oneMoreTimePass.text == passwordInput.text {
                print("Validation succes!!!")
            } else {
                print("pasword dont Match!")
            }
            
        } else {
            print("Error! wrong validation")
        }
    }
    
    
    @objc func textFieldDidChange(sender: FloatingInput) {
        sender.validation()
        if sender == oneMoreTimePass {
            if oneMoreTimePass.text != passwordInput.text {
                print("pasword dont Match!")
                oneMoreTimePass.lineView.backgroundColor = .red
            }
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setVie() {
        nameInput.textLayer.string = "Name"
        surnameInput.textLayer.string = "Surname"
        emailInput.textLayer.string = "Email"
        passwordInput.textLayer.string = "Password"
        oneMoreTimePass.textLayer.string = "Repeat Password"
        
        nameInput.typeValidation = .name
        surnameInput.typeValidation = .name
        emailInput.typeValidation = .email
        passwordInput.typeValidation = .password
        oneMoreTimePass.typeValidation = .password
    }
}
