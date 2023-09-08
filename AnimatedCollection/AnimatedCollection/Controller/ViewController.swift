//
//  ViewController.swift
//  AnimatedCollection
//
//  Created by Gleb Rasskazov on 08.09.2023.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width - 32, height: (view.frame.height - 96) / 2)
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        view.addSubview(collectionView)
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
        cell.backgroundColor = .blue
        cell.layer.cornerRadius = 16
        cell.layer.cornerCurve = .continuous
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
