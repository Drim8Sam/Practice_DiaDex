import UIKit
import SnapKit

class ChangeFoodViewController: UIViewController {

    private let food: Food
    private let changeFoodView = ChangeFoodView()

    init(food: Food) {
        self.food = food
        super.init(nibName: nil, bundle: nil)
        self.hidesBottomBarWhenPushed = true

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.diadexBackground
        navigationItem.title = food.name
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }

    private func setupUI() {
        view.addSubview(changeFoodView)
        changeFoodView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        changeFoodView.configure(with: food)
    }
}
