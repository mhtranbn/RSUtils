//
//  UIViewController+Orientation.swift
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
import Foundation
/**
 *  Use orientations with priority: last view controller, app supported orientations, default of navigation controller.
 */
class CMOrientationNavigationController: UINavigationController {
    func shouldAutorotate() -> Bool {
        let controller: UIViewController? = self.viewControllers.last
        if controller != nil {
            return controller?.shouldAutorotate ?? false
        }
        else {
            return super.shouldAutorotate
        }
    }
    func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        let controller: UIViewController? = viewControllers.last
        if controller != nil {
            return (controller?.supportedInterfaceOrientations)!
        }
        else {
            let mask: UIInterfaceOrientationMask = UIApplication.shared.supportedInterfaceOrientationsForMainWindow()
            if mask.rawValue != 0 {
                return mask
            }
            else {
                return super.supportedInterfaceOrientations
            }
        }
    }
}


class CMOrientationTabbarController: UITabBarController {
    func shouldAutorotate() -> Bool {
        let controller: UIViewController? = selectedViewController
        if controller != nil {
            return controller?.shouldAutorotate ?? false
        }
        else {
            return super.shouldAutorotate
        }
    }
    func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        let controller: UIViewController? = selectedViewController
        if controller != nil {
            return (controller?.supportedInterfaceOrientations)!
        }
        else {
            let mask: UIInterfaceOrientationMask = UIApplication.shared.supportedInterfaceOrientationsForMainWindow()
            if mask.rawValue != 0 {
                return mask
            }
            else {
                return super.supportedInterfaceOrientations
            }
        }
    }
}

extension UIApplication {
    func supportedInterfaceOrientationsForMainWindow() -> UIInterfaceOrientationMask {
        return supportedInterfaceOrientations(for: (delegate?.window)!)
    }
}

extension UIViewController {
    func getSupportedInterfaceOrientation() -> UIInterfaceOrientationMask {
        if navigationController != nil {
            return (navigationController?.getSupportedInterfaceOrientation())!
        }
        if tabBarController != nil {
            return (tabBarController?.getSupportedInterfaceOrientation())!
        }
        if shouldAutorotate {
            return supportedInterfaceOrientations
        }
        else {
            return []
        }
    }
}

