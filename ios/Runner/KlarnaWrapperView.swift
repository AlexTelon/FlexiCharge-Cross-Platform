//
//  KlarnaWrapperView.swift
//  Runner
//
//  Created by Gustav Persson on 2022-09-23.
//

import SwiftUI

struct KlarnaWrapperView: View {
    @State var chargerIdInput: String = "100010"
    @State var isKlarnaPresented: Bool = true
    @State var klarnaStatus: String = ""
    @State var transactionID: Int = 750
    @State var result: FlutterResult
    
    var body: some View {
        InitializeKlarna(isPresented: $isKlarnaPresented, klarnaStatus: $klarnaStatus, chargerIdInput: $chargerIdInput, transactionID: $transactionID, result: $result)
    }
}
