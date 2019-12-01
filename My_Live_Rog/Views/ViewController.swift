//
//  ViewController.swift
//  My_Live_Rog
//
//  Created by 妙中美月 on 2019/05/19.
//  Copyright © 2019 妙中美月. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var livehouseLabel: UILabel!
    @IBOutlet var whoseLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var openLabel: UILabel!
    @IBOutlet var stertLabel: UILabel!
    @IBOutlet var finishLabel: UILabel!
    @IBOutlet var ticketLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setSwipeBack()
        
        view.backgroundColor = UIColor.gray
        
        let swipeRightGesture: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeDown))
        swipeRightGesture.numberOfTouchesRequired = 1
        swipeRightGesture.direction = UISwipeGestureRecognizer.Direction.down
        self.view.addGestureRecognizer(swipeRightGesture)
        
        view.backgroundColor = UIColor.gray
    }

    @objc func handleSwipeDown(sender: UISwipeGestureRecognizer){
        
        print("yeah")
        self.dismiss(animated: true, completion: nil)
        
        return
    }


}

extension UIViewController {
    
    func setSwipeBack() {
        let target = self.navigationController?.value(forKey: "_cachedInteractionController")
        let recognizer = UIPanGestureRecognizer(target: target, action: Selector(("handleNavigationTransition:")))
        self.view.addGestureRecognizer(recognizer)
        print("yeah")
    }
}
