import Foundation

class ChangeFoodViewModel {

    private let food: Food

    init(food: Food) {
        self.food = food
    }

    func getFood() -> Food {
        return food
    }
}
