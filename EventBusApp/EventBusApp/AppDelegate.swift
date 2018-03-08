//
//  AppDelegate.swift
//  EventBusApp
//
//  Created by burt on 2018. 2. 27..
//  Copyright © 2018년 skyfe79. All rights reserved.
//

import UIKit

enum Actions: Event {
    case Add(Int, Int)
    case Minus(Int, Int)
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var eventBus: EventBus<Actions> = EventBus()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
        eventBus.on(event: { (actions) in
            switch actions {
            case let .Add(a, b):
                print("[AppDelegate] \(a + b)")
            case let .Minus(a, b):
                print("[AppDelegate] \(a - b)")
            }
        })
        
        return true
    }

}

