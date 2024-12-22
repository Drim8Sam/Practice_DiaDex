import UIKit

enum Resources {
    enum Colors {

        enum TabBar {
            static let active = UIColor(hexString: "#2ecc40")
            static let inactive: UIColor = .diadexViews
        }

        enum BaseView {
            static let background = UIColor(hexString: "#17072c")
        }
    }

    enum Images {
        enum TabBar {
            static let homePage = UIImage(systemName: "house.fill")
            static let foodPage = UIImage(systemName: "fork.knife.circle")
            static let readingPage = UIImage(systemName: "book")
            static let profilePage = UIImage(systemName: "person.circle")
        }
    }

    enum Strings {
        enum TabBar {
            static var mainScreen = "Главная"
            static var foodScreen = "Питание"
            static var readingScreen = "Чтиво"
            static let profileScreen = "Профиль"

        }
    }
}

