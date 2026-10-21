//
//  MessageBubbleView.swift
//  MessageBubble
//
//  Created by Hosung.Kim on 2026.10.19.
//

import UIKit

import MessageBubbleCore

public class MessageBubbleView: UIView {
    
    // MARK: - Public Property
    
    public var tailLength: Float = 8.0 {
        didSet {
            updateTailLength()
        }
    }
    
    public var tailPlacement: TailPlacement {
        didSet {
            updateTailPlacement()
        }
    }
    
    public var messagePadding: MessagePadding = .init(horizontal: 12, vertical: 8) {
        didSet {
            updateMessagePadding()
        }
    }
    
    public var font: UIFont {
        get {
            return messageLabel.font
        }
        set {
            messageLabel.font = newValue
            updateCornerRadius()
        }
    }
    
    public var text: String? {
        get {
            return messageLabel.text
        }
        set {
            messageLabel.text = newValue
        }
    }
    
    public var showsTail: Bool {
        get {
            return !messageBubbleTailView.isHidden
        }
        set {
            messageBubbleTailView.isHidden = !newValue
        }
    }
    
    public var fillColor: UIColor = .init(red: 39/255, green: 149/255, blue: 252/255, alpha: 1) {
        didSet {
            updateFillColor()
        }
    }
    public var textColor: UIColor {
        get {
            return messageLabel.textColor
        }
        set {
            messageLabel.textColor = newValue
        }
    }
    
    public enum CornerRadius {
        case automatic
        case fixed(Float)
    }
    public var cornerRadius: CornerRadius = .automatic {
        didSet {
            updateCornerRadius()
        }
    }
    private var resolvedCornerRadius: Float {
        get {
            switch cornerRadius {
            case .automatic:
                return (Float(font.lineHeight) + messagePadding.top + messagePadding.bottom) / 2
            case let .fixed(fixed):
                return fixed
            }
        }
    }
    
    // MARK: - View
    
    private let messageContainerView = UIView().configured {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
    }
    
    private let messageLabel = UILabel().configured {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 14)
    }
    
    private let messageBubbleTailView = MessageBubbleTailView().configured {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Constraint
    
    private lazy var messageContainerLeadingConstraint = messageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor)
    private lazy var messageContainerTrailingConstraint = messageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor)
    
    private lazy var messagePaddingTopConstraint = messageLabel.topAnchor.constraint(equalTo: messageContainerView.topAnchor, constant: CGFloat(messagePadding.top))
    private lazy var messagePaddingLeadingConstraint = messageLabel.leadingAnchor.constraint(equalTo: messageContainerView.leadingAnchor, constant: CGFloat(messagePadding.leading))
    private lazy var messagePaddingTrailingConstraint = messageLabel.trailingAnchor.constraint(equalTo: messageContainerView.trailingAnchor, constant: -CGFloat(messagePadding.trailing))
    private lazy var messagePaddingBottomConstraint = messageLabel.bottomAnchor.constraint(equalTo: messageContainerView.bottomAnchor, constant: -CGFloat(messagePadding.bottom))
    
    private lazy var tailTopConstraint = messageBubbleTailView.topAnchor.constraint(equalTo: topAnchor)
    private lazy var tailLeadingConstraint = messageBubbleTailView.leadingAnchor.constraint(equalTo: leadingAnchor)
    private lazy var tailBottomConstraint = messageBubbleTailView.bottomAnchor.constraint(equalTo: bottomAnchor)
    private lazy var tailTrailingConstraint = messageBubbleTailView.trailingAnchor.constraint(equalTo: trailingAnchor)
    private lazy var tailWidthConstraint = messageBubbleTailView.widthAnchor.constraint(equalToConstant: CGFloat(resolvedCornerRadius + tailLength))
    private lazy var tailHeightConstraint = messageBubbleTailView.heightAnchor.constraint(equalToConstant: CGFloat(resolvedCornerRadius))
    
    // MARK: - Basic
    
    public init(tailPlacement: TailPlacement) {
        self.tailPlacement = tailPlacement
        
        super.init(frame: .zero)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        setupHierarchy()
        setupLayout()
        updateTailLength()
        updateTailPlacement()
        updateMessagePadding()
        updateFillColor()
        updateCornerRadius()
    }
    
    private func setupHierarchy() {
        addSubview(messageBubbleTailView)
        addSubview(messageContainerView)
        messageContainerView.addSubview(messageLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            messagePaddingTopConstraint,
            messagePaddingLeadingConstraint,
            messagePaddingBottomConstraint,
            messagePaddingTrailingConstraint,
            
            messageContainerView.topAnchor.constraint(equalTo: topAnchor),
            messageContainerLeadingConstraint,
            messageContainerTrailingConstraint,
            messageContainerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            tailWidthConstraint,
            tailHeightConstraint,
        ])
    }
    
    // MARK: - Update
    
    private func updateTailLength() {
        switch tailPlacement.horizontal {
        case .leading:
            messageContainerLeadingConstraint.constant = CGFloat(tailLength)
            messageContainerTrailingConstraint.constant = 0
        case .trailing:
            messageContainerLeadingConstraint.constant = 0
            messageContainerTrailingConstraint.constant = CGFloat(-tailLength)
        }
        
        tailWidthConstraint.constant = CGFloat(resolvedCornerRadius + tailLength)
    }
    
    private func updateTailPlacement() {
        switch tailPlacement.horizontal {
        case .leading:
            tailLeadingConstraint.isActive = true
            tailTrailingConstraint.isActive = false
            
            messageContainerLeadingConstraint.constant = CGFloat(tailLength)
            messageContainerTrailingConstraint.constant = 0
        case .trailing:
            tailLeadingConstraint.isActive = false
            tailTrailingConstraint.isActive = true
            
            messageContainerLeadingConstraint.constant = 0
            messageContainerTrailingConstraint.constant = CGFloat(-tailLength)
        }
        
        switch tailPlacement.vertical {
        case .top:
            tailTopConstraint.isActive = true
            tailBottomConstraint.isActive = false
        case .bottom:
            tailTopConstraint.isActive = false
            tailBottomConstraint.isActive = true
        }
    }
    
    private func updateMessagePadding() {
        messagePaddingTopConstraint.constant = CGFloat(messagePadding.top)
        messagePaddingLeadingConstraint.constant = CGFloat(messagePadding.leading)
        messagePaddingBottomConstraint.constant = -CGFloat(messagePadding.bottom)
        messagePaddingTrailingConstraint.constant = -CGFloat(messagePadding.trailing)
        
        updateCornerRadius()
    }
    
    private func updateCornerRadius() {
        messageContainerView.layer.cornerRadius = CGFloat(resolvedCornerRadius)
        tailWidthConstraint.constant = CGFloat(resolvedCornerRadius + tailLength)
        tailHeightConstraint.constant = CGFloat(resolvedCornerRadius)
    }
    
    private func updateFillColor() {
        messageContainerView.backgroundColor = fillColor
        messageBubbleTailView.fillColor = fillColor
    }
}
