//
//  CMBaseCustomView.swift
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
import UIKit

class CMBaseCustomView: UIView {
    
    @IBOutlet weak var viewContent: UIView!
    var originalContentSize = CGSize.zero

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadContentViewFromXib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func viewDidLoad() {
        // SUBCLASS
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadContentViewFromXib()
    }
    
    class func addFillLayoutConstrains(for view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.superview?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[view]|", options: [], metrics: nil, views: ["view": view]))
        view.superview?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: [], metrics: nil, views: ["view": view]))
    }
    
    func loadContentViewFromXib() {
        if viewContent == nil {
            let bundle = Bundle(for: type(of: self))
            var nibName: String = NSStringFromClass(type(of: self))
            if ((nibName as NSString).range(of: ".")).location != NSNotFound {
                nibName = URL(fileURLWithPath: nibName).pathExtension
            }
            var viewArray: [UIView]? = nil
            if bundle.path(forResource: nibName, ofType: "nib") != nil {
                defer {
                }
                do {
                    if let arrayview = bundle.loadNibNamed(nibName, owner: self, options: nil) as? [UIView] {
                        viewArray = arrayview
                    }
                }
            }
            else {
                print("CUSTOM VIEW: couldn't find xib \(nibName) from bundle \(bundle.bundlePath)")
            }
            if viewContent == nil {
                if viewArray == nil || viewArray?.count == 0 {
                    return
                }
                viewContent = viewArray?[0]
            }
            originalContentSize = (viewContent?.frame.size)!
            viewContent?.frame = bounds
            viewContent?.translatesAutoresizingMaskIntoConstraints = false
            addSubview(viewContent!)
            var constraints = NSLayoutConstraint.constraints(withVisualFormat: "|-0-[view]-0-|", options: .alignAllLeading, metrics: ["0": 0], views: ["view": viewContent])
            addConstraints(constraints)
            constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|", options: .alignAllTop, metrics: ["0": 0], views: ["view": viewContent])
            addConstraints(constraints)
            layoutIfNeeded()
            viewDidLoad()
        }
    }
}

extension UIButton {
    
    func isUsable() -> Bool {
        return isEnabled && isUserInteractionEnabled && !isHidden
    }
    
    func setUsable(_ usable: Bool) {
        isUserInteractionEnabled = usable
        isEnabled = isUserInteractionEnabled
        isHidden = !usable
    }
}

