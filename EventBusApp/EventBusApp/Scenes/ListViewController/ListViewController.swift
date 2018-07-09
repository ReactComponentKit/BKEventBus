//
//  ListViewController.swift
//  EventBusApp
//
//  Created by burt on 2018. 7. 9..
//  Copyright © 2018년 skyfe79. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var items: [String] = []
    private let eventBus = EventBus<ItemCollectionViewCell.Event>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Date List"
        collectionView.register(UINib(nibName: ItemCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: ItemCollectionViewCell.className)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        eventBus.on { [weak self] (event: ItemCollectionViewCell.Event) in
            guard let strongSelf = self else { return }
            switch event {
            case let .clickedDeleteButton(indexPath):
                strongSelf.items.remove(at: indexPath.row)
                strongSelf.collectionView.reloadData()
            case let .clickedDetailButton(indexPath):
                let item = strongSelf.items[indexPath.row]
                let vc = DetailViewController.viewController(item: item)
                strongSelf.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    @IBAction func clickedAddButtonItem(_ sender: Any) {
        let date = Date()
        items.append(date.description)
        collectionView.reloadData()
    }
}

extension ListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.className, for: indexPath)
        if let itemCell = cell as? ItemCollectionViewCell {
            itemCell.configure(item: items[indexPath.row], indexPath: indexPath)
        }
        return cell
    }

}
