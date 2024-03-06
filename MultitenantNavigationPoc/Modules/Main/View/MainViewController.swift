//
//  MainViewController.swift
//  MultitenantNavigationPoc
//
//  Created by alexandru.apostol on 6/3/24.
//

import UIKit

public class MainViewController: UIViewController {

    private let viewModel: MainModuleViewModelProtocol

    private lazy var checkoutButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Go To Checkout", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didPressCheckoutButton), for: .touchUpInside)
        return button
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Go To Login", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didPressLoginButton), for: .touchUpInside)
        return button
    }()

    private lazy var mainStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [loginButton, checkoutButton])
        view.distribution = .fill
        view.alignment = .fill
        view.axis = .horizontal
        view.spacing = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    public init(viewModel: MainModuleViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    public override func viewDidLoad() {
        super.viewDidLoad()
        setUpMainStackViewLayout()
        view.backgroundColor = .white
        title = "Main"
    }

    private func setUpMainStackViewLayout() {
        view.addSubview(mainStackView)
        mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    @objc
    private func didPressLoginButton() {
        viewModel.didPressLoginButton()
    }

    @objc
    private func didPressCheckoutButton() {
        viewModel.didPressCheckoutButton()
    }
}
