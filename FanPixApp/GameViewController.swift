//
//  GameViewController.swift
//  FanPixApp
//
//  Created by Matheus Maxwell Meireles on 02/06/17.
//  Copyright © 2017 maxnewsoftware. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bounds = UIScreen.main.bounds
        let width = bounds.width
        let height = bounds.height
        
        let scene = MenuInicio(size: CGSize(width: width, height: height))
        let skView = self.view as! SKView
        
        skView.showsNodeCount = false
        skView.showsPhysics = true
        skView.ignoresSiblingOrder = true
        
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
        
        SKTAudio.sharedInstance().playBackgroundMusic(filename: "musicaIntro.mp3")
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
