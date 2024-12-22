//
//  CalendarViewController.swift
//  DiaDex
//
//  Created by err on 01.06.2024.
//

import UIKit

class CalendarViewController: UIViewController {
    private let viewModel: CalendarViewModel
    private var calendarView: CalendarView!

    init(viewModel: CalendarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.calendarView = CalendarView()
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
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Записи"

    }

    private func setupUI() {
        view.addSubview(calendarView)
        calendarView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}
