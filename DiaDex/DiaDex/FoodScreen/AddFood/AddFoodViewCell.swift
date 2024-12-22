import UIKit

class FoodTableViewCell: UITableViewCell {
    static let identifier = "FoodCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        // Customize your cell here if needed
    }

    func configure(with food: Food) {
        textLabel?.text = food.name
        detailTextLabel?.text = food.description
    }
}
