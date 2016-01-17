//
//  MasterWord.swift
//  Sodateru
//
//  Created by 中安拓也 on 2016/01/16.
//  Copyright © 2016年 mycompany. All rights reserved.
//

import Foundation
import RealmSwift

class MasterWord: Object {
    
    dynamic var word = ""
    dynamic var part = ""
    
    override static func primaryKey() -> String? {
        return "word"
    }
    
}
