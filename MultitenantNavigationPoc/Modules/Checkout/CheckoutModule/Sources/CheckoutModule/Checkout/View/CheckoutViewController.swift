//
//  CheckoutViewController.swift
//  
//
//  Created by alexandru.apostol on 6/3/24.
//

import UIKit

public final class CheckoutViewController: UIViewController {

    private let viewModel: CheckoutViewModelProtocol

    private lazy var continueButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Continue", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didPressContinueButton), for: .touchUpInside)
        return button
    }()

    init(viewModel: CheckoutViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .cyan
        title = "Checkout"
        setUpContinueButtonLayout()
    }

    private func setUpContinueButtonLayout() {
        view.addSubview(continueButton)
        continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        continueButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    @objc
    private func didPressContinueButton() {
        viewModel.didPressContinue()
    }
}
