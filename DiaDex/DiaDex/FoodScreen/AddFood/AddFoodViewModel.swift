import FatSecretSwift

class AddFoodViewModel {
    private let client = FatSecretClient()
    var foods: [Food] = []

    func searchFood(query: String, completion: @escaping () -> Void) {
        client.searchFood(name: query) { result in
             let foodsResponse = result.foods
                    self.foods = foodsResponse.map { food in
                        Food(
                            id: food.id,
                            name: food.name,
                            description: food.description,
                            brand: food.brand ?? "",
                            type: food.type,
                            url: food.url
                        )
                    }
            completion()
        }


        }
    }


