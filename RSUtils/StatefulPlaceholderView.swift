//
//  StatefulPlaceholderView.swift
//  RSUtils
//
//  Created by mhtran on 11/11/17.
//  Copyright © 2017 mhtran. All rights reserved.
//

import UIKit

public protocol StatefulPlaceholderView {
    /// Defines the insets to apply when presented via the `StatefulViewController`
    /// Return insets here in order to inset the current placeholder view from the edges 
    /// of the parent view.
    func placeholderViewInsets() -> UIEdgeInsets
}

extension StatefulPlaceholderView {

    public func placeholderViewInsets() -> UIEdgeInsets {
        return UIEdgeInsets()
    }

}
