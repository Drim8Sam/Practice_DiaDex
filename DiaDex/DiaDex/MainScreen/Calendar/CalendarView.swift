//
//  CalendarView.swift
//  DiaDex
//
//  Created by err on 01.06.2024.
//

import UIKit

class CalendarView: UIView {
    var calendarViewController: CalendarViewController!

    lazy var addNewNoteButton: UIButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {

    }


}
