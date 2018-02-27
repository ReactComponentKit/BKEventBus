//
//  EventBus.swift
//  EventBusApp
//
//  Created by burt on 2018. 2. 27..
//  Copyright © 2018년 skyfe79. All rights reserved.
//

import UIKit

// 이벤트버스로 주고 받을 이벤트임을 표시한다.
// enum에 적용하면 인자가 있는 이벤트를 주고 받고 할 수 있다.
protocol Event {
    
}

extension Notification.Name {
    fileprivate static let NOTIFY_EVENTBUS_POST_EVENT = "NOTIFY_EVENTBUS_POST_EVENT".notificationName
}

extension String {
    fileprivate var notificationName: Notification.Name {
        return Notification.Name(self)
    }
}


class EventBus<T: Event> {
    
    private typealias EventHandler = (T) -> Void
    private var eventHandler: EventHandler? = nil
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(processNotification(_:)), name: .NOTIFY_EVENTBUS_POST_EVENT, object: nil)
    }
    
    @objc private func processNotification(_ notificaton: Notification) {
        // 같은 이벤트 버스이면 이벤트를 처리하지 않는다.
        guard let sender = notificaton.object as? EventBus<T>, sender !== self else { return }
        guard let userInfo = notificaton.userInfo else { return }
        guard let event = userInfo["event"] as? T else { return }
        handle(event: event)
    }
    
    func post(event: T) {
        NotificationCenter.default.post(name: .NOTIFY_EVENTBUS_POST_EVENT, object: self, userInfo: [
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
    
    deinit {
        eventHandler = nil
        NotificationCenter.default.removeObserver(self, name: .NOTIFY_EVENTBUS_POST_EVENT, object: nil)
    }
}
