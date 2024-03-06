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
        setUpRegisterButtonLayout()
        title = "Login"
    }

    private func setUpRegisterButtonLayout() {
        view.addSubview(registerButton)
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    @objc
    private func didPressRegisterButton() {
        viewModel.didPressGoToRegister()
    }

}
