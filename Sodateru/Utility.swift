//
//  Utility.swift
//  FirstSwift
//
//  Created by Snufkin on 2015/11/17.
//  Copyright © 2015年 Snufkin. All rights reserved.
//

import Foundation

public class Utility {
    
    //TODO: パスを動的に取得する
    //var filePath = "/Users/snufkin/Desktop/HelloSwift/Sodateru/"
    var filePath = "/Users/takuya/Practice/Sodateru/Sodateru/"
    
    let SEPARATOR:String = ","
    
    /**
     * ファイルへの文字列append
     **/
    func appedStringToFile(str:String, fileName:String) {
        
        var contents:NSString = ""
        
        // 書き込み先ファイルのフルパス
        let fFullName = "\(filePath)\(fileName)"
        
        /*** 既存データを文字列として取得する ***/
        let existedContents: String = readFileAsString(fileName)
        
        print("existed:\(existedContents)")
        print("str:\(str)")
        // 既存データ+入力された単語データ を生成する
        if existedContents.isEmpty {
            contents = str as NSString
        } else {
            contents = "\(existedContents)" as NSString
            if (!chekckDataExisted(str)) {
                contents = "\(contents)\(str)" as NSString
            }
            print("contents:\(contents)")
        }
        
        /*** いざ、書き込む ***/
        do {
            try contents.writeToFile(fFullName, atomically: true, encoding: NSUTF8StringEncoding)
        } catch {
        }
        
    }
    
    /**
     * データの存在チェック
     **/
    func chekckDataExisted(str: String) -> Bool {
        let mgr = Manager()
        let existedList: [[String]] = mgr.getAllWordList()
        var resultFlag: Bool = false
        
        for existed in existedList {
            if str == existed[0]+","+existed[1] {
                resultFlag = true
            }
        }
        
        return resultFlag
    }
    
    
    /**
     * ファイルへの書き込み（as new）
     **/
     func writeAStringToFile(contents: String, fileName:String) {
        
        // 書き込み先ファイルのフルパス
        let fFullName = "\(filePath)sentences.txt"
        
        /*** 未登録であれば書き込む、でなければ書き込まない ***/
        print(contents)
        do {
            try contents.writeToFile(fFullName, atomically: true, encoding: NSUTF8StringEncoding)
            } catch {
        }
    }
    
    /**
     * ファイル内容読み込み（二次元配列を返す: 行内容をカンマ区切りで配列化したものの配列）
     **/
    func readFileAsArray(fileName: NSString) -> [[String]] {
        
        // 読み込み元ファイルのフルパス
        let fFullName = "\(filePath)\(fileName)"
        
        var result: [[String]] = [[String]]()
        
        do {
            var data:NSString
            try data = NSString(contentsOfFile: fFullName, encoding: NSUTF8StringEncoding) as String
            
            String(data).enumerateLines { (line, stop) -> () in
                let item: [String] = line.componentsSeparatedByString(self.SEPARATOR)
                result.append(item)
            }
        } catch {
            print("失敗")
        }
        
        return result
    }
    
    /**
     * ファイル内容読み込み（文字列を返す）
     **/
    func readFileAsString(fileName: String) -> String {
        
        // 読み込み元ファイルのフルパス
        let fFullName = "\(filePath)\(fileName)"
        
        var result = ""
        
        do {
            let data:NSString
            try data = NSString(contentsOfFile: fFullName, encoding: NSUTF8StringEncoding) as String
            
            String(data).enumerateLines { (line, stop) -> () in
                result += line + "\n"
            }
        } catch {
        }
        
        return result
    }
    
    /**
     * 単語選択
     **/
    func chooseAWordFromAList(list:[String]) -> String {
        
        /*** 与えられた配列のインデックスをランダムに決めて、その要素を返す ***/
        let listSize: Int = list.count
        let idx = Int(arc4random() % UInt32(listSize))
        
        return list[idx]
        
    }
    
}
