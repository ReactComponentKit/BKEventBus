//
//  ViewController.swift
//  EventBusApp
//
//  Created by burt on 2018. 2. 27..
//  Copyright © 2018년 skyfe79. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let eventBus: EventBus<Actions> = EventBus()

    override func viewDidLoad() {
        super.viewDidLoad()
        eventBus.on(event: { (actions) in
            switch actions {
            case let .Add(a, b):
                print(a - b)
            case .Minus:
                print("Minus")
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func clickedPostEventButton(_ sender: Any) {
        eventBus.post(event: Actions.Add(10, 20))
    }
}

