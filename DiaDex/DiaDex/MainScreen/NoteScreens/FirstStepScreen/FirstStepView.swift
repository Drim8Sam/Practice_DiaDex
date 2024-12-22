import UIKit
import SnapKit

class FirstStepView: UIView {
    weak var viewController: FirstStepViewController?

    lazy var labelOfStep: UILabel = {
        var label = UILabel()
        label.text = "Уровень глюкозы в крови"
        return label
    }()

    lazy var numberOfChange: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 100, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    lazy var nnmolLabel: UILabel = {
        var label = UILabel()
        label.text = "ммоль/л"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.sectionInset = .zero
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(hexString: "#2ecc40")
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    lazy var notchView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor.diadexBackground

            view.transform = CGAffineTransform(rotationAngle: .pi / 4) // Rotate by 45 degrees
            return view
    }()

    lazy var finishFirstStepButton: UIButton = {
        let button  = UIButton()
        button.setTitle("Продолжить", for: .normal)
        button.backgroundColor = UIColor(hexString: "#2ecc40")
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(viewController, action: #selector(FirstStepViewController.TapFinishButtonTapped), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        addSubview(collectionView)
        addSubview(labelOfStep)
        addSubview(numberOfChange)
        addSubview(nnmolLabel)
        addSubview(finishFirstStepButton)
        addSubview(notchView)

        labelOfStep.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }

        numberOfChange.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(nnmolLabel.snp.top).offset(0)
        }

        nnmolLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(collectionView.snp.top).offset(-20)
        }

        collectionView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(70)
        }

        notchView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(collectionView.snp.top).offset(-10)
            make.width.height.equalTo(15)
        }

        finishFirstStepButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-100)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.height.equalTo(50)
        }
    }
}
