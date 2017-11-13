//
//  AttributedLabel.swift
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
import UIKit

/**
 Create your own lable class and use this class as it's base class. override the configureAttributedLabel function and set the self.attributedText to your prefered styling. For instance self.attributedText = self.text?.myHeader.attributedText See the samples for how you could add your own custom property for interface builder and alsu use that.
 */
@IBDesignable open class AttributedLabel: UILabel {
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        configureAttributedLabel()
    }
    
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        configureAttributedLabel()
    }
    
    override open var text: String? {
        didSet {
            configureAttributedLabel()
        }
    }
    
    open func configureAttributedLabel() {
    }
}
