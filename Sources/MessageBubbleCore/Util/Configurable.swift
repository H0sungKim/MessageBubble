//
//  Configurable.swift
//  MessageBubble
//
//  Created by Hosung.Kim on 2026.10.20.
//

import Foundation

public protocol Configurable {
    
}

extension Configurable where Self: AnyObject {
    @inlinable public func configured(_ block: (_ target: Self) throws -> Void) rethrows -> Self {
        try block(self)
        return self
    }
}

extension NSObject: Configurable { }
