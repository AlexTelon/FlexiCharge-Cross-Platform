//
//  IntroductionViewController.swift
//  HybridInAppSDKDemo
//
//  Created by Ekaterina Dvuzhilova on 2019-10-25.
//

import UIKit

class IntroductionViewController: UIViewController {

    @IBAction func klarnaDemoButtonPressed(_ sender: Any) {
        let viewController = WKWebViewController.instantiate(url: URL(string: "https://www.klarna.com/demo/")!)
        present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func customUrlButtonPressed(_ sender: Any) {
        let viewController = WKWebViewController.instantiate(url: nil)
        present(viewController, animated: true, completion: nil)
    }

}
