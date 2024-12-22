import UIKit
import SnapKit

class ProfileViewController: UIViewController {

    private let viewModel: ProfileViewModel
    private var profileView: ProfileView!

    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.profileView = ProfileView()
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
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Профиль"

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

    private func setupUI() {
        guard let mainView = self.profileView else { return }
        view.addSubview(mainView)

        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func navigateToEditProfile() {
            let editProfileViewModel = EditProfileViewModel() // Initialize your ViewModel here
            let editProfileViewController = EditProfileViewController(viewModel: editProfileViewModel)
            navigationController?.setViewControllers([editProfileViewController], animated: true)
        }

//    @objc private func buttonTapped(_ sender: UIButton) {
//        let index = sender.tag
//        switch index {
//        case 0:
//
//            let settingsViewController = SettingsViewController()
//            navigationController?.pushViewController(settingsViewController, animated: true)
//        case 1:
//
//            let feedbackViewController = FeedbackViewController()
//            navigationController?.pushViewController(feedbackViewController, animated: true)
//
//        default:
//            break
//        }
//    }

}
