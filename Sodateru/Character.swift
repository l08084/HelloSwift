//
//  Character.swift
//  Sodateru
//
//  Created by 中安拓也 on 2016/01/30.
//  Copyright © 2016年 mycompany. All rights reserved.
//

import Foundation
import RealmSwift

/// Characterテーブルのモデルクラス
class Character: Object {
    
    dynamic var id = ""
    dynamic var birthdate = NSDate()
    let words = List<Word>()
    let sentences = List<Sentence>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
