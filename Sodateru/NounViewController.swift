//
//  NounViewController.swift
//  Sodateru
//
//  Created by 中安拓也 on 2015/11/23.
//  Copyright © 2015年 mycompany. All rights reserved.
//

import UIKit

class NounViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Tableで使用する配列を設定する
    private var myItems: [String] = ["りんご", "空", "世間話", "映画", "カフェ", "コーヒー"]
    private var myTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height
        
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        
        // Cell名の登録をおこなう.
        myTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        
        // DataSourceの設定をする.
        myTableView.dataSource = self
        
        // Delegateを設定する.
        myTableView.delegate = self
        
        let act = Action()
        myItems = act.refWordList("noun")
        print("myItems:\(myItems)")
        
        // Viewに追加する.
        self.view.addSubview(myTableView)
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let text: String = myItems[indexPath.row] as! String
        print("text:\(text)")
    }
    
    /*
    Cellに値を設定するデータソースメソッド.
    (実装必須)
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // 再利用するCellを取得する.
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath)
        
        // Cellに値を設定する.
        cell.textLabel!.text = "\(myItems[indexPath.row])"
        print("return,var")
        return cell
    }
    /*
    Cellの総数を返すデータソースメソッド.
    (実装必須)
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count:\(myItems.count)")
        return myItems.count
    }

}
