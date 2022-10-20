import UIKit

class ArtworkTableViewCell: UITableViewCell {
    var id: Int = 0

    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private(set) lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.subheadline)
        label.textColor = UIColor.secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private(set) lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private(set) lazy var overlineLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private(set) lazy var cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private(set) lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [overlineLabel, titleLabel, subtitleLabel, descriptionLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()

    private(set) lazy var cardView: UIView = {
        let cardView = UIView()
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.layer.cornerRadius = 8
        cardView.clipsToBounds = true
        return cardView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(cardView)
        cardView.addSubview(cellImageView)
        cardView.addSubview(stackView)

        NSLayoutConstraint.activate([

            cardView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            cellImageView.topAnchor.constraint(equalTo: cardView.topAnchor),
            cellImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            cellImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            cellImageView.heightAnchor.constraint(equalTo: cellImageView.widthAnchor),

            stackView.topAnchor.constraint(equalTo: cellImageView.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16),
        ])
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init?(coder: NSCoder) Not implemented")
    }

    override func prepareForReuse() {
        cellImageView.image = nil
        cellImageView.cancelLoad()
    }

    func updateView(_ viewModel: ArtworkViewModel) {
        id = viewModel.id
        overlineLabel.text = viewModel.overline
        if let imageURL = viewModel.imageURL {
            cellImageView.load(at: imageURL)
        }
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        descriptionLabel.text = viewModel.description
        let textColor = viewModel.backgroundColor.withAlphaComponent(1)
        cardView.backgroundColor = viewModel.backgroundColor.withAlphaComponent(0.3)
        overlineLabel.textColor = UIColor.secondaryLabel
        titleLabel.textColor = textColor
        subtitleLabel.textColor = UIColor.secondaryLabel
        descriptionLabel.textColor = UIColor.secondaryLabel
    }
}
