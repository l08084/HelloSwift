//
//  GameScene.swift
//  Sodateru
//
//  Created by 中安拓也 on 2015/11/13.
//  Copyright © 2015年 mycompany. All rights reserved.
//

import Foundation
import SpriteKit

class GameScene : SKScene {
    
    var baseNode: SKNode!
    var player: SKSpriteNode!
    
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
        
        self.addChild(player)
    }

}