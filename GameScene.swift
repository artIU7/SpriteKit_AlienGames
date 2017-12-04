//
//  GameScene.swift
//  runGames
//
//  Created by Артем Стратиенко on 29.10.17.
//  Copyright © 2017 Артем Стратиенко. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene,SKPhysicsContactDelegate  {
    //
    var GameViewControllerBridge : GameViewController!
    // bad hero header
    // SKTexture
    var badHeroTexture : SKTexture!
    // SKSpriteNode
    var badHero : SKSpriteNode!
    // [SKTexture]
    var badHeroArray : [SKTexture]!
    // bit mask
    var badheroGroup : UInt32 = 0x1 << 6
    // animation header
    var animations = AnimationClass()
    // var sound
    var soundTrue = true 
    // BackGround Frame
    var  BackgroundSprite : SKSpriteNode!
    var Texture : SKTexture!
    // coin object
    var coin = SKSpriteNode()
    var blueCoin = SKSpriteNode()
    var coinTexture : SKTexture!
    var blueCoinTexture : SKTexture!
    var coinTex : SKTexture!
    var blueCoindTex : SKTexture!
    var coinTextureArray : [SKTexture]!
    // hero object
    var heroNode : SKSpriteNode!
    var heroTexture : SKTexture!
    var heroJumpTexture : SKTexture!
    var bacgroundFrame : SKTexture!// = SKTexture(imageNamed: "bg_2x.png")
    var heroRunArray : [SKTexture]!
    var heroJumpArray : [SKTexture]!
    var heroFireArray : [SKTexture]!
    // emitters SKNode
    var heroEmitter : SKEmitterNode!
    // ground SKNode
    var groundTexture : SKTexture!
    var groundNode : SKSpriteNode!
    // sky SKNode
    var skyTexture_ : SKTexture!
    var skyNode_ : SKSpriteNode!
    // upperLimit_SKY
    var skyTexture : SKTexture!
    var skyNode : SKSpriteNode!
    // bitMask for ground_to_object
    var heroGroup : UInt32 = 0x1 << 1
    var groundGroup : UInt32 = 0x1 << 2
    var skyGroup : UInt32 = 0x1 << 2
    var coinGroup : UInt32 = 0x1 << 4
    var blueCointGroup : UInt32 = 0x1 << 5
    // sound's variable
    var songCoinSelect = SKAction()
    var mainSong = SKAction()
    //
    // =============
    // timer's
    var timerAddCoin = Timer()
    var timerAddRedCoin = Timer()
    var timeraddbadhero = Timer()
    //
    // electricGate variable's
    var electricGateTexture : SKTexture!
    var deadAlien : SKTexture!
    var electricGateNode : SKSpriteNode!
    var electricGateArrayTexture : [SKTexture]!
    var deadAlienArraytexture : [SKTexture]!
    var timerelectricGate = Timer()
    var electricGateCreateSounds = SKAction()
    var electricGateDeadSounds = SKAction()
    var objectGroup : UInt32 = 0x1 << 6
    // =========didMove function =============
    // audio object in SKAudio() class
      let playBakgroundSong = SKTAudio()
        let playDeadSong = SKTAudio()
  //  let playFlightPlane = SKTAudio()
    //
    //
    var coinCount : Int = 0
    override func didMove(to view: SKView) {
        
      
       // playBakgroundSong.playBackgroundMusic("end_sound.wav")
        playBakgroundSong.playSoundEffect("AlienAdventureMainTheme.mp3")
    if playBakgroundSong.soundEffectPlayer?.isPlaying == false
    {
        playBakgroundSong.resumeplaySoundEffect()
        }
        //initEmitters()
           DispatchQueue.main .asyncAfter(deadline: .now())
            {
              self.physicsWorld.contactDelegate = self
                self.SKSpriteBackendFrame()
                    self.groundAdd()
                        self.skyAdd()
    }

        DispatchQueue.main .asyncAfter(deadline: .now() + 0.1) {
            self.createHero()
            self.timePutCoin()
            self.timePutElectricGate()
            self.songCoinSelect = SKAction.playSoundFileNamed("spell2.wav", waitForCompletion: false )
        }
        GameViewControllerBridge.refreshGameBtn.isHidden = true 
    }
    // ======================================
    //
    @objc func addObjElectricGate() {
        electricGateCreateSounds = SKAction.playSoundFileNamed("electric_candidate#1.mp3", waitForCompletion: true)
        if soundTrue == true {
            run(electricGateCreateSounds)
        }
        electricGateTexture = SKTexture(imageNamed: "ElectricGate_0.png")
        
        
        electricGateNode = SKSpriteNode(texture: electricGateTexture)
        electricGateArrayTexture = [SKTexture(imageNamed: "ElectricGate_0.png"),SKTexture(imageNamed: "ElectricGate_1.png"),SKTexture(imageNamed: "ElectricGate_2.png"),SKTexture(imageNamed: "ElectricGate_3.png")]
        let electricGateAnimation = SKAction.animate(with: electricGateArrayTexture, timePerFrame: 0.1)
        let electricGateAnimationForever = SKAction.repeatForever(electricGateAnimation)
        electricGateNode.run(electricGateAnimationForever)
        electricGateNode.size.width = 25
        electricGateNode.size.height = 80
        let positionGate = arc4random() % 2
        let moveAmount = arc4random() % UInt32(self.frame.height/10)
        let pipeOfSet = self.frame.size.height/4 - CGFloat(moveAmount)
        //
        if positionGate == 0 {
                electricGateNode.position = CGPoint(x: self.size.width + 30, y: self.size.height/4/*electricGateTexture.size().height/2*/ + 45 + pipeOfSet)
                electricGateNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: electricGateNode.size.width-40, height: electricGateNode.size.height-20))
        }
        else
        {
                electricGateNode.position = CGPoint(x: self.size.width - 30, y: self.size.height/4/*electricGateTexture.size().height/2*/ - 45 + pipeOfSet)
                electricGateNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: electricGateNode.size.width-40, height: electricGateNode.size.height-20))
        }
        // rotate
       electricGateNode.run(SKAction.repeatForever(SKAction.sequence([SKAction.run {
            self.electricGateNode.run(SKAction.rotate(byAngle: CGFloat(M_PI), duration: 0.5))
            },SKAction.wait(forDuration: 20.0)])))
        // move
        let moveAction = SKAction.moveBy(x: -self.frame.width - 50, y: 0, duration: 3)
        electricGateNode.run(moveAction)
        // scale
        var scaleValue : CGFloat = 1.2
        electricGateNode.setScale(scaleValue)
        //
        electricGateNode.physicsBody?.restitution = 0
        electricGateNode.physicsBody?.isDynamic = false
        electricGateNode.physicsBody?.categoryBitMask = objectGroup
        electricGateNode.zPosition = 1
        self.addChild(electricGateNode)
        
    }
    //
  @objc  func addblueCoin () {
        blueCoinTexture = SKTexture(imageNamed: "coin1_blue.png")
        blueCoin = SKSpriteNode(texture: blueCoinTexture)
        coinTextureArray = [SKTexture(imageNamed: "coin1_blue.png"),SKTexture(imageNamed: "coin2_blue.png"),SKTexture(imageNamed: "coin3_blue.png"),SKTexture(imageNamed: "coin4_blue.png"),SKTexture(imageNamed: "coin5_blue.png"),SKTexture(imageNamed: "coin6_blue.png")]
        let bluecoinAnimation = SKAction.animate(with: coinTextureArray, timePerFrame: 0.1)
        //
        let bluecoinRun = SKAction.repeatForever(bluecoinAnimation)
        blueCoin.run(bluecoinRun)
        let moveAmount = arc4random() % UInt32(self.frame.height/2)
        let pipeOfSet = CGFloat(moveAmount) - self.frame.size.height/2
        blueCoin.size.width = 20
        blueCoin.size.height = 20
        blueCoin.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: blueCoin.size.width, height: blueCoin.size.height))
        blueCoin.physicsBody?.restitution = 0
        blueCoin.position = CGPoint(x: self.size.width + 50, y: 0 + blueCoinTexture.size().height + 90 + pipeOfSet)
        let moveCoin = SKAction.moveBy(x: -self.frame.width*2, y: 0, duration: 5)
        let removeCoin = SKAction.removeFromParent()
        let coinMoveForever = SKAction.repeatForever(SKAction.sequence([moveCoin,removeCoin]))
        blueCoin.run(coinMoveForever)
            animations.scaleObj(inputSprite: blueCoin)
                animations.colorAnimationObj(inputSprite: blueCoin, animationTime: 3.0)
        blueCoin.setScale(0.9)
        blueCoin.physicsBody?.isDynamic = false
        blueCoin.physicsBody?.categoryBitMask = blueCointGroup
        blueCoin.zPosition = 1
        self.addChild(blueCoin)
    }
    // coin
    @objc func addCoin() {
         coinTexture = SKTexture(imageNamed: "coin1.png")
         //coinTex = SKTexture(imageNamed: "coin1.png")
        // redCoindTex = SKTexture(imageNamed: "coin1.png")
        coin = SKSpriteNode(texture: coinTexture)
        coinTextureArray = [SKTexture(imageNamed: "coin1.png"),SKTexture(imageNamed: "coin2.png"),SKTexture(imageNamed: "coin3.png"),SKTexture(imageNamed: "coin4.png"),SKTexture(imageNamed: "coin5.png"),SKTexture(imageNamed: "coin6.png")]
        let coinAnimation = SKAction.animate(with: coinTextureArray, timePerFrame: 0.1)
        //
        let coinRun = SKAction.repeatForever(coinAnimation)
        coin.run(coinRun)
        let moveAmount = arc4random() % UInt32(self.frame.height/2)
        let pipeOfSet = CGFloat(moveAmount) - self.frame.size.height/2
        coin.size.width = 20
        coin.size.height = 20
        coin.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: coin.size.width, height: coin.size.height))
        coin.physicsBody?.restitution = 0
        coin.position = CGPoint(x: self.size.width + 50, y: 0 + coinTexture.size().height + 90 + pipeOfSet)
        let moveCoin = SKAction.moveBy(x: -self.frame.width*2, y: 0, duration: 5)
        let removeCoin = SKAction.removeFromParent()
        let coinMoveForever = SKAction.repeatForever(SKAction.sequence([moveCoin,removeCoin]))
        coin.run(coinMoveForever)
        
        coin.physicsBody?.isDynamic = false
        coin.physicsBody?.categoryBitMask = coinGroup
        coin.zPosition = 1
        self.addChild(coin)
    }
    func timePutCoin () {
        timerAddCoin.invalidate()
        timerAddRedCoin.invalidate()
        
        timerAddCoin = Timer.scheduledTimer(timeInterval: 1.27, target: self, selector: "addCoin", userInfo: nil, repeats: true)
        timerAddRedCoin = Timer.scheduledTimer(timeInterval: 7.89, target: self, selector: "addblueCoin", userInfo: nil, repeats: true)
        //timerAddRedCoin = Timer.scheduledTimer(timeInterval: 8.54, target: self, selector: "addredCoin", userInfo: "small", repeats: true)
    }
    func timePutbadHero () {
        timeraddbadhero.invalidate()
        
        timeraddbadhero = Timer.scheduledTimer(timeInterval: 1.27, target: self, selector: "appendbadHero", userInfo: nil, repeats: true)
    }
    func timePutElectricGate () {
        timerelectricGate.invalidate()
        timerelectricGate = Timer.scheduledTimer(timeInterval: 5.234, target: self, selector: "addObjElectricGate", userInfo: nil, repeats: true)
    }
    func initEmitters(){
        heroEmitter = SKEmitterNode(fileNamed: "rainWorld.sks")!
        heroEmitter.zPosition = 1
        self.addChild(heroEmitter)
    }
    func createHeroEmmiter () {
        
    }
    func skyAdd() {
        //skyTexture = SKTexture(imageNamed: "ground_.png")
       
        skyNode = SKSpriteNode()/*texture: skyTexture*/
        skyNode.size.width = 568
        skyNode.size.height = 10
        skyNode.position = CGPoint(x: 284, y: 315)
        skyNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: skyNode.size.width /*groundTexture.size().width //self.frame.width/2 */, height: skyNode.size.height /*groundTexture.size().height //self.frame.size.height/4 + self.frame.height/8)*/))
        skyNode.physicsBody?.isDynamic = false
        skyNode.physicsBody?.categoryBitMask = skyGroup
        skyNode.zPosition = 1
        self.addChild(skyNode)
    }
    func groundAdd() {
        groundTexture = SKTexture(imageNamed: "ground_.png")
        groundNode = SKSpriteNode(texture: groundTexture)
        groundNode.size.width = 568
        groundNode.size.height = 40
        groundNode.position = CGPoint(x: 284, y: 20)
        groundNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: groundNode.size.width /*groundTexture.size().width //self.frame.width/2 */, height: groundNode.size.height /*groundTexture.size().height //self.frame.size.height/4 + self.frame.height/8)*/))
        groundNode.physicsBody?.isDynamic = false
        groundNode.physicsBody?.categoryBitMask = groundGroup
        groundNode.zPosition = 1
        self.addChild(groundNode)
    }
    func loadbackroung(){
        bacgroundFrame = SKTexture(imageNamed: "bg_2x.png")
            let moveBack = SKAction.moveBy(x: -bacgroundFrame.size().width, y: 0, duration: 3)
                let replaceBack = SKAction.moveBy(x: bacgroundFrame.size().width, y: 0, duration: 0)
                    let movereplaceAction = SKAction.repeatForever(SKAction.sequence([moveBack,replaceBack]))
        for i in 0..<3 {
            let backNode = SKSpriteNode(texture: bacgroundFrame)
            backNode.position = CGPoint(x: size.width/4 + bacgroundFrame.size().width * CGFloat(i), y: size.height/2)
            backNode.size.height = self.frame.height
            backNode.run(movereplaceAction)
            backNode.zPosition = -1
            self.addChild(backNode)
        }
    }
    // create Sky moving invert
    func SKSpriteSky()
        {
        skyTexture_ = SKTexture(imageNamed: "sky_.png")
        skyNode_ = SKSpriteNode(texture: skyTexture_)
        skyNode_.size.width = 568
        skyNode_.size.height = 40
            let moveSky = SKAction.moveBy(x: -skyNode_.size.width, y: 0, duration: 2)
                let replaceSky = SKAction.moveBy(x: skyNode_.size.width, y: 0, duration: 0)
                    let movereplaceSky = SKAction.repeatForever(SKAction.sequence([moveSky,replaceSky]))
            for i in 0..<3 {
                skyNode_ = SKSpriteNode(texture: skyTexture_)
                skyNode_.position = CGPoint(x: size.width/4 + skyNode_.size.width*CGFloat(i), y: size.height/2)
                
                skyNode_.size.height = self.frame.height
                skyNode_.run(movereplaceSky)
                skyNode_.zPosition = -1
                self.addChild(skyNode_)
            }
        }
    // create backend"Frame" -
    func SKSpriteBackendFrame(){
        //Создаем переменную Texture и ей присваиваем объект типа SKTexture. В качестве параметра передаем имя нашего изображение
        Texture = SKTexture(imageNamed: "desert_BG.png")
        //let SKBackTexture = SKSpriteNode(texture: Texture)
       //
        //var  BackgroundSprite : SKSpriteNode! //SKSpriteNode(texture: Texture)
        //Создаем переменную BackgroundSprite и ей присваиваем объект типа SKSpriteNode.
        //В качестве параметра передаем объект типа SKTexture созданный нами  выше.
        //let BackgroundSprite = SKSpriteNode(texture: Texture)
        //BackgroundSprite.size = CGSize(width: 568, height: 320)//CGSizeMake(640, 320) //задаем размер.
        //BackgroundSprite.position = CGPoint(x: 0, y: 0)//CGPointMake(0, 0) //задаем позицию.
        //BackgroundSprite.anchorPoint = CGPoint(x: 0, y: 0)//CGPointMake(0, 0) //задаем начальную точку.
        //BackgroundSprite.name = "BackgroundSprite" // задаем имя.
        //
        
        //
        BackgroundSprite = SKSpriteNode(texture : Texture)
        let moveSprite = SKAction.moveBy(x: -BackgroundSprite.size.width, y: 0, duration: 2)
            let replaceSprite = SKAction.moveBy(x: BackgroundSprite.size.width, y: 0, duration: 0)
                let moveraplaceSprite = SKAction.repeatForever(SKAction.sequence([moveSprite,replaceSprite]))
        for i in 0..<3 {
            /*let*/
            BackgroundSprite = SKSpriteNode(texture: Texture)
                BackgroundSprite.position = CGPoint(x: size.width/4 + BackgroundSprite.size.width*CGFloat(i), y: size.height/2)
                    BackgroundSprite.size.height = self.frame.height
                        BackgroundSprite.run(moveraplaceSprite)
            BackgroundSprite.zPosition = -1
        self.addChild(BackgroundSprite) //добавляем наш объект на нашу сцену.
        }
    }
    //  ==  =   =   =   =   =   =   =   =   =   =   =   =   =
    // create hero objects_ under backendFrame
    func addHero(heroSprite : SKSpriteNode, heroPos : CGPoint)
    {
       
        heroTexture = SKTexture(imageNamed: "run_1.png")
        //.CGSize(width: 20, height: 55)
      //  heroTexture.size().height = 55
        heroNode = SKSpriteNode(texture : heroTexture)
        heroNode.size.width = 30
        heroNode.size.height = 70
        //
        heroRunArray = [SKTexture(imageNamed: "run_1.png"),SKTexture(imageNamed: "run_2.png"),SKTexture(imageNamed: "run_3.png"),SKTexture(imageNamed: "run_4.png"),SKTexture(imageNamed: "run_5.png"),SKTexture(imageNamed: "run_6.png")]
        let heroRunAnimation = SKAction.animate(with: heroRunArray, timePerFrame: 0.1)
        //
        let runHero = SKAction.repeatForever(heroRunAnimation)
        //
        heroNode.run(runHero)
        heroNode.position = heroPos
        //heroNode.size.width = 70
     //
        heroNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: heroNode.size.width + 20 , height: heroNode.size.height))
        heroNode.physicsBody?.categoryBitMask = heroGroup
        heroNode.physicsBody?.contactTestBitMask = groundGroup | coinGroup | blueCointGroup | objectGroup
        heroNode.physicsBody?.collisionBitMask = groundGroup
       // heroNode.physicsBody?.collisionBitMask = skyGroup
       // heroNode.physicsBody?.contactTestBitMask = skyGroup
       // heroNode.physicsBody?.collisionBitMask = skyGroup
  
        
        heroNode.physicsBody?.isDynamic = true
        heroNode.physicsBody?.allowsRotation = false
        heroNode.zPosition = 1
        
        self.addChild(heroNode)
    }
    func createHero() {
        heroTexture = SKTexture(imageNamed: "run_1.png")
        heroNode = SKSpriteNode(texture : heroTexture)
       // heroNode.size.width = 38
       // heroNode.size.height = 70
        
        //  addCoin()//
        addHero(heroSprite: heroNode, heroPos: CGPoint(x: self.size.width/8, y: CGFloat(heroTexture.size().height/100 + 20)))
     
    }
    override func didFinishUpdate() {
        //heroEmitter.position = CGPoint(x: 50, y: 320)//BackgroundSprite.position //- CGPoint(x: 400, y: 0) //CGPoint(x: 10, y: 5)
    }
     //
   @objc func appendbadHero() {
        badHeroTexture = SKTexture(imageNamed: "1.png")
        //coinTex = SKTexture(imageNamed: "coin1.png")
        // redCoindTex = SKTexture(imageNamed: "coin1.png")
        badHero = SKSpriteNode(texture: coinTexture)
        badHeroArray = [SKTexture(imageNamed: "1.png"),SKTexture(imageNamed: "2.png"),SKTexture(imageNamed: "3.png"),SKTexture(imageNamed: "4.png"),SKTexture(imageNamed: "5.png")]
        let badheroAnimation = SKAction.animate(with: badHeroArray, timePerFrame: 0.1)
        //
        let badheroRun = SKAction.repeatForever(badheroAnimation)
        badHero.run(badheroRun)
        let moveAmount = arc4random() % UInt32(self.frame.height/2)
        let pipeOfSet = CGFloat(moveAmount) - self.frame.size.height
        badHero.size.width = 30
        badHero.size.height = 70
        badHero.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: badHero.size.width, height: badHero.size.height))
        badHero.physicsBody?.restitution = 0
        badHero.position = CGPoint(x: self.size.width + 50, y: 0 + badHeroTexture.size().height + 90 + pipeOfSet)
        let movebadHero = SKAction.moveBy(x: -self.frame.width*2, y: 0, duration: 5)
        let removebadHero = SKAction.removeFromParent()
        let badHeroMoveForever = SKAction.repeatForever(SKAction.sequence([movebadHero,removebadHero]))
        badHero.run(badHeroMoveForever)
        
        badHero.physicsBody?.isDynamic = false
        badHero.physicsBody?.categoryBitMask = badheroGroup
        badHero.zPosition = 1
        self.addChild(badHero)
    }
    //
    func stopGameSpriteNode() {
        coin.speed = 0
        blueCoin.speed = 0
        groundNode.speed = 0
        skyNode.speed = 0
        heroNode.speed = 0.5
        //self.mainSong = SKAction.pause()
       // BackgroundSprite.speed = 0
    }
    func reloadGame() {
        coin.removeAllChildren()
        blueCoin.removeAllChildren()
        scene?.isPaused = false
        heroNode.removeAllChildren()
        coin.speed = 1
        //heroNode.speed = 1
        //BackgroundSprite.speed = 1
        self.speed = 1
        //SKSpriteBackendFrame()
        groundAdd()
        skyAdd()
        //
        //createHero()
        //
        timerAddCoin.invalidate()
        timerAddRedCoin.invalidate()
        timerelectricGate.invalidate()
        //
        timePutCoin()
        timePutElectricGate()
        self.playDeadSong.pauseplaySoundEffect()
        self.playBakgroundSong.resumeplaySoundEffect()
        
        //
        //mainSong = SKAction.playSoundFileNamed("AlienAdventureMainTheme.mp3", waitForCompletion: false )
        //run(mainSong)
    }
    //  =   = =   = =  =   =   =   =   =   =
}
        

