//
//  SecondStepViewController.swift
//  DiaDex
//
//  Created by err on 08.07.2024.
//

import UIKit
import SnapKit

class SecondStepViewController: UIViewController {

    private let viewModel: SecondStepViewModel!
    private var firstStepView: SecondStepView!

    init(viewModel: SecondStepViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.firstStepView = SecondStepView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupUI()
    }

    func setupNavigationBar() {
        navigationItem.title = "2 шаг из 3"
    }

    private func setupUI() {
        view.addSubview(firstStepView)
        firstStepView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    @objc func TapFinishButtonTapped() {
        //navigationController?.pushViewController(SecondStepViewController(vi), animated: <#T##Bool#>)
    }

}
