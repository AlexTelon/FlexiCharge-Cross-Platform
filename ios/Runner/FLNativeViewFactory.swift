//
//  FLNativeViewFactory.swift
//  Runner
//
//  Created by Gustav Persson on 2022-09-26.
//

import Flutter
import UIKit
import SwiftUI

class FLNativeViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return FLNativeView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger)
    }
}

class FLNativeView: NSObject, FlutterPlatformView {
    private var _view: UIView
    
    @State var chargerIdInput: String = ""
    @State var isKlarnaPresented: Bool = true
    @State var klarnaStatus: String = ""
    @State var transactionID: Int = 0

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        _view = UIView()
        super.init()
        // iOS views can be created here
        createNativeView(view: _view)
        //InitializeKlarna(isPresented: $isKlarnaPresented, klarnaStatus: $klarnaStatus, chargerIdInput: $chargerIdInput, transactionID: $transactionID)
    }

    func view() -> UIView {
        return _view
    }

    func createNativeView(view _view: UIView){
        _view.backgroundColor = UIColor.blue
        let nativeLabel = UILabel()
        nativeLabel.text = "Native text from iOS"
        nativeLabel.textColor = UIColor.white
        nativeLabel.textAlignment = .center
        nativeLabel.frame = CGRect(x: 0, y: 0, width: 180, height: 48.0)

        //_view.addSubview(nativeLabel)
        
        var parent = UIViewController()
        klarnaHostingController.view.translatesAutoresizingMaskIntoConstraints = false
        klarnaHostingController.view.frame = parent.view.bounds
        // First, add the view of the child to the view of the parent
        parent.view.addSubview(klarnaHostingController.view)
        // Then, add the child to the parent
        parent.addChild(klarnaHostingController)
        
        _view.addSubview(parent.view)
        
        
        //_view.addSubview(controller.view)
    }
}

