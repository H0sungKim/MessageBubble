//
//  MessagePadding.swift
//  MessageBubble
//
//  Created by Hosung.Kim on 2026.10.20.
//

import Foundation

public struct MessagePadding {
    
    public let top: Float
    public let leading: Float
    public let bottom: Float
    public let trailing: Float
    
    public init(top: Float, leading: Float, bottom: Float, trailing: Float) {
        self.top = top
        self.leading = leading
        self.bottom = bottom
        self.trailing = trailing
    }
    
    public init(horizontal: Float, vertical: Float) {
        self.top = vertical
        self.leading = horizontal
        self.bottom = vertical
        self.trailing = horizontal
    }
    
    public init(padding: Float) {
        self.top = padding
        self.leading = padding
        self.bottom = padding
        self.trailing = padding
    }
}
