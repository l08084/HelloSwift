//
//  ViewController.swift
//  Sodateru
//
//  Created by 中安拓也 on 2015/11/13.
//  Copyright © 2015年 mycompany. All rights reserved.
//

import UIKit
import SpriteKit
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet weak var enField: UITextField!
    @IBOutlet weak var jaField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // シーンの作成
        let scene = GameScene()
        
        // View ControllerのViewをSKView型として取り出す
        let view = self.view as! SKView
        
        // FPSの表示
        view.showsFPS = true
        // ノード数の表示
        view.showsNodeCount = true
        
        // シーンのサイズをビューに合わせる
        scene.size = view.frame.size
        
        // ビュー上にシーンを表示
        view.presentScene(scene)
    }

    @IBAction func teachWord(sender: UIButton) {
        
        var myWord = Word()
        
        myWord.english = enField.text!
        myWord.japanese = jaField.text!
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(myWord)
        }
    }
    
    @IBAction func checkMemory(sender: AnyObject) {
        
        //　遷移するViewを定義する
        let mySecondViewController: UIViewController = SecondViewController()
        
        // アニメーションを設定する
        mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
        
        // Viewを移動
        self.presentViewController(mySecondViewController, animated: false, completion: nil)

    }
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

