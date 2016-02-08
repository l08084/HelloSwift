//
//  Repository.swift
//  Sodateru
//
//  Created by 中安拓也 on 2016/01/21.
//  Copyright © 2016年 mycompany. All rights reserved.
//

import Foundation
import RealmSwift

/// DBアクセスクラス
public class Repository {
    
    let realm :Realm
    
    // 初期化処理
    init() {
        
        // デフォルトRealmを取得する
        realm = try! Realm()
        
        // Realmファイルが現在配置されている場所を表示
        print("realm:\(realm.path)")
    }
    
    
    /// DB初期設定(MasterWordテーブル)
    func masterWordSttng() {
        
        // DBに初期設定する単語
        var words: [String] = ["りんご", "たべる", "ボール", "なげる", "まるい", "おいしい", "かばん",
            "でんしゃ", "くるま", "うみ", "おかし", "いす", "つくえ", "はな", "たまご",
            "ふく", "もつ", "はしる", "のる", "およぐ", "わたす", "すわる", "つかう",
            "おく", "きる", "わる", "きれい", "ひろい", "はやい", "おおきい", "ちいさい",
            "かわいい", "かるい", "おもい", "たかい", "ひくい"]
        
        // DBに初期設定する品詞
        var parts: [String] = ["noun", "verb", "noun", "verb", "pronoun", "pronoun", "noun",
            "noun", "noun", "noun", "noun", "noun", "noun", "noun", "noun",
            "noun", "verb", "verb", "verb", "verb", "verb", "verb", "verb",
            "verb", "verb", "verb", "pronoun", "pronoun", "pronoun", "pronoun",
            "pronoun", "pronoun", "pronoun", "pronoun", "pronoun", "pronoun"]
        
        // MasterWordテーブルのmodelオブジェクトを宣言
        var masterWords: [MasterWord]  = []
        
        // トランザクションを開始して、オブジェクトをRealmに追加する
        try! realm.write {
            
            for num in 0..<words.count {
                
                masterWords.append(MasterWord())
                
                masterWords[num].word = words[num]
                masterWords[num].part = parts[num]
                
                // DBにデータがなければ、登録(あれば更新)
                self.realm.add(masterWords[num], update: true)
            }
        }
    }
    

    /// DB初期設定(Characterテーブル)
    func characterSttng() {
        
        let character = Character()
        character.id = "1"
        
        // トランザクションを開始して、オブジェクトをRealmに追加する
        try! realm.write {
            // DBにデータがなければ、登録(あれば更新)
            self.realm.add(character, update: true)
        }
    }
    
    
    /// DB(Realm)内容読み込み、対象テーブルはWord（指定したpartのWord文字列配列を返す）
    func findCharacter(id: String) -> Character {
        
        // 引数で指定したidのキャラクターをDBから取得
        let results = realm.objects(Character).filter("id = %@", id)
        
        // 条件に該当するキャラは一つなので、一つだけ戻す
        return results[0]
    }
    
    
    /// リストボックスで選択した単語をDBに保存
    func saveWord(word: String, part: String) {
        
        // Wordテーブルのmodelオブジェクトを宣言
        let wo = Word()
        
        // 単語と品詞を設定
        wo.word = word
        wo.part = part
        
        try! realm.write {
            
            // DBにデータがなければ、登録(あれば更新)
            self.realm.add(wo, update: true)
        }
    }
    
    
    /// リストボックスで選択した単語をDBに保存
    func saveSentence(sentence: String, flg: String) {
        
        // Wordテーブルのmodelオブジェクトを宣言
        let sntnc = Sentence()
        
        // 文と判定フラグを設定
        sntnc.sentence = sentence
        sntnc.flg = flg
        
        try! realm.write {
            
            // DBにデータがなければ、登録(あれば更新)
            self.realm.add(sntnc, update: true)
        }
    }
    
    
    /// DB(Realm)内容読み込み、対象テーブルはMasterWord（指定したpartのWord文字列配列を返す）
    func findMasterWord(part: String) -> [String] {
        
        var resultList: [String] = []
        
        // 引数で指定した品詞の単語全てをDBから取得
        let masterWords = realm.objects(MasterWord).filter("part = %@", part)
        
        // Word部分のみを取得
        for masterWord in masterWords {
            resultList.append(masterWord.word)
        }
        
        return resultList
    }
    
    
    /// DB(Realm)内容読み込み、対象テーブルはWord（指定したpartのWord文字列配列を返す）
    func findWord(part: String) -> [String] {
        
        var resultList: [String] = []
        
        // 引数で指定した品詞の単語全てをDBから取得
        let words = realm.objects(Word).filter("part = %@", part)
        
        // Word部分のみを取得
        for w in words {
            resultList.append(w.word)
        }
        
        return resultList
    }
    
    
    /// 文章判定フラグをキーに、文章リストを取得
    /// - parameter flg: 文章判定フラグ
    func findSentenceByFlg(flg: String) -> [String] {
        
        var resultList: [String] = []
        
        // 引数で指定した品詞の単語全てをDBから取得
        let sentences = realm.objects(Sentence).filter("flg = %@", flg)
        
        // Word部分のみを取得
        for s in sentences {
            resultList.append(s.sentence)
        }
        
        return resultList
    }
}