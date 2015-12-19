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
    
    // セレクトボックス
    @IBOutlet weak var selectBox: UIButton!
    @IBOutlet weak var selectNounBox: UIButton!
    @IBOutlet weak var selectPronounBox: UIButton!
    
    @IBOutlet weak var speakLabel: UILabel!
    
    //セレクトボックス画面から値を受け取る
    var paramV :String = ""
    var paramN :String = ""
    var paramP :String = ""
    
    var act :Action = Action()
    
    let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    /**
     * 話すボタン押下
     **/
    @IBAction func talking(sender: UIButton) {
        
        let speak = act.generateASentence("NV")
        speakLabel.text = speak
        print("talk:\(speak)")
        act.registerASentence(speak + ",-")
    }
    
    /**
     * 登録ボタン押下
     **/
    @IBAction func wordRegister(sender: AnyObject) {
        print("register")
        
        // 動詞に単語が設定されていた場合
        if selectBox.titleLabel!.text != "動詞" {
            print("動詞:\(selectBox.titleLabel!.text)")
            act.registerAWord(selectBox.titleLabel!.text!, part: "verb")
            
            //ボタンのラベルをデフォルトに戻す
            selectBox.setTitle("動詞", forState: .Normal)
            appDelegate.verb = ""
        }
        
        // 名詞に単語が設定されていた場合
        if selectNounBox.titleLabel!.text != "名詞" {
            print("名詞：\(selectNounBox.titleLabel!.text)")
            act.registerAWord(selectNounBox.titleLabel!.text!, part: "noun")
            
            //ボタンのラベルをデフォルトに戻す
            selectNounBox.setTitle("名詞", forState: .Normal)
            appDelegate.noun = ""
        }
        
        // 形容詞に単語が設定されていた場合
        if selectPronounBox.titleLabel!.text != "形容詞" {
            print("形容詞：\(selectPronounBox.titleLabel!.text)")
            act.registerAWord(selectPronounBox.titleLabel!.text!, part: "pronoun")
            
            //ボタンのラベルをデフォルトに戻す
            selectPronounBox.setTitle("形容詞", forState: .Normal)
            appDelegate.pronoun = ""
        }
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
        
    }
    
    // 動詞ボタンがタップされたらプルダウン用の別画面を開く
    @IBAction func clickButtonSelect(sender: UIButton) {
        
    }
    
    // 名詞ボタンがタップされたらプルダウン用の別画面を開く
    @IBAction func nounClickButton(sender: UIButton) {
        
    }
    
    // 代名詞ボタンがタップされたらプルダウン用の別画面を開く
    @IBAction func adjectiveClickButton(sender: UIButton) {
        
    }
    
    
    // プルダウン選択後に戻ってきたら、選択値を取得してセレクトボックスを再描画します
   override func viewWillAppear(animated: Bool) {
    
        print("paramsV: \(appDelegate.verb)")
        print("paramsN: \(appDelegate.noun)")
        print("paramsP: \(appDelegate.pronoun)")
    
        //プルダウン用の画面から値を受け取る
        paramV = appDelegate.verb
        paramN = appDelegate.noun
        paramP = appDelegate.pronoun
    
        // 動詞が設定された場合
        if !paramV.isEmpty {
            selectBox.setTitle(paramV, forState: .Normal)
        }
    
        // 名詞が設定された場合
        if !paramN.isEmpty {
            selectNounBox.setTitle(paramN, forState: .Normal)
        }
    
        // 代名詞が設定された場合
        if !paramP.isEmpty {
            selectPronounBox.setTitle(paramP, forState: .Normal)
        }
    }
    
    // ⚪︎ボタン押下
    @IBAction func sentenceOK(sender: AnyObject) {
        print("OK:\(speakLabel.text)")
        act.learnASentence(speakLabel.text!, tORf: true)
    }
    
    // ×ボタン押下
    @IBAction func sentenceNG(sender: AnyObject) {
        print("NG:\(speakLabel.text)")
        act.learnASentence(speakLabel.text!, tORf: false)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

