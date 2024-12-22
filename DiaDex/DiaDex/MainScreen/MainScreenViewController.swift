import UIKit

class MainScreenViewController: UIViewController, MainScreenViewDelegate {

    private let viewModel: MainScreenViewModel
    private var mainView: MainScreenView!

    init(viewModel: MainScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

        self.mainView = MainScreenView()
        self.mainView.delegate = self
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
        navigationItem.title = "Дневник"
        navigationController?.navigationBar.barTintColor = UIColor.diadexViews

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

        let calendarButton = UIBarButtonItem(image: UIImage(systemName: "calendar.badge.checkmark"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(calendarButtonTapped))
        navigationItem.rightBarButtonItem = calendarButton
    }

    @objc func calendarButtonTapped() {
        navigationController?.pushViewController(CalendarViewController(viewModel: CalendarViewModel()), animated: true)
    }

    func addNoteButtonTapped() {
        navigationController?.pushViewController(FirstStepViewController(viewModel: FirstStepViewModel()), animated: true)
    }

    func setupUI() {
        guard let mainView = self.mainView else { return }
        view.addSubview(mainView)

        mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
