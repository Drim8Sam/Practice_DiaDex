import UIKit

class AddFoodViewController: UIViewController {

    private let mealName: String
    private let addFoodView = AddFoodView()
    private let viewModel = AddFoodViewModel()
    private var searchQuery: String = ""

    init(mealName: String) {
        self.mealName = mealName
        super.init(nibName: nil, bundle: nil)
        self.hidesBottomBarWhenPushed = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Добавить \(mealName)"
        setupUI()
        setupActions()
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
        view.addSubview(addFoodView)
        addFoodView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setupActions() {
        addFoodView.searchBar.delegate = self
        addFoodView.tableView.dataSource = self
        addFoodView.tableView.delegate = self
    }

    private func searchFood() {
        viewModel.searchFood(query: searchQuery) { [weak self] in
            DispatchQueue.main.async {
                self?.addFoodView.tableView.reloadData()
            }
        }
    }
}

extension AddFoodViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let query = searchBar.text, !query.isEmpty {
            searchQuery = query
            searchFood()
            searchBar.resignFirstResponder()
        }
    }
}

extension AddFoodViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.foods.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FoodTableViewCell.identifier, for: indexPath) as? FoodTableViewCell else {
            return UITableViewCell()
        }
        let food = viewModel.foods[indexPath.row]
        cell.configure(with: food)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedFood = viewModel.foods[indexPath.row]
        showChangeFoodScreen(with: selectedFood)
    }

    private func showChangeFoodScreen(with food: Food) {
        
        let changeFoodViewController = ChangeFoodViewController(food: food)
        navigationController?.pushViewController(changeFoodViewController, animated: true)
    }
}
