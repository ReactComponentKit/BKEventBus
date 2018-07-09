//
//  EventBus.swift
//  EventBusApp
//
//  Created by burt on 2018. 2. 27..
//  Copyright © 2018년 skyfe79. All rights reserved.
//

import UIKit

// Mark as Event
protocol Event {
    
}

class EventBus<T: Event> {
    
    private typealias EventHandler = (T) -> Void
    private var eventHandler: EventHandler? = nil
    private var isAlive: Bool = true
    private lazy var eventName: Notification.Name = {
        let eventTypeName = String(describing: T.self)
        return Notification.Name("NOTIFY_EVENTBUS_POST_\(eventTypeName)_EVENT")
    }()
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(processNotification(_:)), name: eventName, object: nil)
    }
    
    @objc private func processNotification(_ notificaton: Notification) {
        // ignore events if didn't alive
        guard isAlive == true else { return }
        // ignore notification if same eventbus.
        guard let sender = notificaton.object as? EventBus<T>, sender !== self else { return }
        guard let userInfo = notificaton.userInfo else { return }
        guard let event = userInfo["event"] as? T else { return }
        handle(event: event)
    }
    
    func post(event: T) {
        NotificationCenter.default.post(name: eventName, object: self, userInfo: [
            "event": event
        ])
    }
    
    private func handle(event: T) {
        guard let eventHandler = eventHandler else { return }
        eventHandler(event)
    }
    
    func on(event: @escaping (T) -> Void) {
        eventHandler = event
    }
    
    func resume() {
        isAlive = true
    }
    
    func stop() {
        isAlive = false
    }
    
    deinit {
        eventHandler = nil
        NotificationCenter.default.removeObserver(self, name: eventName, object: nil)
    }
}
