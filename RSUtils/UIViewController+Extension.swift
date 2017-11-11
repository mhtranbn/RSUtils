//
//  UIViewController+Extension.swift
//  RSUtils
//
//  Created by mhtran on 11/2/17.
//  Copyright © 2017 mhtran. All rights reserved.
//
import Foundation
let VC_PRESENT_RETRY_TIME = 0.2

extension UIViewController {
    class func getTopViewController(from viewController: UIViewController) -> UIViewController {
        if (viewController is UINavigationController) {
            let naviController = viewController as? UINavigationController
            if let count = naviController?.viewControllers.count, count > 0 {
                return self.getTopViewController(from: (naviController?.viewControllers.last)!)
            }
            else {
                return naviController ?? UIViewController()
            }
        }
        else if (viewController is UITabBarController) {
            let tabController = viewController as? UITabBarController
            if tabController?.selectedViewController != nil {
                return self.getTopViewController(from: (tabController?.selectedViewController)!)
            }
            else {
                return tabController ?? UIViewController()
            }
        }
        else {
            return viewController
        }
    }
    class func getTop() -> UIViewController? {
        let rootController: UIViewController? = UIApplication.shared.delegate?.window??.rootViewController
        if rootController != nil {
            let topController: UIViewController? = rootController?.getTopPresented()
            return self.getTopViewController(from: topController!)
        }
        return nil
    }
    class func presentOnTop(with viewController: UIViewController, animated flag: Bool, completion: @escaping () -> Void) -> UIViewController {
        let topViewController: UIViewController? = self.getTop()
        if topViewController != nil {
            return topViewController?.presentOnTop(with: viewController, animated: flag, completion: completion) ?? UIViewController()
        }
        return topViewController ?? UIViewController()
    }
    func getTopPresented() -> UIViewController {
        var controller: UIViewController? = self
        while controller?.presentedViewController != nil {
            controller = controller?.presentedViewController
        }
        return controller ?? UIViewController()
    }
    func searchStatble() -> UIViewController {
        var controller: UIViewController? = self
        while controller?.presentingViewController != nil && (controller?.presentingViewController?.isBeingDismissed)! {
            controller = controller?.presentingViewController
        }
        return controller ?? UIViewController()
    }
    func presentOnTop(with viewController: UIViewController, animated flag: Bool, completion: @escaping () -> Void) -> UIViewController? {
        let controller: UIViewController? = getTopPresented()
        if controller?.isBeingPresented != nil {
            delayToMain(seconds: VC_PRESENT_RETRY_TIME, block: {() -> Void in
                if let vc = controller {
                  _ = vc.presentOnTop(with: viewController, animated: flag, completion: completion)
                }
            }())
            return nil
        }
        else if controller?.isBeingDismissed != nil {
            weak var presentingVC: UIViewController? = controller?.searchStatble()
            delayToMain(seconds: VC_PRESENT_RETRY_TIME, block: {() -> Void in
                if presentingVC != nil {
                    _ = presentingVC?.presentOnTop(with: viewController, animated: flag, completion: completion)
                }
                else {
                    _ = UIViewController.presentOnTop(with: viewController, animated: flag, completion: completion)
                }
            }())
            return nil
        }
        else {
            controller?.present(viewController, animated: flag, completion: completion)
            return controller ?? UIViewController()
        }
    }
}
