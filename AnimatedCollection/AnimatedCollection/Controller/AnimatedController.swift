import UIKit

class AnimatedController: UIViewController {
    // MARK: - GUI Variables

    private lazy var homeAnimationCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width - 32, height: (view.frame.height - 96) / 2)
        layout.sectionInset.top = 50
        layout.sectionInset.bottom = 50
        layout.scrollDirection = .vertical
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(AnimatedCollectionViewCell.self, forCellWithReuseIdentifier: AnimatedCollectionViewCell.identifier)
        collection.dataSource = self
        collection.delegate = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()

    // MARK: - Private properties

    private let posts = Post.getPosts()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupUI()
    }

    // MARK: - Private methods

    private func setupUI() {
        view.addSubview(homeAnimationCollectionView)
        NSLayoutConstraint.activate([
            homeAnimationCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            homeAnimationCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            homeAnimationCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            homeAnimationCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate

extension AnimatedController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AnimatedCollectionViewCell.identifier, for: indexPath) as? AnimatedCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(with: posts[indexPath.row])
        return cell
    }
}

// MARK: - UIScrollViewDelegate

extension AnimatedController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let center = homeAnimationCollectionView.center
        
        for cell in homeAnimationCollectionView.visibleCells {
            guard let indexPath = homeAnimationCollectionView.indexPath(for: cell) else { continue }
            let offset = cell.center.y - homeAnimationCollectionView.contentOffset.y
            let normalizedOffset = abs(center.y - offset) / center.y
            let smoothOffset = normalizedOffset * normalizedOffset
            
            var transform = CATransform3DIdentity
            
            if offset < center.y, indexPath.row != 0 || scrollView.contentOffset.y > 0 {
                transform.m34 = -1.0 / 1000.0
                let rotation = smoothOffset * .pi / 4.0
                transform = CATransform3DRotate(transform, rotation, 1, 1, 0)
                
                let translationFactor = -cell.bounds.width * 0.5 * smoothOffset
                transform = CATransform3DTranslate(transform, translationFactor, -translationFactor, 0)
                
                cell.alpha = 1 - smoothOffset
            } else {
                cell.alpha = 1.0
            }
            
            cell.layer.transform = transform
        }
    }
}
