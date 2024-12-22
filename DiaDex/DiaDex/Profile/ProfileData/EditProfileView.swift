import UIKit
import SnapKit

class EditProfileView: UIView {
    internal var editProfileViewController: EditProfileViewController!

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    internal lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle.fill")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 70 // Половина ширины и высоты для круга
        imageView.layer.borderWidth = 2 // Опционально, для обводки
        imageView.layer.borderColor = UIColor.gray.cgColor // Опционально, для цвета обводки
        return imageView
    }()


    private lazy var editPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Изменить фотографию", for: .normal)
        button.addTarget(self, action: #selector(editPhotoTapped), for: .touchUpInside)
        return button
    }()

    private lazy var birthDateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Выберите дату рождения", for: .normal)
        button.addTarget(self, action: #selector(showDatePicker), for: .touchUpInside)
        return button
    }()

    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        return picker
    }()

    private lazy var nameLabel: UILabel = createLabel(withText: "Имя")
    private lazy var nameInput: UITextField = createInputField(withPlaceholder: "Введите имя")

    private lazy var surnameLabel: UILabel = createLabel(withText: "Фамилия")
    private lazy var surnameInput: UITextField = createInputField(withPlaceholder: "Введите фамилию")

    private lazy var emailLabel: UILabel = createLabel(withText: "Почта")
    private lazy var emailInput: UITextField = createInputField(withPlaceholder: "Введите почту")

    private lazy var birthDateLabel: UILabel = createLabel(withText: "Дата рождения")

    private func createLabel(withText text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }

    private func createInputField(withPlaceholder placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.borderStyle = .none // Убрана оконтовка
        textField.placeholder = placeholder
        textField.delegate = self // Устанавливаем делегат для скрытия клавиатуры
        textField.textAlignment = .right // Выравнивание текста по правому краю
        return textField
    }

    private func setUp() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(profileImageView)
        contentView.addSubview(editPhotoButton)
        contentView.addSubview(nameLabel)
        contentView.addSubview(nameInput)
        contentView.addSubview(surnameLabel)
        contentView.addSubview(surnameInput)
        contentView.addSubview(emailLabel)
        contentView.addSubview(emailInput)
        contentView.addSubview(birthDateLabel)
        contentView.addSubview(birthDateButton)
        contentView.addSubview(datePicker)

        // Layout constraints for scroll view
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        // Layout constraints for content view
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView)
            make.bottom.equalTo(datePicker).offset(20) // Accommodate the date picker
        }

        // Layout constraints for profile image view
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(30)
            make.width.height.equalTo(140)
        }

        // Layout constraints for edit photo button
        editPhotoButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
        }

        // Layout constraints for labels and inputs
        let spacing: CGFloat = 16

        // Name
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(editPhotoButton.snp.bottom).offset(spacing)
            make.leading.equalToSuperview().inset(20)
        }
        nameInput.snp.makeConstraints { make in
            make.top.equalTo(editPhotoButton.snp.bottom).offset(spacing)
            make.leading.equalTo(nameLabel.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(20)
        }

        // Surname
        surnameLabel.snp.makeConstraints { make in
            make.top.equalTo(nameInput.snp.bottom).offset(spacing)
            make.leading.equalToSuperview().inset(20)
        }
        surnameInput.snp.makeConstraints { make in
            make.top.equalTo(nameInput.snp.bottom).offset(spacing)
            make.leading.equalTo(surnameLabel.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(20)
        }

        // Email
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(surnameInput.snp.bottom).offset(spacing)
            make.leading.equalToSuperview().inset(20)
        }
        emailInput.snp.makeConstraints { make in
            make.top.equalTo(surnameInput.snp.bottom).offset(spacing)
            make.leading.equalTo(emailLabel.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(20)
        }

        // Birth Date
        birthDateLabel.snp.makeConstraints { make in
            make.top.equalTo(emailInput.snp.bottom).offset(spacing)
            make.leading.equalToSuperview().inset(20)
        }
        birthDateButton.snp.makeConstraints { make in
            make.top.equalTo(emailInput.snp.bottom).offset(spacing)
            make.leading.equalTo(birthDateLabel.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(10)
        }

        // Date Picker
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(emailInput.snp.bottom).offset(spacing)
            make.leading.equalTo(birthDateLabel.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(20)
        }

        // Hide the datePicker initially
        datePicker.isHidden = true
    }

    @objc private func editPhotoTapped() {
        editProfileViewController?.presentImagePicker()
    }

    @objc private func showDatePicker() {
        datePicker.isHidden.toggle() // Показать или скрыть datePicker
        birthDateButton.isHidden.toggle() // Показать или скрыть кнопку выбора даты
    }

    @objc private func dateChanged() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        birthDateButton.setTitle(dateFormatter.string(from: datePicker.date), for: .normal)
        datePicker.isHidden = true // Скрыть datePicker после выбора даты
        birthDateButton.isHidden = false // Показать кнопку выбора даты
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UITextFieldDelegate
extension EditProfileView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Скрытие клавиатуры при нажатии Return
        return true
    }
}
