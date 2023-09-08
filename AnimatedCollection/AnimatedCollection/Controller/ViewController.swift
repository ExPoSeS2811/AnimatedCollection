import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupUI()
    }
    
    
    private func setupUI() {
        view.addSubview(homeAnimationCollectionView)
        NSLayoutConstraint.activate([
            homeAnimationCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            homeAnimationCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeAnimationCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeAnimationCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AnimatedCollectionViewCell.identifier, for: indexPath) as! AnimatedCollectionViewCell
        return cell
    }
}

extension ViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let center = collectionView.center
        
        for cell in collectionView.visibleCells {
            guard let indexPath = collectionView.indexPath(for: cell) else { continue }
            let offset = cell.center.y - collectionView.contentOffset.y
            let normalizedOffset = abs(center.y - offset) / center.y
            let smoothOffset = normalizedOffset * normalizedOffset
            
            var transform = CATransform3DIdentity
            
            if offset < center.y, indexPath.row != 0 || scrollView.contentOffset.y > 0 {
                transform.m34 = -1.0 / 1000.0
                let rotation = smoothOffset * .pi / 3.0
                transform = CATransform3DRotate(transform, rotation, 1, 1, 0)
                
                let translationFactor = -cell.bounds.width * 0.7 * smoothOffset
                transform = CATransform3DTranslate(transform, translationFactor, -translationFactor, 0)
                
                cell.alpha = 1 - smoothOffset
            } else {
                cell.alpha = 1.0
            }
            
            cell.layer.transform = transform
        }
    }
}

class MyCollectionViewCell: UICollectionViewCell {}
