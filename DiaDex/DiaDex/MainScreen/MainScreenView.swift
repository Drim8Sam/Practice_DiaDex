import UIKit
import SnapKit

protocol MainScreenViewDelegate: AnyObject {
    func addNoteButtonTapped()
}

class MainScreenView: UIView {

    weak var delegate: MainScreenViewDelegate?

    lazy var addNewNoteButton: UIButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpAddNewNoteButton()
        addNewNoteButton.addTarget(self, action: #selector(addNoteButtonAction), for: .touchUpInside)
    }

    private func setUpAddNewNoteButton() {
        addSubview(addNewNoteButton)
        addNewNoteButton.translatesAutoresizingMaskIntoConstraints = false

        if let plusImage = UIImage(systemName: "plus")?.withRenderingMode(.alwaysTemplate) {
            addNewNoteButton.setImage(plusImage, for: .normal)
            addNewNoteButton.tintColor = .white
        }

        addNewNoteButton.backgroundColor = UIColor(hexString: "#2ecc40")
        addNewNoteButton.layer.cornerRadius = 40
        addNewNoteButton.clipsToBounds = true

        NSLayoutConstraint.activate([
            addNewNoteButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            addNewNoteButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            addNewNoteButton.widthAnchor.constraint(equalToConstant: 80),
            addNewNoteButton.heightAnchor.constraint(equalTo: addNewNoteButton.widthAnchor)
        ])
    }

    @objc func addNoteButtonAction() {
        delegate?.addNoteButtonTapped()
    }
}
