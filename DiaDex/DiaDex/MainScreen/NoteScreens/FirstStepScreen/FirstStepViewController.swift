import UIKit

class FirstStepViewController: UIViewController {
    private let viewModel: FirstStepViewModel!
    private var firstStepView: FirstStepView!

    init(viewModel: FirstStepViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.firstStepView = FirstStepView()
        self.firstStepView.viewController = self // Set the view controller in the view
        self.firstStepView.collectionView.dataSource = self
        self.firstStepView.collectionView.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupUI()
        setInitialScrollPosition()
    }

    func setupNavigationBar() {
        navigationItem.title = "1 шаг из 3"
    }

    private func setupUI() {
        view.addSubview(firstStepView)
        firstStepView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setInitialScrollPosition() {
        let initialValue = viewModel.initialValue
        let initialIndex = viewModel.values.firstIndex(of: initialValue) ?? 0
        let initialOffset = CGFloat(initialIndex) * 60 // Adjust this if your cell width or spacing is different
        firstStepView.collectionView.contentOffset = CGPoint(x: initialOffset, y: 0)
        firstStepView.numberOfChange.text = String(format: "%.1f", initialValue)
    }

    @objc func TapFinishButtonTapped() {
        navigationController?.pushViewController(SecondStepViewController(viewModel: SecondStepViewModel()), animated: true)
    }
}

extension FirstStepViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.values.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        let valueText = String(format: "%.1f", viewModel.values[indexPath.item])
        let showLabel = indexPath.item % 1 == 0
        cell.configure(with: valueText, showLabel: showLabel)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: collectionView.frame.height)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let centerPoint = CGPoint(x: firstStepView.collectionView.bounds.midX + firstStepView.collectionView.contentOffset.x, y: firstStepView.collectionView.bounds.midY)
        if let indexPath = firstStepView.collectionView.indexPathForItem(at: centerPoint) {
            if let cell = firstStepView.collectionView.cellForItem(at: indexPath) as? CustomCollectionViewCell {
                firstStepView.numberOfChange.text = cell.label.text
            }
        }
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let layout = firstStepView.collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        _ = layout.itemSize.width + layout.minimumLineSpacing

        // Calculate the proposed content offset adjustment
        let proposedContentOffset = targetContentOffset.pointee
        let horizontalCenter = scrollView.frame.size.width / 2
        let proposedContentOffsetCenterX = proposedContentOffset.x + horizontalCenter

        // Find the closest index path to the proposed content offset center
        if let indexPath = self.firstStepView.collectionView.indexPathForItem(at: CGPoint(x: proposedContentOffsetCenterX, y: scrollView.frame.size.height / 2)) {
            let attributes = layout.layoutAttributesForItem(at: indexPath)
            let itemCenterX = attributes?.center.x ?? 0

            // Calculate the new target content offset
            let newOffsetX = itemCenterX - horizontalCenter
            targetContentOffset.pointee = CGPoint(x: newOffsetX, y: proposedContentOffset.y)

            // Update the label with the selected value from the cell
            DispatchQueue.main.async {
                if let cell = self.firstStepView.collectionView.cellForItem(at: indexPath) as? CustomCollectionViewCell {
                    self.firstStepView.numberOfChange.text = cell.label.text
                }
            }
        }
    }
}
