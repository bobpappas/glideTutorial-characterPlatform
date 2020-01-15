//
//  GameViewController.swift
//  glideTutorialCharacterPlatform
//
//  Created by David Pappas on 12/15/19.
//

//import Foundation
import GlideEngine
import SpriteKit

class GameViewController: ViewControllerType {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = Scene(collisionTileMapNode: nil, zPositionContainers: [])
        
        scene.scaleMode = .resizeFill
        
        (view as? SKView)?.ignoresSiblingOrder = true
        
        (view as? SKView)?.presentScene(scene)
    }
}
