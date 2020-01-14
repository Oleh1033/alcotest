//
//  PaperlessUserInterface.swift
//  PaperlessMove
//
//  Created by Piotr Gawlowski on 20/09/2019.
//  Copyright © 2019 Billennium. All rights reserved.
//

//import Moya
import UIKit

protocol PaperlessUserInterfaceProtocol: UserInterfaceProtocol {
    func setupID()
    func setupTranslations()
    func showError(_ err: Error)
//    func showToolbar(_ model: ActionToolbarModel)
    func hideToolbar()

    func startRefreshing()
    func endRefreshing()
}

private enum ErrorCode: Int {
    case sessionExpired = 401
    case authorizationFailed = 403
}

class PaperlessUserInterface: UserInterface, PaperlessUserInterfaceProtocol {

//    var actionToolbar: ActionToolbar?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupID()
        setupTranslations()
        setLogo()
    }

    @objc dynamic
    func setupID() {}

    @objc dynamic
    open func setupTranslations() {}

    open func startRefreshing() {}
    open func endRefreshing() {}

    open func showError(_ err: Error) {
//        Logger.log(.error, "\(err)")
        let error = err.mapPaperlessError()
        handlePaperlessError(error)
    }
}

extension PaperlessUserInterface {
//    func showToolbar(_ model: ActionToolbarModel) {
//        actionToolbar = ActionToolbar()
//        actionToolbar?.setupWith(model)
//        actionToolbar?.show()
//    }

    func hideToolbar() {
//        actionToolbar?.hide()
    }

    func setLogo() {
        let image = UIImage(named: "paperless_logo_title")
        navigationItem.titleView = UIImageView(image: image)
    }
}

private extension PaperlessUserInterface {
    func handlePaperlessError(_ error: PaperlessError) {
        switch error.statusCode {
        case ErrorCode.sessionExpired.rawValue:
            showSessionExpired()
        case ErrorCode.authorizationFailed.rawValue:
//            showError(message: LocalizationPaperless.errorAuthMessage.localized)
            "some error"
        default:
            showError(message: error.message)
        }
    }

    func showSessionExpired() {
//        let module = AppModules.infoPaperless.build()
//        module.router.show(inWindow: AppModules.window,
//                           embedInNavController: false,
//                           setupData: ExpireSession.self,
//                           makeKeyAndVisible: true)
    }

    func showError(message: String?) {
//        let alert = UIAlertController(title: LocalizationPaperless.errorTopTitle.localized,
//                                      message: message,
//                                      preferredStyle: .alert)
//        let closeAction = UIAlertAction(title: LocalizationPaperless.closeButton.localized,
//                                        style: .cancel, handler: nil)
//        alert.addAction(closeAction)
//        present(alert, animated: true, completion: nil)
    }
}

enum ExceptionType: String, Codable {
    case uiException = "Billennium.SharedCore.Exceptions.UIException"
}

private extension Error {
    func mapPaperlessError() -> PaperlessError {
        var cqrsError: CqrsError?
        var statusCode: Int = -1

//        if let error = self as? MoyaError, let data = error.response?.data {
//            statusCode = error.response?.statusCode ?? -1
//            cqrsError = try? CqrsError.decode(from: data)
//        }

        return PaperlessError(statusCode: statusCode, cqrsError: cqrsError)
    }
}

struct CqrsError: Codable {
    let message: String?
    let exceptionMessage: String?
    let stackTrace: String?
    let exceptionType: ExceptionType?
}

struct PaperlessError: Codable {
    let statusCode: Int?
    let cqrsError: CqrsError?

    var message: String {
        "asd"
//        cqrsError?.exceptionMessage ?? LocalizationPaperless.errorGeneralMessage.localized
    }
}
