import UIKit

enum Tabs: Int {
    case mainScreen
    case foodScreen
    case readingScreen
    case profileScreen
}

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabBarAppearance()
        configureBlurEffect()
        configureViewControllers()
    }

    private func configureTabBarAppearance() {
        tabBar.isTranslucent = true
        tabBar.tintColor = Resources.Colors.TabBar.active
        tabBar.barTintColor = Resources.Colors.TabBar.inactive
    }

    internal func configureBlurEffect() {
        let blurEffect = UIBlurEffect(style: .dark)  
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false

        view.insertSubview(blurView, belowSubview: tabBar)

        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: tabBar.topAnchor),
            blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func configureViewControllers() {
        let mainScreenViewModel = MainScreenViewModel()
        let mainScreenController = MainScreenViewController(viewModel: mainScreenViewModel)

        let foodScreenViewModel = FoodScreenViewModel()
        let foodScreenController = FoodScreenViewController(viewModel: foodScreenViewModel)

        let readingScreenViewModel = ReadingScreenViewModel()
        let readingScreenController = ReadingScreenViewController(viewModel: readingScreenViewModel)

        let profileViewModel = ProfileViewModel()
        let profileController = ProfileViewController(viewModel: profileViewModel)

        let mainScreenNavigation = NavBarViewController(rootViewController: mainScreenController)
        let foodScreenNavigation = NavBarViewController(rootViewController: foodScreenController)
        let readingScreenNavigation = NavBarViewController(rootViewController: readingScreenController)
        let profileScreenNavigation = NavBarViewController(rootViewController: profileController)

        mainScreenNavigation.tabBarItem = UITabBarItem(
            title: Resources.Strings.TabBar.mainScreen,
            image: Resources.Images.TabBar.homePage,
            tag: Tabs.mainScreen.rawValue
        )

        foodScreenNavigation.tabBarItem = UITabBarItem(
            title: Resources.Strings.TabBar.foodScreen,
            image: Resources.Images.TabBar.foodPage,
            tag: Tabs.foodScreen.rawValue
        )

        readingScreenNavigation.tabBarItem = UITabBarItem(
            title: Resources.Strings.TabBar.readingScreen,
            image: Resources.Images.TabBar.readingPage,
            tag: Tabs.readingScreen.rawValue
        )

        profileScreenNavigation.tabBarItem = UITabBarItem(
            title: Resources.Strings.TabBar.profileScreen,
            image: Resources.Images.TabBar.profilePage,
            tag: Tabs.profileScreen.rawValue
        )

        setViewControllers([
            mainScreenNavigation,
            foodScreenNavigation,
            readingScreenNavigation,
            profileScreenNavigation
        ], animated: false)
    }
}
