//
//  VHelper.swift
//  Vote
//
//  Created by Grant Yuan on 2018/2/4.
//  Copyright © 2018年 林以达. All rights reserved.
//

import Foundation

typealias CancelableTask = (_ cancel: Bool) -> Void

func delay(_ delay: Double, closure: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        closure()
    }
}

func cancel(_ cancelableTask: CancelableTask?) {
    cancelableTask?(true)
}

func mainAsync(closure: @escaping ()->()) {
    DispatchQueue.main.async {
        closure()
    }
}

func synced(lock: AnyObject, closure: () -> ()) {
    objc_sync_enter(lock)
    closure()
    objc_sync_exit(lock)
}

func currentMilliseconds()->Int64 {
    return Int64(Date().timeIntervalSince1970 * 1000)
}
