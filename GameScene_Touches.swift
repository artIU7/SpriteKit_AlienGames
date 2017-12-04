 //
//  GameScene_Touches.swift
//  runGames
//
//  Created by Артем Стратиенко on 30.10.17.
//  Copyright © 2017 Артем Стратиенко. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        heroNode.physicsBody?.velocity = CGVector.zero
        heroNode.physicsBody?.applyImpulse(CGVector(dx: 0.0000003, dy: 90))
        
        //
        //heroJumpTexture = SKTexture(imageNamed: "jump_1.png")
        //heroNode = SKSpriteNode(texture: heroTexture)
        heroJumpArray = [SKTexture(imageNamed: "jump_1.png"),SKTexture(imageNamed: "jump_2.png"),SKTexture(imageNamed: "jump_3.png"),SKTexture(imageNamed: "jump_4.png")]
        let heroJumpAnimation = SKAction.animate(with: heroJumpArray, timePerFrame: 0.1)
        let JumpHero = SKAction.repeatForever(heroJumpAnimation)
        heroNode.size.height = 70
        heroNode.run(JumpHero)
        //
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        
    //(_ touches: Set<UITouch>, with event: UIEvent?) {
       // heroNode.physicsBody?.velocity = CGVector.zero
       // heroNode.physicsBody?.applyImpulse(CGVector(dx: -3, dy: 90))
        heroFireArray = [SKTexture(imageNamed: "fire_1.png"),SKTexture(imageNamed: "fire_2.png"),SKTexture(imageNamed: "fire_3.png"),SKTexture(imageNamed: "fire_4.png"),SKTexture(imageNamed: "fire_5.png"),SKTexture(imageNamed: "fire_6.png"),SKTexture(imageNamed: "fire_7.png"),SKTexture(imageNamed: "fire_8.png"),SKTexture(imageNamed: "fire_9.png"),SKTexture(imageNamed: "fire_10.png"),SKTexture(imageNamed: "fire_11.png")]
        let heroFireAnimation = SKAction.animate(with: heroFireArray, timePerFrame: 0.1)
        let FireHero = SKAction.repeatForever(heroFireAnimation)
        heroNode.run(FireHero)
        //
    }
}///////////////////////////
