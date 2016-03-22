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
    
    // セレクトボックス(動詞)
    @IBOutlet weak var selectBox: UIButton!
    // セレクトボックス(名詞)
    @IBOutlet weak var selectNounBox: UIButton!
    // セレクトボックス(形容詞)
    @IBOutlet weak var selectPronounBox: UIButton!
    
    // 生成した文章を表示するラベル
    @IBOutlet weak var speakLabel: UILabel!
    // 経過時間を表示するラベル
    @IBOutlet weak var timeLabel: UILabel!
    
    //セレクトボックス画面から値を受け取る
    var paramV :String = ""
    var paramN :String = ""
    var paramP :String = ""
    
    var service = Service()
    
    let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    
    /// 話すボタンを押下すると文を作成、表示
    /// - parameter sender:
    @IBAction func talking(sender: UIButton) {
        
        // 文章を生成する
        let speak = service.generateASentenceDB("NV")
        speakLabel.text = speak
        
        // Sentenceテーブルに生成した文を保存
        let repo = Repository()
        repo.saveSentence(speak, flg: "-")
    }
    
    // TODO:talking()と同じ機能のfunctionなので、一つにまとめる必要がある
    /// 一定時間が経過すると、セリフを更新する
    func update() {
        
        // 文章を生成する
        let speak = service.generateASentenceDB("NV")
        speakLabel.text = speak
        
        // Sentenceテーブルに生成した文を保存
        let repo = Repository()
        repo.saveSentence(speak, flg: "-")
    }
    
    
    /// 登録ボタンを押下すると単語を登録
    /// - parameter sender:
    @IBAction func wordRegister(sender: AnyObject) {
        
        // 動詞に単語が設定されていた場合
        if selectBox.titleLabel!.text != "動詞" {
            
            // Wordテーブルに動詞を記録
            let repo = Repository()
            repo.saveWord(selectBox.titleLabel!.text!, part: "verb")
            
            //ボタンのラベルをデフォルトに戻す
            selectBox.setTitle("動詞", forState: .Normal)
            appDelegate.verb = ""
        }
        
        // 名詞に単語が設定されていた場合
        if selectNounBox.titleLabel!.text != "名詞" {
            
            // Wordテーブルに名詞を記録
            let repo = Repository()
            repo.saveWord(selectNounBox.titleLabel!.text!, part: "noun")
            
            //ボタンのラベルをデフォルトに戻す
            selectNounBox.setTitle("名詞", forState: .Normal)
            appDelegate.noun = ""
        }
        
        // 形容詞に単語が設定されていた場合
        if selectPronounBox.titleLabel!.text != "形容詞" {
            
            // Wordテーブルに形容詞を記録
            let repo = Repository()
            repo.saveWord(selectPronounBox.titleLabel!.text!, part: "adjective")
            
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
        
        // Realm(DB)の初期設定をスタート
        let repo = Repository()
        // MasterWordの初期設定
        repo.masterWordSttng()
        
        let characterId = "1"
        
        // Characterの初期設定
        service.characterSttng(characterId)
        
        // id=1のキャラクターが誕生してからの経過時間を取得
        let components = service.timeSetting("1")
        
        // ラベルに経過時間を表示
        timeLabel.text = "\(service.hatch(-components.day))"
        
        // 5秒ごとにキャラクターのセリフを切り替える
        NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
    }
    
    // TODO: 使用していないfuncなので、削除が必要
    // 動詞ボタンがタップされたらプルダウン用の別画面を開く
    @IBAction func clickButtonSelect(sender: UIButton) {
        
    }
    
    // TODO: 使用していないfuncなので、削除が必要
    // 名詞ボタンがタップされたらプルダウン用の別画面を開く
    @IBAction func nounClickButton(sender: UIButton) {
        
    }
    
    // TODO: 使用していないfuncなので、削除が必要
    // 代名詞ボタンがタップされたらプルダウン用の別画面を開く
    @IBAction func adjectiveClickButton(sender: UIButton) {
        
    }
    
    
    // プルダウン選択後に戻ってきたら、選択値を取得してセレクトボックスを再描画します
   override func viewWillAppear(animated: Bool) {
    
        //プルダウン用の画面から値を受け取る
        paramV = appDelegate.verb
        paramN = appDelegate.noun
        // TODO: .adjectiveに変更する
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
    
    
    /// まるボタンを押下すると文を判定
    /// - parameter sender:
    @IBAction func sentenceOK(sender: AnyObject) {
        
        // 文章を丸(flg:1)に設定
        var repo = Repository()
        repo.saveSentence(speakLabel.text!, flg: "1")
        
        // 文章を判定したら、違う文に切り替える
        let speak = service.generateASentenceDB("NV")
        speakLabel.text = speak
        
        // Sentenceに生成した文を保存
        repo = Repository()
        repo.saveSentence(speak, flg: "-")
    }
    
    
    /// ばつボタンを押下すると文を判定
    /// - parameter sender:
    @IBAction func sentenceNG(sender: AnyObject) {

        // 文章をばつ(flg:2)に設定
        var repo = Repository()
        repo.saveSentence(speakLabel.text!, flg: "2")
        
        // 文章を判定したら、違う文に切り替える
        let speak = service.generateASentenceDB("NV")
        speakLabel.text = speak
        
        // Sentenceに生成した文を保存
        repo = Repository()
        repo.saveSentence(speak, flg: "-")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

