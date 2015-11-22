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
    
    var selected = "選択してください"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // シーンの作成
        let scene = GameScene()
        
        //self.view = SKView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
        
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
        var buttonSelect: UIButton = UIButton()
        buttonSelect.frame = CGRectMake(0, 0, 100, 100)
        buttonSelect.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        buttonSelect.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        buttonSelect.addTarget(self, action: "clickButtonSelect:", forControlEvents: .TouchUpInside)
        buttonSelect.setTitle(selected, forState: UIControlState.Normal)
        self.view.addSubview(buttonSelect)
    }
    
    // プルダウン（ボタン）がタップされたらプルダウン用の別画面を開く
    func clickButtonSelect(sender: UIButton) {
        var viewController: SecondViewController = SecondViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    // プルダウン選択後に戻ってきたら、選択値を取得してviewを再描画します
    override func viewWillAppear(animated: Bool) {
        var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.selected = appDelegate.params
        self.setView()
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
 
    @IBAction func verbClicked(sender: AnyObject) {
    }
    @IBAction func nounClicked(sender: AnyObject) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

