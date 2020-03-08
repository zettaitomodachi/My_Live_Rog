//
//  TabBarController.swift
//  My_Live_Rog
//
//  Created by 妙中美月 on 2019/11/17.
//  Copyright © 2019 妙中美月. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        selectedIndex = 0
    }
}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is NewLiveViewController {
            let newLiveViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "NewLiveViewController")
            newLiveViewController.modalPresentationStyle = .fullScreen
            tabBarController.present(newLiveViewController, animated: true, completion: nil)
        }
        
        return true
    }
}

