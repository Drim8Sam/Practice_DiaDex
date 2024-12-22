import UIKit

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private var editProfileView: EditProfileView!
    private var editProfileViewModel: EditProfileViewModel!

    init(viewModel: EditProfileViewModel) {
        self.editProfileViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.editProfileView = EditProfileView()
        self.editProfileView.editProfileViewController = self // Set reference to self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupUI()
        setupTapGesture() // Добавление жеста нажатия
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(doneButtonTapped))// Отключаем жест возврата
    }

    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Настройки профиля"

        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.diadexViews
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        } else {
            navigationController?.navigationBar.barTintColor = UIColor.diadexViews
            navigationController?.navigationBar.isTranslucent = false
        }
    }

    @objc private func doneButtonTapped() {
        // Возвращаемся на предыдущий экран с восстановлением TabBar
        let profileViewModel = ProfileViewModel() // Инициализируем ViewModel профиля
        let profileViewController = ProfileViewController(viewModel: profileViewModel)

        // Устанавливаем контроллер профиля в качестве корневого
        navigationController?.setViewControllers([profileViewController], animated: true)

        // Восстанавливаем TabBar
        self.tabBarController?.tabBar.isHidden = false
    }


    private func setupUI() {
        guard let mainView = self.editProfileView else { return }
        view.addSubview(mainView)

        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }

    func presentImagePicker() {
        let alert = UIAlertController(title: "Выберать изображение", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Камера", style: .default, handler: { _ in
            self.openCamera()
        }))
        alert.addAction(UIAlertAction(title: "Медиатека", style: .default, handler: { _ in
            self.openPhotoLibrary()
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    private func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        } else {
            print("Камера не доступна")
        }
    }

    private func openPhotoLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }

    // MARK: - UIImagePickerControllerDelegate methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            editProfileView.profileImageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Tap Gesture for Dismissing Keyboard
extension EditProfileViewController {
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true) // Скрытие клавиатуры при нажатии вне текстовых полей
    }
}
