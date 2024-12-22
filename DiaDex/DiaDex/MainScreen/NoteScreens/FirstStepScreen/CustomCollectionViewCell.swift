import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    private let tickMark = UIView()
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        // Черные рамки слева и справа
        let leftBorder = UIView()
        leftBorder.backgroundColor = .black
        contentView.addSubview(leftBorder)
        leftBorder.translatesAutoresizingMaskIntoConstraints = false

        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        // Вертикальные деления внизу ячейки
        var tickMarks = [UIView]()

        for _ in 0..<6 {
            let tickMark = UIView()
            tickMark.backgroundColor = .black
            contentView.addSubview(tickMark)
            tickMark.translatesAutoresizingMaskIntoConstraints = false
            tickMarks.append(tickMark)
        }

        // Расположение черных рамок
        NSLayoutConstraint.activate([
            leftBorder.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            leftBorder.widthAnchor.constraint(equalToConstant: 1),
            leftBorder.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            leftBorder.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),

            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])

        // Расположение вертикальных делений внизу ячейки
        for (index, tickMark) in tickMarks.enumerated() {
            NSLayoutConstraint.activate([
                tickMark.widthAnchor.constraint(equalToConstant: 1),
                tickMark.heightAnchor.constraint(equalToConstant: 10),
                tickMark.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
                tickMark.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: CGFloat(index + 1) * contentView.frame.width / 7)
            ])
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        // Необходимо очищать ячейку перед повторным использованием
        label.text = nil
        label.isHidden = false
    }

    func configure(with text: String, showLabel: Bool) {
        label.text = text
        label.isHidden = !showLabel
    }
}
