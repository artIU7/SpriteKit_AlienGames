//
//  GameScene_Physics.swift
//  runGames
//
//  Created by Артем Стратиенко on 30.10.17.
//  Copyright © 2017 Артем Стратиенко. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    func didBegin(_ contact: SKPhysicsContact)
    {
        if contact.bodyA.categoryBitMask == objectGroup || contact.bodyB .categoryBitMask == objectGroup {
            heroNode.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            electricGateDeadSounds = SKAction.playSoundFileNamed("electricGateStay.mp3", waitForCompletion: true)
            
            if soundTrue == true {
                run(electricGateDeadSounds)
            }
            
            
            heroNode.physicsBody?.allowsRotation = false
            coin.removeAllChildren()
            blueCoin.removeAllChildren()
            groundNode.removeAllChildren()
            skyNode.removeAllChildren()
            //
           
            //
            stopGameSpriteNode()
            //
            timerAddCoin.invalidate()
            timerAddRedCoin.invalidate()
            timerelectricGate.invalidate()
            
            deadAlienArraytexture = [SKTexture(imageNamed: "dead_1.png"),SKTexture(imageNamed: "dead_2.png"),SKTexture(imageNamed: "dead_3.png"),SKTexture(imageNamed: "dead_4.png"),SKTexture(imageNamed: "dead_5.png")]
            let heroDeadAnimation = SKAction.animate(with: deadAlienArraytexture, timePerFrame: 0.2)
            heroNode.run(heroDeadAnimation)
            
            //    DispatchQueue.main .asyncAfter(deadline: .now() + 0.1) {
         
        
           // mainSong = SKAction.playSoundFileNamed("end_sound.wav", waitForCompletion: true )
            //mainSong = SKAction.stop() //(self.mainSong)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                self.scene?.isPaused = true
              //  self.heroNode.removeAllChildren()
                self.GameViewControllerBridge.refreshGameBtn.isHidden = false
               // pause music
                self.playBakgroundSong.pauseplaySoundEffect()
                self.playDeadSong.playSoundEffect("end_sound.wav")
                //
            })
    }
    // = = = = = = = = = = = = = = = =
        if contact.bodyA.categoryBitMask == groundGroup || contact.bodyB .categoryBitMask == groundGroup {
            heroRunArray = [SKTexture(imageNamed: "run_1.png"),SKTexture(imageNamed: "run_2.png"),SKTexture(imageNamed: "run_3.png"),SKTexture(imageNamed: "run_4.png"),SKTexture(imageNamed: "run_5.png"),SKTexture(imageNamed: "run_6.png")]
            let heroRunAnimation = SKAction.animate(with: heroRunArray, timePerFrame: 0.1)
            let runHero = SKAction.repeatForever(heroRunAnimation)
            heroNode.size.height = 70
            heroNode.run(runHero)
        }
        
        if contact.bodyA.categoryBitMask == coinGroup || contact.bodyB.categoryBitMask == coinGroup
        {
            let coinNode = contact.bodyA.collisionBitMask == coinGroup ? contact.bodyA.node : contact.bodyB.node
            if soundTrue == true {
                run(songCoinSelect)
            }
            self.coinCount += 1
            
           coinNode?.removeFromParent()
           
        }
        //GameViewControllerBridge.scoreCountCoins.text = String(coinCount)
        if   contact.bodyA.categoryBitMask == blueCointGroup || contact.bodyB.categoryBitMask == blueCointGroup
        {
             //if contact.bodyA.categoryBitMask == redCointGroup || contact.bodyB.categoryBitMask == redCointGroup
            let bluecoinNode = contact.bodyA.collisionBitMask == blueCointGroup ? contact.bodyA.node : contact.bodyB.node
            if soundTrue == true {
                run(songCoinSelect)
            }
            self.coinCount += 1
            bluecoinNode?.removeFromParent()
            
        }
        GameViewControllerBridge.scoreCountCoins.text = String(coinCount)
        
       // {GameViewControllerBridge.scoreCountCoins.text = String(coinCount)}
      
        }
}
