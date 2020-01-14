////
////  AppLockHelper.swift
////  Alcobattle
////
////  Created by Oleh on 13/01/2020.
////  Copyright © 2020 Oleh. All rights reserved.
////
//
//import Keys
//import LocalAuthentication
//import SwiftyUserDefaults
//import Valet
//
//private enum AppLockConstants {
//    static let pincode = PaperlessMoveKeys().keychainPincode
//    static let credentials = PaperlessMoveKeys().keychainCredentials
//    static let identifier = PaperlessMoveKeys().keychainIdentifier
//}
//
//final class AppLockHelper {
//    enum LockMode: Int, DefaultsSerializable {
//        case biometry
//        case pincode
//    }
//
//    private static let valet = Valet.valet(with: Identifier(nonEmpty: AppLockConstants.identifier)!, accessibility: .whenUnlockedThisDeviceOnly)
//
//    private let context = LAContext()
//    private var savedPin: String? {
//        get {
//            return AppLockHelper.valet.string(forKey: AppLockConstants.pincode)
//        }
//        set {
//            guard let newValue = newValue else { return }
//            AppLockHelper.valet.set(string: newValue, forKey: AppLockConstants.pincode)
//        }
//    }
//
//    private var savedCedentials: UserCredentials? {
//        get {
//            guard let value = AppLockHelper.valet.object(forKey: AppLockConstants.credentials) else {
//                return nil
//            }
//            do {
//                return try UserCredentials.decode(from: value)
//            } catch {
//                optionalFatalError(error.localizedDescription)
//                return nil
//            }
//        }
//        set {
//            do {
//                let newValue = try newValue.encoded()
//                AppLockHelper.valet.set(object: newValue, forKey: AppLockConstants.credentials)
//            } catch {
//                optionalFatalError(error.localizedDescription)
//            }
//        }
//    }
//
//    private func isPinCodeValid(_ code: String) -> Bool {
//        return code == savedPin
//    }
//}
//
//// MARK: - Public methods
//extension AppLockHelper {
//    func evaluateSensor(completion: @escaping (Bool, Error?) -> Void) {
//        let policy: LAPolicy = .deviceOwnerAuthentication
//        var error: NSError?
//
//        guard context.canEvaluatePolicy(policy, error: &error) else { return }
//        let localizedReason = LocalizationScanner.biometryEvaluationReason.localized
//        context.evaluatePolicy(policy, localizedReason: localizedReason) { success, error in
//            completion(success, error)
//        }
//    }
//
//    func setCredentials(_ credentials: UserCredentials) {
//        savedCedentials = credentials
//    }
//
//    @discardableResult
//    func setPinCode(_ code: String, confirmationPin: String) -> Bool {
//        if code == confirmationPin {
//            savedPin = code
//            return true
//        } else {
//            return false
//        }
//    }
//
//    func removePinCode() {
//        AppLockHelper.valet.removeObject(forKey: AppLockConstants.pincode)
//    }
//
//    func accessCredentials(_ mode: LockMode?, _ code: String? = nil,
//                           onSuccess: @escaping (UserCredentials) -> Void,
//                           onError: @escaping (Error) -> Void) {
//        let defaultError = NSError(domain: LocalizationErrors.invalidAuthMode.localized, code: 0)
//
//        switch mode {
//        case .biometry?:
//            evaluateSensor { [weak self] success, _ in
//                guard let credentials = self?.savedCedentials, success else {
//                    return
//                }
//                onSuccess(credentials)
//            }
//        case .pincode?:
//            if isPinCodeValid(code ?? "") {
//                guard let credentials = savedCedentials else { return }
//                onSuccess(credentials)
//            } else {
//                onError(NSError(domain: LocalizationErrors.invalidPin.localized, code: 0))
//            }
//        default:
//            onError(defaultError)
//        }
//    }
//
//    func getLogin() -> String? {
//        guard let credentials = savedCedentials else { return nil }
//        return credentials.login
//    }
//}
