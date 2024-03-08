//
//  LoginViewController.swift
//  
//
//  Created by alexandru.apostol on 6/3/24.
//

import UIKit

public final class LoginViewController: UIViewController {

    private let viewModel: LoginViewModelProtocol

    private lazy var registerButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Go To Register", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didPressRegisterButton), for: .touchUpInside)
        return button
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didPressLogin), for: .touchUpInside)
        return button
    }()

    private lazy var mainStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [loginButton, registerButton])
        view.distribution = .fill
        view.alignment = .fill
        view.axis = .horizontal
        view.spacing = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init(viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        setUpMainStackViewLayout()
        title = "Login"
    }

    private func setUpMainStackViewLayout() {
        view.addSubview(mainStackView)
        mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    @objc
    private func didPressRegisterButton() {
        viewModel.didPressGoToRegister()
    }

    @objc
    private func didPressLogin() {
        viewModel.didPressLoginButton()
    }

}
