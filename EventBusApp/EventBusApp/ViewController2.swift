//
//  ViewController2.swift
//  EventBusApp
//
//  Created by burt on 2018. 2. 27..
//  Copyright © 2018년 skyfe79. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    private let eventBus: EventBus<Actions> = EventBus()
    
    @IBAction func clickedPostEvent2Button(_ sender: Any) {
        eventBus.post(event: Actions.Minus(10, 20))
    }
}
