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

    @IBOutlet weak var selectBox: UIButton!
    @IBOutlet weak var speakLabel: UILabel!
    
    //選択値
    var selected = "選択してください"
    
    @IBAction func talking(sender: UIButton) {
        
        let act = Action()
        let speak = act.generateASentence("NV")
        speakLabel.text = speak
        print("talk:\(speak)")
        //act.execTest()
    }
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
        
        self.setView()
    }
    
    func setView() {
        
        // プルダウンをボタンで実装
        selectBox.frame = CGRectMake(0, 0, 100, 100)
        
        selectBox.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        
    }
    
    // プルダウン（ボタン）がタップされたらプルダウン用の別画面を開く
    @IBAction func clickButtonSelect(sender: UIButton) {
        
        // 遷移するViewを定義する.
        let mySecondViewController: UIViewController = SecondViewController()
        
        // アニメーションを設定する.
        mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
        
        // Viewの移動する.
        self.presentViewController(mySecondViewController, animated: false, completion: nil)
    }
    
    @IBAction func nounClickButton(sender: UIButton) {
        
        // 遷移するViewを定義する.
        let nounViewController: UIViewController = NounViewController()
        
        // アニメーションを設定する.
        nounViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
        
        // Viewの移動する.
        self.presentViewController(nounViewController, animated: false, completion: nil)
        
    }
    @IBAction func adjectiveClickButton(sender: UIButton) {
        
        // 遷移するViewを定義する.
        let adjectiveViewController: UIViewController = AdjectiveViewController()
        
        // アニメーションを設定する.
        adjectiveViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
        
        // Viewの移動する.
        self.presentViewController(adjectiveViewController, animated: false, completion: nil)

    }
    
    
    // プルダウン選択後に戻ってきたら、選択値を取得してviewを再描画します
   override func viewWillAppear(animated: Bool) {
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.selected = appDelegate.params
        print("params: \(appDelegate.params)")
        self.setView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

