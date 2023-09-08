import UIKit

class AnimatedCollectionViewCell: UICollectionViewCell {
    // MARK: - GUI Variables

    private lazy var houseImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "house1"))
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 15
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var houseName: UILabel = {
        let label = UILabel(text: "3D HOUSE", font: UIFont.boldSystemFont(ofSize: 30), textColor: .white)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var informationText: UILabel = {
        let label = UILabel(text: "Data technology futuristic ilustration. A wave of bright partical...", font: UIFont.systemFont(ofSize: 18), textColor: .white)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var informationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var informationView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.layer.cornerRadius = 24
        blurredEffectView.layer.masksToBounds = true
        blurredEffectView.translatesAutoresizingMaskIntoConstraints = false
        return blurredEffectView
    }()
    
    // MARK: - Properties

    static let identifier = "AnimatedCollectionViewCell"

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(houseImage)
        addSubview(houseName)
        addSubview(informationView)
        
        // Добавляем дочерние представления в contentView
        informationView.contentView.addSubview(informationText)
        informationView.contentView.addSubview(informationStackView)
        
        setupStackView()
        
        NSLayoutConstraint.activate([
            houseImage.topAnchor.constraint(equalTo: topAnchor),
            houseImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            houseImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            houseImage.heightAnchor.constraint(equalToConstant: 300),
            
            houseName.topAnchor.constraint(equalTo: houseImage.topAnchor, constant: 10),
            houseName.leadingAnchor.constraint(equalTo: houseImage.leadingAnchor, constant: 20),
            houseName.trailingAnchor.constraint(equalTo: houseImage.trailingAnchor, constant: -20),
            
            // Констрейнты для informationView
            informationView.centerYAnchor.constraint(equalTo: houseImage.centerYAnchor, constant: 90),
            informationView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            informationView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            informationView.heightAnchor.constraint(equalToConstant: 180),
            
            informationText.topAnchor.constraint(equalTo: informationView.contentView.topAnchor, constant: 20),
            informationText.leadingAnchor.constraint(equalTo: informationView.contentView.leadingAnchor, constant: 20),
            informationText.trailingAnchor.constraint(equalTo: informationView.contentView.trailingAnchor, constant: -20),
            
            informationStackView.topAnchor.constraint(equalTo: informationText.bottomAnchor, constant: 30),
            informationStackView.bottomAnchor.constraint(equalTo: informationView.contentView.bottomAnchor, constant: -20),
            informationStackView.leadingAnchor.constraint(equalTo: informationView.contentView.leadingAnchor, constant: 20),
            informationStackView.trailingAnchor.constraint(equalTo: informationView.contentView.trailingAnchor, constant: -20)
        ])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods

    private func setupStackView() {
        let text = [["Size", "816*1456"], ["Type", "Upscale"], ["Date", "Today 5:19"]]

        for item in text {
            let sv = UIStackView()
            sv.axis = .vertical
            sv.distribution = .fillEqually

            for labelContent in item {
                let label = UILabel(text: labelContent, font: .boldSystemFont(ofSize: 15), textColor: .white)
                sv.addArrangedSubview(label)
            }

            informationStackView.addArrangedSubview(sv)
        }
    }
    
    // MARK: - Methods

    func configure(with post: Post) {
        self.informationText.text = post.description
        self.houseName.text = post.houseName
        let text = [["Size", post.size], ["Type", post.type.rawValue.capitalized], ["Date", post.date]]
        for (index, item) in text.enumerated() {
            if let sv = informationStackView.arrangedSubviews[index] as? UIStackView {
                if let titleLabel = sv.arrangedSubviews[0] as? UILabel,
                   let valueLabel = sv.arrangedSubviews[1] as? UILabel
                {
                    titleLabel.text = item[0]
                    valueLabel.text = item[1]
                }
            }
        }
        self.houseImage.image = UIImage(named: post.image)
    }
}
