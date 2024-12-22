import UIKit
import SnapKit

class FoodScreenView: UIView {

    private let headerStackView = UIStackView()
    internal let mealsStackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        backgroundColor = UIColor(named: "diadexBackground")

        setupHeader()
        setupMeals()

        let mainStackView = UIStackView(arrangedSubviews: [headerStackView, mealsStackView])
        mainStackView.axis = .vertical
        mainStackView.spacing = 16
        mainStackView.alignment = .fill

        addSubview(mainStackView)
        mainStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.right.equalToSuperview().inset(16)
        }
    }

    private func setupHeader() {
        let titles = ["Жиры", "Углеводы", "Белки", "Калории", "ХЕ"]
        titles.forEach { title in
            let headerView = UIView()
            headerStackView.addArrangedSubview(headerView)

            let titleLabel = UILabel()
            titleLabel.text = title
            titleLabel.textAlignment = .center
            titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
            titleLabel.textColor = .white
            headerView.addSubview(titleLabel)
            titleLabel.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().offset(8)
            }

            let valueLabel = UILabel()
            valueLabel.text = "0" // Здесь можно установить начальное значение
            valueLabel.textAlignment = .center
            valueLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
            valueLabel.textColor = .white
            headerView.addSubview(valueLabel)
            valueLabel.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(titleLabel.snp.bottom).offset(4)
                make.bottom.equalToSuperview().inset(8)
            }

            headerView.snp.makeConstraints { make in
                make.width.equalToSuperview().dividedBy(titles.count)
            }
        }

        headerStackView.axis = .horizontal
        headerStackView.distribution = .fillEqually
    }


    private func setupMeals() {
        let meals = [("Завтрак", "sunrise.fill"), ("Обед", "sun.max.fill"), ("Ужин", "sunset.fill"), ("Перекус/Другое", "moon.fill")]

        meals.forEach { meal in
            let mealView = createMealView(mealName: meal.0, iconName: meal.1)
            mealsStackView.addArrangedSubview(mealView)
        }

        mealsStackView.axis = .vertical
        mealsStackView.spacing = 16
        mealsStackView.alignment = .fill
    }

    private func createMealView(mealName: String, iconName: String) -> UIView {
        let mealView = UIView()
        mealView.backgroundColor = .systemGray6
        mealView.layer.cornerRadius = 8

        let iconImageView = UIImageView(image: UIImage(systemName: iconName))
        iconImageView.tintColor = .systemYellow
        iconImageView.contentMode = .scaleAspectFit

        let nameLabel = UILabel()
        nameLabel.text = mealName
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        nameLabel.textColor = .white

        let addButton = UIButton(type: .contactAdd)
        addButton.tintColor = .systemGreen
        addButton.addTarget(self, action: #selector(addFoodButtonTapped), for: .touchUpInside)

        // Create a spacer view to push the addButton to the right
        let spacerView = UIView()
        spacerView.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        let stackView = UIStackView(arrangedSubviews: [iconImageView, nameLabel, spacerView, addButton])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center

        mealView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }

        mealView.snp.makeConstraints { make in
            make.height.equalTo(50)
        }

        return mealView
    }

    @objc func addFoodButtonTapped(sender: UIButton) {
    }
}
