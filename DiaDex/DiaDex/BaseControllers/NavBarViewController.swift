import UIKit

final class NavBarViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.barTintColor = UIColor.diadexBackground
        navigationBar.backgroundColor = UIColor.diadexBackground
        configure()
    }

    func configure() {
        view.backgroundColor = UIColor.diadexBackground
        navigationBar.isTranslucent = false
        navigationBar.standardAppearance.titleTextAttributes = [
            .foregroundColor: UIColor(.white)
        ]
    }
}
