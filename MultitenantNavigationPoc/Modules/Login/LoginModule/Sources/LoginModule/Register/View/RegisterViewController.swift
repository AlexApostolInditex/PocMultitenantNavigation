//
//  RegisterViewController.swift
//  
//
//  Created by alexandru.apostol on 6/3/24.
//

import UIKit

class RegisterViewController: UIViewController {

    private let viewModel: RegisterViewModelProtocol

    private lazy var registerButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Register User", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didPressRegisterButton), for: .touchUpInside)
        return button
    }()

    private lazy var mainStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [registerButton])
        view.distribution = .fill
        view.alignment = .fill
        view.axis = .horizontal
        view.spacing = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init(viewModel: RegisterViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .orange
        title = "Register"
        setUpMainStackViewLayout()
    }

    private func setUpMainStackViewLayout() {
        view.addSubview(mainStackView)
        mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    @objc
    private func didPressRegisterButton() {
        viewModel.registerUser()
    }
}
