//
//  TailPlacement.swift
//  MessageBubble
//
//  Created by Hosung.Kim on 2026.10.20.
//

import Foundation

public struct TailPlacement {
    
    public enum Horizontal {
        case leading
        case trailing
    }
    
    public enum Vertical {
        case top
        case bottom
    }
    
    public let horizontal: Horizontal
    public let vertical: Vertical
    
    public init(horizontal: Horizontal, vertical: Vertical) {
        self.horizontal = horizontal
        self.vertical = vertical
    }
}
