//
//  Sentence.swift
//  Sodateru
//
//  Created by 中安拓也 on 2016/01/16.
//  Copyright © 2016年 mycompany. All rights reserved.
//

import Foundation
import RealmSwift

class Sentence: Object {
    
    dynamic var sentence = ""
    dynamic var flg = ""
    
    override static func primaryKey() -> String? {
        return "sentence"
    }
    
}
