import UIKit
import SnapKit
import FatSecretSwift

class FoodScreenViewController: UIViewController {

    private let viewModel: FoodScreenViewModel
    private let foodView: FoodScreenView = .init(frame: .zero)

    init(viewModel: FoodScreenViewModel) {
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
        setupActions()
    }

    private func setupNavigationBar() {
        navigationItem.title = "Сегодня"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .white

        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.diadexViews
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        } else {
            navigationController?.navigationBar.barTintColor = UIColor.diadexViews
            navigationController?.navigationBar.isTranslucent = false
        }
    }

    private func setupUI() {
        view.addSubview(foodView)
        foodView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setupActions() {
        for (index, view) in foodView.mealsStackView.arrangedSubviews.enumerated() {
            if let stackView = view.subviews.first as? UIStackView,
               let button = stackView.arrangedSubviews.last as? UIButton {
                button.tag = index
                button.addTarget(self, action: #selector(addFoodButtonTapped(_:)), for: .touchUpInside)
            }
        }
    }

    @objc private func addFoodButtonTapped(_ sender: UIButton) {
        let mealNames = ["Завтрак", "Обед", "Ужин", "Перекус/Другое"]
        let mealName = mealNames[sender.tag]
        let fatSecretClient = FatSecretClient()
        fatSecretClient.searchFood(name: "Hotdog") { search in
            print(search.foods)
        }
        let addFoodVC = AddFoodViewController(mealName: mealName)



        navigationController?.pushViewController(addFoodVC, animated: true)
    }
}
