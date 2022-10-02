//
//  KlarnaPaymentView.swift
//  FlexiCharge
//
//  Created by Daniel Göthe on 2021-09-27.
//
// Modified by Gustav Persson on 2022-09-23.
//
import UIKit
import SwiftUI
import KlarnaMobileSDK
import Flutter


public protocol ViewControllerDelegate: AnyObject {
    func displayPaymentView()
}


struct KlarnaView: View {
    @Binding var result: FlutterResult
    @Binding var isPresented: Bool
    @Binding var klarnaStatus: String
    @Binding var chargerIdInput: String
    @Binding var transactionID: Int
    @ObservedObject var sdkIntegration: KlarnaSDKIntegration = KlarnaSDKIntegration()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    init(isPresented: Binding<Bool>, klarnaStatus: Binding<String>, chargerIdInput: Binding<String>, transactionID: Binding<Int>, result: Binding<FlutterResult>) {
        self._isPresented = isPresented
        self._klarnaStatus = klarnaStatus
        self._chargerIdInput = chargerIdInput
        self._transactionID = transactionID
        self._result = result
        sdkIntegration.getKlarnaSession(chargerIdInput: chargerIdInput)
    }
    
    var body: some View {
        VStack {
            /*AsyncImage(url: URL(string: "https://i.imgur.com/bYV3h6Q.png")).frame(maxWidth: 300, maxHeight: 200)
            Spacer()
            ProgressView().progressViewStyle(CircularProgressViewStyle())
            Spacer()
            Spacer()*/
        }.onChange(of: sdkIntegration.isKlarnaPaymentDone, perform: { _ in
            klarnaStatus = sdkIntegration.klarnaStatus
            transactionID = sdkIntegration.thisTransactionID ?? 0
            isPresented = false
            result(transactionID)
            self.presentationMode.wrappedValue.dismiss()
        })
        .hidden()
    }
}


struct InitializeKlarna: UIViewControllerRepresentable, View {
    @Binding var isPresented: Bool
    @Binding var klarnaStatus: String
    @Binding var chargerIdInput: String
    @Binding var transactionID: Int
    @Binding var result: FlutterResult

    func makeUIViewController(context: UIViewControllerRepresentableContext<InitializeKlarna>) -> UIHostingController<KlarnaView> {
        return UIHostingController(rootView: KlarnaView(isPresented: $isPresented, klarnaStatus: $klarnaStatus, chargerIdInput: $chargerIdInput, transactionID: $transactionID, result: $result))
    }

    func updateUIViewController(_ uiViewController: UIHostingController<KlarnaView>, context: UIViewControllerRepresentableContext<InitializeKlarna>) {
    }
}
