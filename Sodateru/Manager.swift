//
//  Manager.swift
//  FirstSwift
//
//  Created by Snufkin on 2015/11/19.
//  Copyright © 2015年 Snufkin. All rights reserved.
//

import Foundation

public class Manager {
    
    let util = Utility()
    let mWordFName = "masterWords.txt"
    let wordFName = "words.txt"
    let sntncFName = "sentences.txt"
    
    /**
     * 単語リストgetter（品詞指定アリ）
     **/
    func getWordList(part: String) -> [String] {
        
        var wordDataList: [[String]] = [[]]
        var resultList: [String] = []
        
        /*** 単語リストを取得する ***/
        wordDataList = util.readFileAsArray(mWordFName)
        
        /*** 品詞別単語リストを生成する ***/
        for wordData in wordDataList {
            if (wordData[0] == part) {
                resultList.append(wordData[1])
            }
        }
        
        return resultList
    }
    
    /**
     * 覚えた単語リストgetter（品詞指定なし）
     **/
    func getAllWordList() -> [[String]] {
        
        var wordDataList: [[String]] = [[]]
        
        /*** 覚えた単語リストを取得する ***/
        wordDataList = util.readFileAsArray(wordFName)
        
        return wordDataList
    }
    
    /**
     * 文章リストgetter
     **/
    func getSentenceList() -> [String] {
        
        var resultList: [String] = []
        
        /*** 覚えた文章リストを生成する ***/
         // 文章データリスト
        let sntncList = util.readFileAsArray(sntncFName)
        
        for sntncData in sntncList {
            resultList.append(sntncData[0])
        }
        
        return resultList
    }
    
    /**
     * 文章リスト（覚えたフラグ指定あり）
     **/
    func getSentenceListByFlag(flg:String) -> [String] {
        
        var resultList: [String] = []
        let sntncDataList = util.readFileAsArray(sntncFName)
        
        for sntncData in sntncDataList {
            if (sntncData[1] == flg) {
                resultList.append(sntncData[0])
            }
        }
        
        return resultList
    }
}
