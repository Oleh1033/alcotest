//
//  FloatingInput.swift
//  Alcobattle
//
//  Created by Oleh on 27/08/2019.
//  Copyright © 2019 Oleh. All rights reserved.
//
import Foundation
import UIKit

class FloatingInput: UITextField {
    
    var textLayer: CATextLayer = {
        let textLayer = CATextLayer()
        return textLayer
    }()
    
    let startFontSize: CGFloat = 20
    let endFontSize: CGFloat = 10
    let duration: TimeInterval = 0.3
    
    var typeValidation: String.ValidityType?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    let lineView = UIView()
    
    func setupView() {
        delegate = self
        textLayer.string = "Plaseholder"
        textLayer.fontSize = startFontSize
        textLayer.foregroundColor = UIColor.black.cgColor
        textLayer.frame = CGRect(x: 5, y: 10, width: 200, height: 30)
        lineView.backgroundColor = .blue
        lineView.translatesAutoresizingMaskIntoConstraints = false
        self.borderStyle = .none
        self.addSubview(lineView)
        self.layer.addSublayer(textLayer)
        
        let metrics = ["width" : NSNumber(value: 2)]
        let views = ["lineView" : lineView]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lineView(width)]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
    }
    
    func validation() -> Bool {
        guard let text = self.text else { return false }
        guard let typeValidation = self.typeValidation else { return false }
        if text.isValid(typeValidation) {
            lineView.backgroundColor = .green
            return true
        } else {
            lineView.backgroundColor = .red
            return false
        }
        return false
    }
}

extension FloatingInput: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if self.text?.isEmpty ?? false {
            self.changeColorSize(startFontSize, endFontSize, duration, .red)
            UIView.animate(withDuration: 1, animations: { () -> Void in
                self.textLayer.transform = CATransform3DMakeTranslation(0, -15, 0)
            })
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if self.text?.isEmpty ?? false {
            self.changeColorSize(endFontSize, startFontSize, duration, .blue)
            UIView.animate(withDuration: 1, animations: { () -> Void in
                self.textLayer.transform = CATransform3DMakeTranslation(0, 0, 0)
            })
        }
    }
    
    func changeColorSize(_ startFontSize:CGFloat, _ endFontSize:CGFloat, _ duration: TimeInterval, _ color: UIColor){
        lineView.backgroundColor = color
        textLayer.fontSize = endFontSize
        textLayer.foregroundColor = color.cgColor
        
        let fontSizeAnimation = CABasicAnimation(keyPath: "fontSize")
        fontSizeAnimation.fromValue = startFontSize
        fontSizeAnimation.toValue = endFontSize
        fontSizeAnimation.duration = duration
        fontSizeAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        textLayer.add(fontSizeAnimation, forKey: nil)
        
        let fontColorAnimation = CABasicAnimation(keyPath: "foregroundColor")
        fontColorAnimation.toValue = color.cgColor
        fontColorAnimation.duration = duration
        fontColorAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        textLayer.add(fontColorAnimation, forKey: nil)
    }
}



