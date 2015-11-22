//
//  GameScene.swift
//  Sodateru
//
//  Created by 中安拓也 on 2015/11/13.
//  Copyright © 2015年 mycompany. All rights reserved.
//

import Foundation
import SpriteKit

class GameScene : SKScene,SKPhysicsContactDelegate {
    
    var baseNode: SKNode!
    var player: SKSpriteNode!
    var myLabel: SKLabelNode!
    
    var deltaPoint = CGPointZero
    
    struct Constants {
        
        // Player画像
        static let PlayerImages = ["shrimp01", "shrimp02", "shrimp03", "shrimp04"]
    }
    
    override func didMoveToView(view: SKView) {
        
        // 全ノードの親となるノードを生成
        baseNode = SKNode()
        baseNode.speed = 1.0
        self.addChild(baseNode)
        
        //背景画像を構築
        self.setupBackgroundSea()
        
        // プレイキャラを構築
        self.setupPlayer()
        
        // 重力設定
        //self.physicsWorld.gravity = CGVector(dx: 0, dy: -4.0)
        // 物体の衝突した情報を受け取れるようにする
        self.physicsWorld.contactDelegate = self
        
        //GameSceneの大きさでphysicsBodyを設定
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        
        let label = SKLabelNode()
        label.text = "eat"
        label.position = CGPoint(x: 80, y: 30)
        
        label.physicsBody = SKPhysicsBody(circleOfRadius: 20)

        let label2 = SKLabelNode()
        label2.text = "play"
        label2.position = CGPoint(x: 80, y: 20)
        
        label2.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        
        let label3 = SKLabelNode()
        label3.text = "swim"
        label3.position = CGPoint(x: 110, y: 30)
        
        label3.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        
        let label4 = SKLabelNode()
        label4.text = "run"
        label4.position = CGPoint(x: 60, y: 20)
        
        label4.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        
       
        myLabel = SKLabelNode()
        myLabel.text = "Drag!!"
        myLabel.position = CGPoint(x: 60, y: 20)
        myLabel.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        
        self.addChild(label)
        self.addChild(label2)
        self.addChild(label3)
        self.addChild(label4)
        self.addChild(myLabel)
        
        
    }
    
    func setupBackgroundSea() {
        
        // 背景画像(流れる海)を読み込む
        let texture = SKTexture(imageNamed: "background")
        texture.filteringMode = .Nearest
        
        // 必要な画像枚数を算出
        let needNumber = 2.0 + (self.frame.size.width / texture.size().width)
        
        // アニメーションを生成
        let moveAnim = SKAction.moveByX(-texture.size().width, y: 0.0, duration: NSTimeInterval(texture.size().width / 10.0))
        let resetAnim = SKAction.moveByX(texture.size().width, y: 0.0, duration: 0.0)
        let repeatForeverAnim = SKAction.repeatActionForever(SKAction.sequence([moveAnim, resetAnim]))
        
        // 画像の配置とアニメーションを設定
        for var i: CGFloat = 0; i < needNumber; ++i {
            let sprite = SKSpriteNode(texture: texture)
            sprite.zPosition = -100.0
            sprite.position = CGPoint(x: i * sprite.size.width, y: self.frame.size.height / 2.0)
            sprite.runAction(repeatForeverAnim)
            baseNode.addChild(sprite)
        }
                
    }
    
    func setupPlayer() {
        
        // Playerのパラパラアニメーション作成に必要なSKTextureクラスの配列を定義
        var playerTexture = [SKTexture]()
        
        // パラパラアニメーションに必要な画像を読み込む
        for imageName in Constants.PlayerImages {
            let texture = SKTexture(imageNamed: imageName)
            texture.filteringMode = .Linear
            playerTexture.append(texture)
        }
        
        // パラパラマンガのアニメーションを作成
        let playerAnimation = SKAction.animateWithTextures(playerTexture, timePerFrame: 0.2)
        let loopAnimation = SKAction.repeatActionForever(playerAnimation)
        
        // キャラクターを生成し、アニメーションを設定
        player = SKSpriteNode(texture: playerTexture[0])
        player.position = CGPoint(x: self.frame.size.width * 0.35, y: self.frame.size.height * 0.6)
        player.runAction(loopAnimation)
        //player.physicsBody = SKPhysicsBody(circleOfRadius: 40)
        
        self.addChild(player)
    }
    /*
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //Labelアニメーション
        UIView.animateWithDuration(0.06, animations: { () -> Void in
            // 縮小用アフィン行列を作成する.
            self.myLabel.transform = CGAffineTransformMakeScale(0.9, 0.9)
            
        })
            { (Bool) -> Void in
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // タッチイベントを取得.
        let aTouch = touches.first
        
        // 移動した先の座標を取得.
        let location = aTouch!.locationInView(self.view)
        
        // 移動する前の座標を取得.
        let prevLocation = aTouch!.previousLocationInView(self.view)
        
        // CGRect生成.
        var myFrame: CGRect = self.view!.frame
        
        // ドラッグで移動したx, y距離をとる.
        let deltaX: CGFloat = location.x - prevLocation.x
        let deltaY: CGFloat = location.y - prevLocation.y
        
        // 移動した分の距離をmyFrameの座標にプラスする.
        myFrame.origin.x += deltaX
        myFrame.origin.y += deltaY
        
        // frameにmyFrameを追加.
        self.view!.frame = myFrame
    }
    */
   
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        var currentPoint:CGPoint! = touches.first!.locationInNode(self)
        var previousPoint:CGPoint! = touches.first!.previousLocationInNode(self)
        deltaPoint = CGPointMake(currentPoint.x - previousPoint.x, currentPoint.y - previousPoint.y)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        deltaPoint = CGPointZero
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        deltaPoint = CGPointZero
    }
    
    override func update(currentTime: NSTimeInterval) {
        var newPoint = CGPointMake(self.myLabel.position.x + self.deltaPoint.x, self.myLabel.position.y + self.deltaPoint.y)
        myLabel.position = newPoint
        deltaPoint = CGPointZero
    }

}