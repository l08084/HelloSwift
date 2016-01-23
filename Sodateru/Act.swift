//
//  Action.swift
//  FirstSwift
//
//  Created by Snufkin on 2015/11/17.
//  Copyright © 2015年 Snufkin. All rights reserved.
//

import Foundation

public class Action {
    
    let wordFName: String = "words.txt"
    let sntncFName: String = "sentences.txt"
    let strNoun: String = "noun"
    let strVerb: String = "verb"
    let strPronoun: String = "pronoun"
    let formSV: String = "NV"
    let formSP: String = "NP"
    let util = Utility()
    let mgr = Manager()
    
    
    /**
     * 単語登録
     **/
    func registerAWord(word:String, part:String) {
        
        util.appedStringToFile("\(part),\(word)", fileName: wordFName)
        
    }
    
    
    /**
     * 覚えられる単語リスト参照
     **/
    func refWordList(part: String) -> [String] {
        
        return mgr.getWordList(part)
    }
    
    
    /**
     * 覚えた文章リスト参照
     **/
    func refSentenceList() -> [String] {
        
        return mgr.getSentenceList()
    }
    
    
    /**
     * 文章生成
     **/
    func generateASentence(form: String) -> String {
        
        var sentence: String = ""
        let sntncDataList = util.readFileAsArray(sntncFName)
        
        /*** 選ばれた単語で文章を生成する ***/
        switch form {
            // 名詞+動詞
        case formSV:
             let s = util.chooseAWordFromAList(mgr.getWordList(strNoun))
            let v = util.chooseAWordFromAList(mgr.getWordList(strVerb))
            sentence = "\(s) を \(v)"
            // 名詞+形容詞
        case formSP:
            let s = util.chooseAWordFromAList(mgr.getWordList(strNoun))
            let p = util.chooseAWordFromAList(mgr.getWordList(strPronoun))
            sentence = "\(s) は \(p)"
        default:
            sentence = ""
        }
        
        //間違い文章データリスト
        let falseSntncList:[String] = mgr.getSentenceListByFlag("2")
        let judge = false
        for falseSntnc in falseSntncList {
            if (sentence == falseSntnc) {
                judge == true
            }
        }
        if (judge) {
            sentence = generateASentence(form)
        } else {
        }
        
        
        return sentence
    }
    
    /**
     * 文章生成(DB版)
     **/
    func generateASentenceDB(form: String) -> String {
        
        var sentence: String = ""
        let repo = Repository()
        let sList = repo.findWord("noun")
        let vList = repo.findWord("verb")
        let pList = repo.findWord("pronoun")
        
        /*** 選ばれた単語で文章を生成する ***/
        switch form {
            // 名詞+動詞
        case formSV:
            let s = util.chooseAWordFromAList(sList)
            let v = util.chooseAWordFromAList(vList)
            sentence = "\(s) を \(v)"
            // 名詞+形容詞
        case formSP:
            let s = util.chooseAWordFromAList(sList)
            let p = util.chooseAWordFromAList(pList)
            sentence = "\(s) は \(p)"
        default:
            sentence = ""
        }
        
        //間違い文章データリスト
        let falseSntncList:[String] = mgr.getSentenceListByFlag("2")
        var judge = false
        for falseSntnc in falseSntncList {
            if (sentence == falseSntnc) {
                judge = true
            }
        }
        if (judge) {
            sentence = generateASentenceDB(form)
        } else {
        }
        
        
        return sentence
    }
    
    
    /**
     * 文章登録
     **/
    func registerASentence(sntnc: String) {
        
        util.appedStringToFile(sntnc, fileName: sntncFName)
    }

    /**
     * 文章学習
     **/
    func learnASentence(sntnc:String, tORf:Bool) {
    
        
        // 文章データリスト
        let sntncDataList = util.readFileAsArray(sntncFName)
        var contents:String = ""
        var memoFlag:String = "-"
        
        //1:正しい文章なので覚える, 2:正しくない文章なので覚えない
        if (tORf) {
            memoFlag = "1"
        } else {
            memoFlag = "2"
        }
        
        for var sntncData in sntncDataList {
            if (sntncData[0] == sntnc) {
                sntncData[1] = memoFlag
            }
            contents += sntncData[0] + "," + sntncData[1] + "\n"
        }
        util.writeAStringToFile(contents, fileName: sntncFName)
        //util.appedStringToFile(contents, fileName: sntncFName)
    }
    
    /**
     * テスト用関数
     **/
    func execTest() {
        
        //getWordList用
        //var wList = refWordList("noun")
        //print(wList)
        //wList = refWordList("verb")
        //print(wList)
        
        //registerAWord用
        /*
        registerAWord("りんご", part: "noun")
        registerAWord("たべる", part: "verb")
        registerAWord("ボール", part: "noun")
        registerAWord("なげる", part: "verb")
        registerAWord("まるい", part: "pronoun")
        registerAWord("おいしい", part: "pronoun")
        registerAWord("かばん", part: "noun")
        registerAWord("でんしゃ", part: "noun")
        registerAWord("くるま", part: "noun")
        registerAWord("うみ", part: "noun")
        registerAWord("おかし", part: "noun")
        registerAWord("いす", part: "noun")
        registerAWord("つくえ", part: "noun")
        registerAWord("はな", part: "noun")
        registerAWord("たまご", part: "noun")
        registerAWord("ふく", part: "noun")
        registerAWord("もつ", part: "verb")
        registerAWord("はしる", part: "verb")
        registerAWord("のる", part: "verb")
        registerAWord("およぐ", part: "verb")
        registerAWord("わたす", part: "verb")
        registerAWord("すわる", part: "verb")
        registerAWord("つかう", part: "verb")
        registerAWord("おく", part: "verb")
        registerAWord("きる", part: "verb")
        registerAWord("わる", part: "verb")
        registerAWord("きれい", part: "pronoun")
        registerAWord("ひろい", part: "pronoun")
        registerAWord("はやい", part: "pronoun")
        registerAWord("おおきい", part: "pronoun")
        registerAWord("ちいさい", part: "pronoun")
        registerAWord("かわいい", part: "pronoun")
        registerAWord("かるい", part: "pronoun")
        registerAWord("おもい", part: "pronoun")
        registerAWord("たかい", part: "pronoun")
        registerAWord("ひくい", part: "pronoun")
        */
        
        //refASentence用
        var sentence = generateASentence(formSV);
        print(sentence)
        if (true) {
            registerASentence(sentence)
        }
        sentence = generateASentence(formSP);
        print(sentence)
        if (true) {
            registerASentence(sentence)
        }
        
        //refSentenceList
        let sntncList = refSentenceList()
        print(sntncList)
        
    }
    
}
