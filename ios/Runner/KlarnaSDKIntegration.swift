//
//  KlarnaPaymentViewModel.swift
//  FlexiCharge
//
//  Created by Daniel Göthe on 2021-09-27.
//
// Modified by Gustav Persson on 2022-09-23
//
import Foundation
import KlarnaMobileSDK
import SwiftUI

final class KlarnaSDKIntegration: ObservableObject {
    weak var viewControllerDelegate: ViewControllerDelegate?
    @Published var isKlarnaPaymentDone: Bool = false
    @Published var klarnaStatus: String = ""
    @Published var thisTransactionID: Int?
    private(set) var paymentView: KlarnaPaymentView?
    private let flexiChargeApiUrl = "http://18.202.253.30:8080"
    var result: AnyObject?
    
    func getKlarnaSession(chargerIdInput: Binding<String>) {

        let chargerId: String? = chargerIdInput.wrappedValue
        guard let url = URL(string: "\(flexiChargeApiUrl)/transactions/session") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        let jsonDictionary: [String: Any] = [
            "userID": "2i3h52-3kn34k6-2k3n5",
            "chargerID": chargerId as Any
        ]
        let data = try! JSONSerialization.data(withJSONObject: jsonDictionary, options: .prettyPrinted)
        URLSession.shared.uploadTask(with: request, from: data) { (responseData, response, error) in
            if error != nil {
                return
            }
            if let responseCode = (response as? HTTPURLResponse)?.statusCode, let responseData = responseData {
                guard responseCode == 201 else {
                    return
                }
                if let responseJSONData = try? JSONSerialization.jsonObject(with: responseData, options: .allowFragments) {
                    DispatchQueue.main.async {
                        self.result = responseJSONData as AnyObject
                        self.createPaymentView()
                    }
                }
            }
        }.resume()
    }
    
    public func createPaymentView() {
        self.paymentView = KlarnaPaymentView(category: "pay_now", eventListener: self)
        self.paymentView!.initialize(clientToken: result!["client_token"] as! String, returnUrl: URL(string:"flexiChargeUrl://")!)
    }
    
    func SendKlarnaToken(transactionID: Int, authorization_token: String, completion: @escaping (String) -> Void){
        guard let url = URL(string: "\(flexiChargeApiUrl)/transactions/start/:" + String(transactionID)) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        let jsonDictionary: [String: Any] = [
            "transactionID": transactionID,
            "authorization_token": authorization_token
        ]
        let data = try! JSONSerialization.data(withJSONObject: jsonDictionary, options: .prettyPrinted)
        URLSession.shared.uploadTask(with: request, from: data) { (responseData, response, error) in
            if error != nil {
                return
            }
            if let responseCode = (response as? HTTPURLResponse)?.statusCode, let responseData = responseData {
                guard responseCode == 201 else {
                    return
                }
                if let responseJSONData = try? JSONSerialization.jsonObject(with: responseData, options: .allowFragments) {
                    DispatchQueue.main.async {
                        let responseDataAsString = responseJSONData as? String
                        completion(responseDataAsString ?? "Accepted")
                    }
                }
            }
        }.resume()
    }
}


extension KlarnaSDKIntegration: KlarnaPaymentEventListener {
    func klarnaInitialized(paymentView: KlarnaPaymentView) {
        paymentView.load()
    }
    
    func klarnaLoaded(paymentView: KlarnaPaymentView) {
        paymentView.authorize()
    }
    
    func klarnaLoadedPaymentReview(paymentView: KlarnaPaymentView) {
        
    }
    
    func klarnaAuthorized(paymentView: KlarnaPaymentView, approved: Bool, authToken: String?, finalizeRequired: Bool) {
        if let token = authToken {
            let transactionID = result!["transactionID"] as! Int
            SendKlarnaToken(transactionID: transactionID, authorization_token: token) { _ in
                DispatchQueue.main.async {
                    self.isKlarnaPaymentDone = true
                    self.klarnaStatus = "Accepted"
                    self.thisTransactionID = transactionID
                }
            }
        }
        if finalizeRequired == true {
            paymentView.finalise()
        }
    }
    
    func klarnaReauthorized(paymentView: KlarnaPaymentView, approved: Bool, authToken: String?) {
        if let token = authToken {
            let transactionID = result!["transactionID"] as! Int
            SendKlarnaToken(transactionID: transactionID, authorization_token: token) { _ in
                DispatchQueue.main.async {
                    self.isKlarnaPaymentDone = true
                    self.klarnaStatus = "Accepted"
                }
            }
        }
    }
    
    func klarnaFinalized(paymentView: KlarnaPaymentView, approved: Bool, authToken: String?) {
        if let token = authToken {
            let transactionID = result!["transactionID"] as! Int
            SendKlarnaToken(transactionID: transactionID, authorization_token: token) { _ in
                DispatchQueue.main.async {
                    self.isKlarnaPaymentDone = true
                    self.klarnaStatus = "Accepted"
                }
            }
        }
    }
    
    func klarnaResized(paymentView: KlarnaPaymentView, to newHeight: CGFloat) {
    }
    
    func klarnaFailed(inPaymentView paymentView: KlarnaPaymentView, withError error: KlarnaPaymentError) {
        DispatchQueue.main.async {
            self.klarnaStatus = error.message
        }
    }
}
