//
//  Service.swift
//  Sodateru
//
//  Created by 中安拓也 on 2016/02/07.
//  Copyright © 2016年 mycompany. All rights reserved.
//

import Foundation

public class Service {
    
    let formSV: String = "NV"
    let formSP: String = "NP"
    let support = Support()

    
    /// 文章生成(DB版)
    /// - parameter form: 文型(SV等のこと)
    func generateASentenceDB(form: String) -> String {
    
        var sentence: String = ""
        let repo = Repository()
        
        // DBから各種単語(動詞、名詞、形容詞)を全て取得
        let sList = repo.findWord("noun")
        let vList = repo.findWord("verb")
        let pList = repo.findWord("pronoun")
    
        /*** 選ばれた単語で文章を生成する ***/
        switch form {
            // 名詞+動詞
        case formSV:
            // 取得した単語リストから、ランダムに単語を選択
            let s = support.chooseAWordFromAList(sList)
            let v = support.chooseAWordFromAList(vList)
            sentence = "\(s) を \(v)"
            // 名詞+形容詞
        case formSP:
            // 取得した単語リストから、ランダムに単語を選択
            let s = support.chooseAWordFromAList(sList)
            let p = support.chooseAWordFromAList(pList)
            sentence = "\(s) は \(p)"
        default:
            sentence = ""
        }
    
        // 間違い文章リストを取得
        let falseSntncList:[String] = repo.findSentenceByFlg("2")
        var judge = false
        // 間違い文章かどうか判定
        for falseSntnc in falseSntncList {
            if (sentence == falseSntnc) {
                judge = true
            }
        }
        // 間違い文章だった場合は、再度文を生成
        if (judge) {
            sentence = generateASentenceDB(form)
        }
        return sentence
    }
}
