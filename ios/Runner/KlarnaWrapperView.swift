//
//  KlarnaWrapperView.swift
//  Runner
//
//  Created by Gustav Persson on 2022-09-23.
//

import SwiftUI

struct KlarnaWrapperView: View {
    @State var chargerIdInput: String = ""
    @State var isKlarnaPresented: Bool = true
    @State var klarnaStatus: String = ""
    @State var transactionID: Int = 750
    
    var body: some View {
        InitializeKlarna(isPresented: $isKlarnaPresented, klarnaStatus: $klarnaStatus, chargerIdInput: $chargerIdInput, transactionID: $transactionID)
    }
}

struct KlarnaWrapperView_Previews: PreviewProvider {
    static var previews: some View {
        KlarnaWrapperView()
    }
}

var klarnaHostingController = UIHostingController(rootView: KlarnaWrapperView())
