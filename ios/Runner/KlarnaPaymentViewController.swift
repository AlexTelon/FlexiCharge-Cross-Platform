//
//  ViewController.swift
//  FashionStore
//
//  Copyright © 2018 Klarna Bank AB. All rights reserved.
//
import UIKit

import KlarnaMobileSDK

public protocol ViewControllerDelegate: class {
    func displayPaymentView()
}

final class ViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var buttonStackView: UIStackView!

    // MARK: - Properties
    private var sdkIntegration: SDKIntegration = SDKIntegration()

    private lazy var orderCreatedLabel: UILabel = {
        let label = UILabel(frame: self.view.bounds)
        label.backgroundColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30)
        label.text = "Order created 🎉"
        return label
    }()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        startSDKIntegration()
    }

    // MARK: - IBActions
    @IBAction func didTapButtonRefresh(_ sender: UIButton) {
        self.activityIndicator.startAnimating()
        orderCreatedLabel.removeFromSuperview()
        sdkIntegration.nextCategory()
    }

    @IBAction func didTapButtonAuthorize(_ sender: UIButton) {
        sdkIntegration.paymentView?.authorize(autoFinalize: true, jsonData: nil)
    }

    @IBAction func didTapButtonFinalize(_ sender: UIButton) {
        sdkIntegration.paymentView?.finalise()
    }

    @IBAction func didTapButtonCreateOrder(_ sender: UIButton) {
        createNewOrder()
    }

}

// MARK: - ViewControllerDelegate
extension ViewController: ViewControllerDelegate {

    func displayPaymentView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                fatalError("`self` does not exist!")
            }

            self.activityIndicator.stopAnimating()

            if let paymentView = self.sdkIntegration.paymentView {
                self.embed(subview: paymentView, toBottomAnchor: self.buttonStackView.topAnchor)
            }
            else {
                print("ViewController displayPaymentView: Payment view does not exist!")
            }
        }
    }

}

// MARK: - Private
extension ViewController {

    private func startSDKIntegration() {
        sdkIntegration.viewControllerDelegate = self
        sdkIntegration.createCreditSession()
    }

    private func createNewOrder() {
        sdkIntegration.createNewOrder { [weak self] in
            guard let self = self else {
                fatalError("`self` does not exist!")
            }
            self.displayOrderCreated()
        }
    }

    private func displayOrderCreated() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                fatalError("`self` does not exist!")
            }

            self.sdkIntegration.removePaymentView()

            self.embed(subview: self.orderCreatedLabel, toBottomAnchor: self.buttonStackView.topAnchor)
        }
    }

}
