import UIKit
import SnapKit

class ReadingScreenViewController: UIViewController {

    private let viewModel: ReadingScreenViewModel
    private let readingView: ReadingScreenView = .init(frame: .zero)

    init(viewModel: ReadingScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupUI()
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Статьи"

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
        view.addSubview(readingView)
        readingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
