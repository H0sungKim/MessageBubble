//
//  MessageBubbleTailView.swift
//  MessageBubble
//
//  Created by Hosung.Kim on 2026.10.20.
//

import UIKit

import MessageBubbleCore

internal final class MessageBubbleTailView: UIView {
    
    internal var tailPlacement: TailPlacement = .init(horizontal: .trailing, vertical: .top) {
        didSet {
            setNeedsDisplay()
        }
    }
    
    internal var fillColor: UIColor = .init(red: 39/255, green: 149/255, blue: 252/255, alpha: 1) {
        didSet {
            setNeedsDisplay()
        }
    }
    
    internal override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal override func draw(_ rect: CGRect) {
        let tailX: CGFloat = switch tailPlacement.horizontal {
        case .leading:
            -rect.width
        case .trailing:
            rect.minX
        }
        
        let tailY: CGFloat = switch tailPlacement.vertical {
        case .top:
            rect.minY
        case .bottom:
            -rect.height
        }
        
        let tailWidth: CGFloat = rect.width * 2
        let tailHeight: CGFloat = rect.height * 2
        
        let cutterX: CGFloat = switch tailPlacement.horizontal {
        case .leading:
            rect.height - rect.width
        case .trailing:
            rect.height
        }
        
        let cutterY: CGFloat = switch tailPlacement.vertical {
        case .top:
            rect.minY
        case .bottom:
            -rect.height
        }
        
        let cutterWidth: CGFloat = (rect.width - rect.height) * 2
        let cutterHeight: CGFloat = rect.height * 2
        
        let tail = UIBezierPath(
            ovalIn: CGRect(x: tailX, y: tailY, width: tailWidth, height: tailHeight)
        )
        
        let cutter = UIBezierPath(
            ovalIn: CGRect(x: cutterX, y: cutterY, width: cutterWidth, height: cutterHeight)
        ).reversing()
        
        tail.append(cutter)
        fillColor.setFill()
        tail.fill()
    }
}
