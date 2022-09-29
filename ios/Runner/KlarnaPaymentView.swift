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


public protocol ViewControllerDelegate: AnyObject {
    func displayPaymentView()
}


struct KlarnaView: View {
    @Binding var isPresented: Bool
    @Binding var klarnaStatus: String
    @Binding var chargerIdInput: String
    @Binding var transactionID: Int
    @ObservedObject var sdkIntegration: KlarnaSDKIntegration = KlarnaSDKIntegration()

    init(isPresented: Binding<Bool>, klarnaStatus: Binding<String>, chargerIdInput: Binding<String>, transactionID: Binding<Int>) {
        self._isPresented = isPresented
        self._klarnaStatus = klarnaStatus
        self._chargerIdInput = chargerIdInput
        self._transactionID = transactionID
        sdkIntegration.getKlarnaSession(chargerIdInput: chargerIdInput)
    }
    
    var body: some View {
        VStack {
            Spacer()
            AsyncImage(url: URL(string: "https://i.imgur.com/bYV3h6Q.png")).frame(maxWidth: 300, maxHeight: 200)
            Spacer()
            ProgressView().progressViewStyle(CircularProgressViewStyle())
            Spacer()
            Spacer()
        }.onChange(of: sdkIntegration.isKlarnaPaymentDone, perform: { _ in
            klarnaStatus = sdkIntegration.klarnaStatus
            transactionID = sdkIntegration.thisTransactionID ?? 0
            isPresented = false
        })
    }
}


struct InitializeKlarna: UIViewControllerRepresentable, View {
    @Binding var isPresented: Bool
    @Binding var klarnaStatus: String
    @Binding var chargerIdInput: String
    @Binding var transactionID: Int

    func makeUIViewController(context: UIViewControllerRepresentableContext<InitializeKlarna>) -> UIHostingController<KlarnaView> {
        return UIHostingController(rootView: KlarnaView(isPresented: $isPresented, klarnaStatus: $klarnaStatus, chargerIdInput: $chargerIdInput, transactionID: $transactionID))
    }

    func updateUIViewController(_ uiViewController: UIHostingController<KlarnaView>, context: UIViewControllerRepresentableContext<InitializeKlarna>) {
    }
}
