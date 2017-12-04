//
//  GameViewController.swift
//  runGames
//
//  Created by Артем Стратиенко on 29.10.17.
//  Copyright © 2017 Артем Стратиенко. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    @IBOutlet weak var scoreCountCoins: UILabel!
    @IBOutlet weak var refreshGameBtn: UIButton!
    var scene = GameScene(size: CGSize(width: 568, height: 320))
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshGameBtn.isHidden = true
        
        let view = self.view as! SKView
        view.ignoresSiblingOrder = true
        scene.scaleMode = .aspectFill
        scene.GameViewControllerBridge = self
        view.presentScene(scene)

    }
    
    @IBAction func refreshGame(sender : UIButton) {
        scene.reloadGame()
        refreshGameBtn.isHidden = true
        
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
