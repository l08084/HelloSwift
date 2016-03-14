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
    
    
    /// MasterWordテーブルの初期設定
    func masterWordSttng() {
        
        // DBに初期設定する単語
        var words: [String] = ["りんご", "たべる", "ボール", "なげる", "まるい", "おいしい", "かばん",
            "でんしゃ", "くるま", "うみ", "おかし", "いす", "つくえ", "はな", "たまご",
            "ふく", "もつ", "はしる", "のる", "およぐ", "わたす", "すわる", "つかう",
            "おく", "きる", "わる", "きれい", "ひろい", "はやい", "おおきい", "ちいさい",
            "かわいい", "かるい", "おもい", "たかい", "ひくい", "まつ", "よむ", "はたらく",
            "きく", "じてんしゃ", "みかん", "ようなし", "いぬ", "やさしい", "むずかしい",
            "いそがしい", "うるさい", "おいしい"]
        
        // DBに初期設定する品詞
        var parts: [String] = ["noun", "verb", "noun", "verb", "pronoun", "pronoun", "noun",
            "noun", "noun", "noun", "noun", "noun", "noun", "noun", "noun",
            "noun", "verb", "verb", "verb", "verb", "verb", "verb", "verb",
            "verb", "verb", "verb", "pronoun", "pronoun", "pronoun", "pronoun",
            "pronoun", "pronoun", "pronoun", "pronoun", "pronoun", "pronoun",
            "verb", "verb", "verb", "verb", "noun", "noun", "noun", "noun",
            "pronoun", "pronoun", "pronoun", "pronoun", "pronoun"]
        
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
    /// - parameter flg: 文章判定フラグ
    func characterSttng(id: String) {
        
        let character = Character()
        character.id = id
        
        // トランザクションを開始して、オブジェクトをRealmに追加する
        try! realm.write {
            // 登録(すでに同一IDのデータが登録されていた場合でも、birthDateは更新しない)
            self.realm.create(Character.self, value:["id": id], update: true)
        }
    }
    
    
    /// DB(Realm)内容読み込み、対象テーブルはWord（指定したpartのWord文字列配列を返す）
    /// - parameter id: キャラクターid
    func findCharacter(id: String) -> Character {
        
        // 引数で指定したidのキャラクターをDBから取得
        let results = realm.objects(Character).filter("id = %@", id)
        
        // 条件に該当するキャラは一つなので、一つだけ戻す
        return results[0]
    }
    
    
    /// リストボックスで選択した単語をDBに保存
    /// - parameter word: 単語
    /// - parameter part: 単語の品詞
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
    /// - parameter sentence: 文章
    /// - parameter flg: 文章判定フラグ
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
    /// - parameter part: 単語の品詞
    /// - returns: 引数の品詞にマッチした単語全て
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
    /// - parameter part: 単語の品詞
    /// - returns: 引数の品詞にマッチした単語全て
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
    
    /// IDをキーにキャラクターのBirthDateを取得
    /// - parameter id: キャラクターID
    func findBirthDateById(id: String) -> NSDate {
        
        // IDをキーに、キャラクターを取得
        let result = realm.objects(Character).filter("id = %@", id)
        
        // 条件に該当するキャラは一つなので、一つだけ戻す
        return result[0].birthdate
    }
}