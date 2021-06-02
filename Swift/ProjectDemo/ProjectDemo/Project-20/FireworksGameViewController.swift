//
//  FireworksGameViewController.swift
//  ProjectDemo
//
//  Created by QDSG on 2021/6/2.
//

import UIKit
import SpriteKit

class FireworksGameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let view = self.view as? SKView {
            // Load the SKScene from 'WhackGameScene.sks'
            if let scene = SKScene(fileNamed: "FireworksGameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    override var shouldAutorotate: Bool { return true }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool { return true }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard let skview = view as? SKView else { return }
        
        guard let gameScene = skview.scene as? FireworksGameScene else { return }
        
        gameScene.explodeFireworks()
    }

}