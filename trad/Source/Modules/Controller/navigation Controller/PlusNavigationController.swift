//
//  PlusNavigationController.swift
//  trad
//
//  Created by Imac on 10/05/21.
//

import UIKit

class PlusNavigationController: UINavigationController {

    open override var childForStatusBarHidden: UIViewController? {
        return self.topViewController
    }
    open override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
}
