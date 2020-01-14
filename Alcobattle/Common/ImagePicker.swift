//
//  ImagePicker.swift
//  Alcobattle
//
//  Created by Oleh on 13/01/2020.
//  Copyright © 2020 Oleh. All rights reserved.
//

import Foundation
import MobileCoreServices
import UIKit

public protocol ImagePickerDelegate: class {
    func didSelect(image: UIImage, fileName: String)
}

open class ImagePicker: NSObject {

    private let pickerController: UIImagePickerController
    private weak var presentationController: UIViewController?
    private weak var delegate: ImagePickerDelegate?

    public init(presentationController: UIViewController, delegate: ImagePickerDelegate) {
        self.pickerController = UIImagePickerController()
        super.init()

        self.presentationController = presentationController
        self.delegate = delegate
        self.pickerController.delegate = self
        self.pickerController.allowsEditing = false
        self.pickerController.mediaTypes = [kUTTypeImage as String]
    }

    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }

        return UIAlertAction(title: title, style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.pickerController.sourceType = type
            self.presentationController?.present(self.pickerController, animated: true)
        }
    }

    public func present(from sourceView: UIView) {

        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        if let action = action(for: .camera, title: "LocalizationImagePicker.takePhoto.localized") {
            alertController.addAction(action)
        }
        if let action = action(for: .savedPhotosAlbum, title: "LocalizationImagePicker.cameraRoll.localized") {
            alertController.addAction(action)
        }
        if let action = action(for: .photoLibrary, title: "LocalizationImagePicker.photoLibrary.localized") {
            alertController.addAction(action)
        }

        alertController.addAction(UIAlertAction(title: "LocalizationImagePicker.cancel.localized", style: .cancel, handler: nil))

        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.popoverPresentationController?.sourceView = sourceView
            alertController.popoverPresentationController?.sourceRect = sourceView.bounds
            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }

        self.presentationController?.present(alertController, animated: true)
    }

    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?, fileName: String?) {
        controller.dismiss(animated: true) { [weak self] in
            guard let image = image, let fileName = fileName else { return }
            self?.delegate?.didSelect(image: image, fileName: fileName)
        }
    }
}

extension ImagePicker: UIImagePickerControllerDelegate {

    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        pickerController(picker, didSelect: nil, fileName: nil)
    }

    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        let fileUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL
        let today = Date()
        today.toString(dateFormat: "yyyy-MM-dd HH:mm:ss")
        let fileName = fileUrl?.lastPathComponent ??  "\(today).jpeg"
        pickerController(picker, didSelect: image, fileName: fileName)
    }
}

// Because of reasons and delegate: (UIImagePickerControllerDelegate & UINavigationControllerDelegate)
extension ImagePicker: UINavigationControllerDelegate {

}

extension Date {
    func toString( dateFormat format: String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

}
