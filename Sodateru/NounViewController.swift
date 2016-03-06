//
//  NounViewController.swift
//  Sodateru
//
//  Created by 中安拓也 on 2015/11/23.
//  Copyright © 2015年 mycompany. All rights reserved.
//

import UIKit

/// 名詞セレクトボックスを表示するViewController
class NounViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Tableで使用する配列を設定する
    private var myItems: [String] = []
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
        
        // DBから名詞をランダムに5個取り出す
        let service = Service()
        myItems = service.findMasterWord("noun")
        
        // Viewに追加する.
        self.view.addSubview(myTableView)
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let text: String = myItems[indexPath.row]

        let appDelegate :AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.noun = text
        performSegueWithIdentifier("nounToViewController", sender: nil)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // 再利用するCellを取得する.
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath)
        
        // Cellに値を設定する.
        cell.textLabel!.text = "\(myItems[indexPath.row])"
        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myItems.count
    }

}
