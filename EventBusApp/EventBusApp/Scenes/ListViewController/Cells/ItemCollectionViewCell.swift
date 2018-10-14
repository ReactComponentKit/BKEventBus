//
//  ItemCollectionViewCell.swift
//  EventBusApp
//
//  Created by burt on 2018. 7. 9..
//  Copyright © 2018년 skyfe79. All rights reserved.
//

import UIKit
import EventBus

class ItemCollectionViewCell: UICollectionViewCell {
    
    enum Event: EventType {
        case clickedDeleteButton(indexPath: IndexPath)
        case clickedDetailButton(indexPath: IndexPath)
    }
    
    static var className: String {
        return String(describing: self)
    }

    @IBOutlet weak var dateLabel: UILabel!

    private var indexPath: IndexPath? = nil
    private var eventBus: EventBus<ItemCollectionViewCell.Event>? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        eventBus = nil
    }
    
    func configure(item: String, indexPath: IndexPath, token: Token? = nil) {
        self.dateLabel.text = item
        self.indexPath = indexPath
        eventBus = EventBus(token: token)
    }
    
    @IBAction func clickedDetailButton(_ sender: Any) {
        guard let indexPath = indexPath else { return }
        eventBus?.post(event: .clickedDetailButton(indexPath: indexPath))
    }
    
    @IBAction func clickedDeleteButton(_ sender: Any) {
        guard let indexPath = indexPath else { return }
        eventBus?.post(event: .clickedDeleteButton(indexPath: indexPath))
    }
}
