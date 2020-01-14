//
//  InputViewPassword2.swift
//  PaperlessMove
//
//  Created by Oleh on 22/09/2019.
//  Copyright © 2019 Billennium. All rights reserved.
//

import Foundation
import  UIKit

class InputViewPassword: DesignableView {

    @IBOutlet weak var customInputView: InputView!
    @IBOutlet weak var button: UIButton!

    var placeholder: String? {
        didSet {
            customInputView.text.placeholder = placeholder
        }
    }

    var imageLogo: UIImage? {
        didSet {
            customInputView.image.image = imageLogo
        }
    }

    var hideText: Bool = false {
        didSet {
            customInputView.text.isSecureTextEntry = hideText
        }
    }

    var textValue: String? {
        return customInputView.text.text
    }

    public var isEmpty: Bool {
        return customInputView.text.text?.isEmpty ?? false
    }

    override func setup() {
        super.setup()
        setupData()
    }

    func setupData() {
        customInputView.hideText = true
        let buttonTitle = "LocalizationLogin.show.localized"
        button.setTitle(buttonTitle, for: .normal)

    }

    @IBAction func showPassword(_ sender: Any) {
        let title = customInputView.hideText
            ? "LocalizationLogin.hide.localized"
            : "LocalizationLogin.show.localized"

        button.setTitle(title, for: .normal)
        customInputView.hideText = !customInputView.hideText
    }
}
