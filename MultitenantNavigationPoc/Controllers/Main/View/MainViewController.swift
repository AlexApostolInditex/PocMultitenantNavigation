//
//  MainViewController.swift
//  MultitenantNavigationPoc
//
//  Created by alexandru.apostol on 6/3/24.
//

import UIKit

public class MainViewController: UIViewController {

    private let viewModel: MainModuleViewModelProtocol

    init(viewModel: MainModuleViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
