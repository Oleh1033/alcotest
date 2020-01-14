//
//  InputView2.swift
//  PaperlessMove
//
//  Created by Oleh on 20/09/2019.
//  Copyright © 2019 Billennium. All rights reserved.
//

import Foundation
import UIKit

class InputView: DesignableView {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var text: UITextField!
    @IBOutlet weak var underline: UIView!

    var placeholder: String? {
        didSet {
            text.placeholder = placeholder
        }
    }

    var imageLogo: UIImage? {
        didSet {
            image.image = imageLogo
        }
    }

    var hideText: Bool = false {
        didSet {
            text.isSecureTextEntry = hideText
        }
    }

    var textValue: String? {
        return text.text
    }

    public var isEmpty: Bool {
        return text.text?.isEmpty ?? false
    }

    override func setup() {
        super.setup()
        setupUI()
    }

    private func setupUI() {
        text.placeholder = ""
        image.image = UIImage(named: "lock")
    }
}
