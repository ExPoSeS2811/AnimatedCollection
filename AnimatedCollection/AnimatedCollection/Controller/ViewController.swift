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
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            if let cellToAnimate = homeAnimationCollectionView.visibleCells.first {
                let finalPosition = CGPoint(x: 0, y: scrollView.contentOffset.y)
                
                UIView.animate(withDuration: 0.3) {
                    cellToAnimate.frame = CGRect(origin: finalPosition, size: cellToAnimate.frame.size)
                }
            }
        }
    }
}

class MyCollectionViewCell: UICollectionViewCell {
    // Здесь может быть ваш код для настройки ячейки
}
