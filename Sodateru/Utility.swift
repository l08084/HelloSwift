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
    var filePath = "/Users/snufkin/Desktop/FirstSwift/FirstSwift/"
    
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
        
        // 既存データ+入力された単語データ を生成する
        if existedContents.isEmpty {
            contents = str as NSString
        } else {
            contents = "\(existedContents)\(str)" as NSString
        }
        
        /*** いざ、書き込む ***/
        do {
            try contents.writeToFile(fFullName, atomically: true, encoding: NSUTF8StringEncoding)
        } catch {
        }
        
    }
    
    //ファイルへの書き込み（as new）
    func writeAStringToFile)(str: String, fileName:String) {
        /*** いざ、書き込む ***/
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
