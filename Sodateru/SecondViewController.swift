//
//  File.swift
//  Sodateru
//
//  Created by 中安拓也 on 2015/11/14.
//  Copyright © 2015年 mycompany. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 背景色を設定
        self.view.backgroundColor = UIColor.blueColor()
        
        // ボタンを作成
        let backButton: UIButton = UIButton(frame: CGRectMake(0, 0, 120, 50))
        backButton.backgroundColor = UIColor.redColor()
        backButton.layer.masksToBounds = true
        backButton.setTitle("Back", forState: .Normal)
        backButton.layer.cornerRadius = 20.0
        backButton.layer.position = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height - 50)
        backButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(backButton)
    }
    
    internal func onClickMyButton(sender: UIButton) {
        
        // 遷移するViewを定義
        let myViewController: UIViewController = ViewController()
        
        // アニメーションを設定
        myViewController.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        
        // Viewの移動
        self.presentViewController(myViewController, animated: true, completion: nil)
    }
}
