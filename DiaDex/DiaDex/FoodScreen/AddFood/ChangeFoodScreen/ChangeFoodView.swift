import UIKit
import SnapKit

class ChangeFoodView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let addLabel = UILabel()
    private let gramInput = UITextField()
    private let submitButton = UIButton()
    private let caloriesLabel = UILabel()
    private let fatLabel = UILabel()
    private let carbsLabel = UILabel()
    private let proteinLabel = UILabel()
    private let bradIndex = UILabel()

    private func setupUI() {
        // Добавить в мой дневник
        addLabel.text = "Добавить в мой дневник"
        addLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)

        addSubview(addLabel)
        addLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)

        }

        // Поле ввода для грамм
        gramInput.placeholder = "100 грамм"
        gramInput.textAlignment = .left
        gramInput.borderStyle = .roundedRect
        gramInput.keyboardType = .numberPad

        addSubview(gramInput)
        gramInput.snp.makeConstraints { make in
            make.top.equalTo(addLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)

        }

        // Кнопка сохранить
        submitButton.setTitle("Сохранить", for: .normal)
        submitButton.backgroundColor = UIColor(hexString: "#2ecc40")
        submitButton.layer.cornerRadius = 8

        addSubview(submitButton)
        submitButton.snp.makeConstraints { make in
            make.top.equalTo(gramInput.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)

        }

        // Метки для калорий, жира, углеводов и белков
        [caloriesLabel, bradIndex, fatLabel, carbsLabel, proteinLabel].forEach {
            $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            $0.textAlignment = .center
            $0.numberOfLines = 0
        }

        // StackView для отображения БЖУ
        let nutritionalStackView = UIStackView(arrangedSubviews: [caloriesLabel, bradIndex, fatLabel, carbsLabel, proteinLabel])
        nutritionalStackView.axis = .vertical
        nutritionalStackView.spacing = 16
        addSubview(nutritionalStackView)
        nutritionalStackView.snp.makeConstraints { make in
            make.top.equalTo(submitButton.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
    }

    func configure(with food: Food) {
        updateNutritionalInfo(from: food.description)
    }

    private func updateNutritionalInfo(from description: String) {
        let nutritionalValues = extractNutritionalValues(from: description)
        caloriesLabel.text = "Калории: \(nutritionalValues.calories)"
        bradIndex.text = "Хлебные единицы: \(nutritionalValues.carbs)"
        fatLabel.text = "Жир: \(nutritionalValues.fat)"
        carbsLabel.text = "Углеводы: \(nutritionalValues.carbs)"
        proteinLabel.text = "Белок: \(nutritionalValues.protein)"
    }

    private func extractNutritionalValues(from description: String) -> (calories: String, fat: String, carbs: String, protein: String) {
        var calories = ""
        var fat = ""
        var carbs = ""
        var protein = ""

        let regex = try! NSRegularExpression(pattern: "Calories: ([0-9.]+)kcal \\| Fat: ([0-9.]+)g \\| Carbs: ([0-9.]+)g \\| Protein: ([0-9.]+)g")
        if let match = regex.firstMatch(in: description, range: NSRange(description.startIndex..., in: description)) {
            if let caloriesRange = Range(match.range(at: 1), in: description) {
                calories = String(description[caloriesRange])
            }
            if let fatRange = Range(match.range(at: 2), in: description) {
                fat = String(description[fatRange])
            }
            if let carbsRange = Range(match.range(at: 3), in: description) {
                carbs = String(description[carbsRange])
            }
            if let proteinRange = Range(match.range(at: 4), in: description) {
                protein = String(description[proteinRange])
            }
        }

        return (calories, fat, carbs, protein)
    }
}
