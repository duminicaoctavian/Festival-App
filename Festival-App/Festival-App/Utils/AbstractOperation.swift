//
//  AbstractOperation.swift
//  Festival-App
//
//  Created by Octavian Duminica on 22/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

private struct Key {
    static let isExecuting = "isExecuting"
    static let isFinished = "isFinished"
}

class AbstractOperation: Operation {
    
    private var isStarted: Bool = false
    
    override var isAsynchronous: Bool {
        return true
    }
    
    var _executing: Bool = false {
        willSet {
            willChangeValue(forKey: Key.isExecuting)
        }
        didSet {
            didChangeValue(forKey: Key.isExecuting)
        }
    }
    
    override var isExecuting: Bool {
        return _executing
    }
    
    var _finished: Bool = false {
        willSet {
            willChangeValue(forKey: Key.isFinished)
        }
        didSet {
            didChangeValue(forKey: Key.isFinished)
        }
    }
    
    override var isFinished: Bool {
        return _finished
    }
    
    override func start() {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        _executing = true
        _finished = false
        
        execute()
    }
    
    open func execute() {
        if !isCancelled {
            execute()
        } else {
            finished(error: nil)
        }
    }
    
    func finished(error: String?) {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        _finished = true
        _executing = false
    }
    
    override func cancel() {
        super.cancel()
        
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        _executing = false
        _finished = true
    }
}


