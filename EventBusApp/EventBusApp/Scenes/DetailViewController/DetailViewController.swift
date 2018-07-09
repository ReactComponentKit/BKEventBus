//
//  DetailViewController.swift
//  EventBusApp
//
//  Created by burt on 2018. 7. 9..
//  Copyright © 2018년 skyfe79. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    static func viewController(item: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController")
        if let detailVC = vc as? DetailViewController {
            detailVC.item = item
        }
        return vc
    }

    @IBOutlet weak var detailLabel: UILabel!
    private var item: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailLabel.text = item
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
