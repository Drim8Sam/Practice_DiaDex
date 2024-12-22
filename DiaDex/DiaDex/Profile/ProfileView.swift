import UIKit
import SnapKit

class ProfileView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.diaDexText
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Имя пользователя"
        return label
    }()

    private lazy var idLabel: UILabel = {
        let label = UILabel()
        let textColor = UIColor.diaDexText
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "ID: 123456"
        return label
    }()

    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, idLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 5
        return stackView
    }()

    private lazy var profileImageStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [profileImageView])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        return stackView
    }()

    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [profileImageStackView, infoStackView])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.backgroundColor = UIColor.diadexViews
        stackView.layer.cornerRadius = 10
        stackView.clipsToBounds = true
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    private lazy var buttons: [UIButton] = {
        let titles = ["Настройки", "Обратная связь", "Экспорт данных в виде таблицы", "Премиум", "О нас"]
        return titles.map { title in
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.setTitleColor(UIColor.diaDexText, for: .normal)
            button.backgroundColor = UIColor.diadexViews
            button.layer.cornerRadius = 10
            button.contentHorizontalAlignment = .left
            button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            return button
        }
    }()

    private lazy var buttonsStackview:UIStackView = {
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()

    private func setupButtonActions() {
        for (index, button) in buttons.enumerated() {
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            button.tag = index // используем тег кнопки для определения, какая кнопка была нажата
        }
    }

    @objc private func buttonTapped(_ sender: UIButton) {
        // Переход на соответствующий экран в зависимости от нажатой кнопки
        let index = sender.tag
        switch index {
        case 0:
            // Обработка нажатия на кнопку "Настройки"
            // Например, переход на экран настроек
            print("Настройки")
        case 1:
            // Обработка нажатия на кнопку "Обратная связь"
            // Например, переход на экран обратной связи
            print("Обратная связь")
        // Добавьте обработку для остальных кнопок по аналогии
        default:
            break
        }
    }

    private func setUp() {
        setupButtonActions()
        addSubview(mainStackView)
        addSubview(buttonsStackview)
        mainStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        buttonsStackview.snp.makeConstraints{make in
            make.top.equalTo(mainStackView.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        // Adding the tap gesture recognizer to mainStackView
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(mainStackViewTapped))
        mainStackView.addGestureRecognizer(tapGesture)
        mainStackView.isUserInteractionEnabled = true // Enable user interaction
        // Добавляем констрейты для profileImageView
        profileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(70)
        }


        profileImageView.layer.cornerRadius = 35


        profileImageStackView.snp.makeConstraints { make in
            make.width.equalTo(profileImageView.snp.width)
            make.height.equalTo(profileImageView.snp.height)
        }
    }

    @objc private func mainStackViewTapped() {
        // Notify the ProfileViewController to navigate to EditProfileViewController
        if let viewController = self.parentViewController as? ProfileViewController {
            viewController.navigateToEditProfile()
        }
    }
}

extension UIView {
    var parentViewController: UIViewController? {
        var responder: UIResponder? = self
        while let nextResponder = responder?.next {
            responder = nextResponder
            if let viewController = responder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

