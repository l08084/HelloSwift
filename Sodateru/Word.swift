//
//  Word.swift
//  Sodateru
//
//  Created by 中安拓也 on 2016/01/16.
//  Copyright © 2016年 mycompany. All rights reserved.
//

import Foundation
import RealmSwift

/// Wordテーブルのモデルクラス
class Word: Object {
    
    dynamic var word = ""
    dynamic var part = ""
    dynamic var owner: Character?
    
    override static func primaryKey() -> String? {
        return "word"
    }
}
