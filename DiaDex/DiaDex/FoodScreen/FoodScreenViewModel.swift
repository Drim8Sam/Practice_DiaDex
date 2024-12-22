import UIKit

struct Meal {
    let name: String
    var foods: [FoodItem] = []
}

struct FoodItem {
    let name: String
    let calories: Int
}

class FoodScreenViewModel {
    var meals: [Meal] = [
        Meal(name: "Завтрак"),
        Meal(name: "Обед"),
        Meal(name: "Ужин"),
        Meal(name: "Перекус/Другое")
    ]

    func addFood(_ food: FoodItem, toMeal mealIndex: Int) {
        meals[mealIndex].foods.append(food)
    }
}
