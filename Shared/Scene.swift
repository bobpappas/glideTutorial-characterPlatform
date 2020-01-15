//
//  Scene.swift
//  glideTutorialCharacterPlatform
//
//  Created by David Pappas on 12/16/19.
//a

import GlideEngine
import SpriteKit

class  Scene: GlideScene {
    
    override func setupScene() {
        
        shouldPauseWhenAppIsInBackground = false
        
        backgroundColor = NSColor(red: 0.58, green: 0.67, blue: 0.69, alpha: 1)
        
        addEntity(platformEntity(at: CGPoint(x: 512, y: 150)))
        
        let characterEntity = CharacterEntity(initialNodePosition: CGPoint(x: 200, y: 300))
        addEntity(characterEntity)
        
    }
    
    func platformEntity(at position: CGPoint) -> GlideEntity {
        
        let entity = GlideEntity(initialNodePosition: position)
        
        let ground1 = SpriteNodeComponent(nodeSize: CGSize(width: 640, height: 64))
        ground1.spriteNode.position = CGPoint(x: 320, y: 64)
        ground1.spriteNode.zPosition = 0
        ground1.spriteNode.texture = SKTexture(imageNamed: "platform2")
        ground1.spriteNode.texture?.filteringMode = .nearest
        entity.addComponent(ground1)
        

        
        let colliderComponent = ColliderComponent(categoryMask: GlideCategoryMask.none,
                                                  size: CGSize(width: 640, height: 64),
                                                  offset: .zero, leftHitPointsOffsets: (10, 10),
                                                  rightHitPointsOffsets: (10, 10),
                                                  topHitPointsOffsets: (10, 10),
                                                  bottomHitPointsOffsets: (10, right: 10))
        entity.addComponent(colliderComponent)
        
        let snappableCompotent = SnappableComponent(providesOneWayCollision: false)
        entity.addComponent(snappableCompotent)
        return entity
        
    }
}
