//
//  Support.swift
//  Sodateru
//
//  Created by 中安拓也 on 2016/02/07.
//  Copyright © 2016年 mycompany. All rights reserved.
//

import Foundation

public class Support {
    
    /// 単語選択
    /// - parameter list: 文型(SV等のこと)
    func chooseAWordFromAList(list:[String]) -> String {
        
        /*** 与えられた配列のインデックスをランダムに決めて、その要素を返す ***/
        let listSize: Int = list.count
        let idx = Int(arc4random() % UInt32(listSize))
        
        return list[idx]
    }
}