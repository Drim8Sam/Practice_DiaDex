import UIKit
import SnapKit

class AddFoodView: UIView {

    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Поиск еды"
        return searchBar
    }()

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FoodTableViewCell.self, forCellReuseIdentifier: FoodTableViewCell.identifier) // Используем кастомную ячейку здесь
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.diadexBackground
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(searchBar)
        addSubview(tableView)

        searchBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.left.right.equalToSuperview().inset(0)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(0)
            make.left.right.bottom.equalToSuperview().inset(0)
        }
    }
}
