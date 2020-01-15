//
//  CharacterEntety.swift
//  glideTutorialCharacterPlatform
//
//  Created by David Pappas on 12/17/19.
//

import GlideEngine
import GameplayKit

class CharacterEntity: GlideEntity {
    
    override func setup() {
        
        let spriteNodeComponent = SpriteNodeComponent(nodeSize: CGSize(width: 64, height: 64))
        spriteNodeComponent.spriteNode.texture = SKTexture(imageNamed: "DTC Standing")
        spriteNodeComponent.spriteNode.zPosition = 1
        spriteNodeComponent.spriteNode.texture?.filteringMode = .nearest
        addComponent(spriteNodeComponent)
        
        var kinematicsBodyConfiguration = KinematicsBodyComponent.sharedConfiguration
        kinematicsBodyConfiguration.maximumVerticalVelocity = 20.0
        let kinematicsBodyComponent = KinematicsBodyComponent(configuration: kinematicsBodyConfiguration)
        addComponent(kinematicsBodyComponent)
    
        let colliderComponent = ColliderComponent(categoryMask: GlideCategoryMask.none,
                                                  size: CGSize(width: 50, height: 55),
                                                  offset: .zero, leftHitPointsOffsets: (10, 10),
                                                  rightHitPointsOffsets: (10, 10),
                                                  topHitPointsOffsets: (10, 10),
                                                  bottomHitPointsOffsets: (10, right: 10))
        addComponent(colliderComponent)
        
        let snapperComponent = SnapperComponent()
        addComponent(snapperComponent)
        
        var config = HorizontalMovementComponent.sharedConfiguration

        config.acceleration = 100.0
        config.deceleration = 100.0
        
        let horizontalMovementComponent = HorizontalMovementComponent(movementStyle: .accelerated)
        addComponent(horizontalMovementComponent)
        
        let playableCharacterComponent = PlayableCharacterComponent(playerIndex: 0)
        addComponent(playableCharacterComponent)
        
        setupTextureAnamations()
        
        let characterComponent = CharacterComponent()
        addComponent(characterComponent)
        
        var jumpConfiguration = JumpComponent.sharedConfiguration
        jumpConfiguration.jumpingVelocity = 30.0
        let jumpComponent = JumpComponent(configuration: jumpConfiguration)
        addComponent(jumpComponent)
        
    }
    
    func setupTextureAnamations() {
        let timePerFrame: TimeInterval = 0.10
        let animationSize = CGSize(width: 64, height: 64)
        
        
        let idleAction = TextureAnimation.Action(textureFormat: "DTC Standing",
                                                 numberOfFrames: 1,
                                                 timePerFrame: timePerFrame)
        let idleAnimation = TextureAnimation(triggerName: "Idle",
                                             offset: .zero,
                                             size: animationSize,
                                             action: idleAction,
                                             loops: true)
       
        let animatorComponent = TextureAnimatorComponent(entryAnimation: idleAnimation)
        addComponent(animatorComponent)
        
        let walkAction = TextureAnimation.Action(textureFormat: "DTC Walking %d",
                                                 numberOfFrames: 3,
                                                 timePerFrame: timePerFrame)
        let walkAnimation = TextureAnimation(triggerName: "Walk",
                                             offset: .zero,
                                             size: animationSize,
                                             action: walkAction,
                                             loops: true)
        animatorComponent.addAnimation(walkAnimation)
    }
}

class CharacterComponent: GKComponent, GlideComponent {
    
    
    func didUpdate(deltaTime seconds: TimeInterval) {
        
        let horizontalMovementComponent = entity?.component(ofType: HorizontalMovementComponent.self)
        let textureAnimatorComponent = entity?.component(ofType: TextureAnimatorComponent.self)
        
        if horizontalMovementComponent?.movementDirection != .stationary {
            textureAnimatorComponent?.enableAnimation(with: "Walk")
        } else {
            textureAnimatorComponent?.enableAnimation(with: "Idle")
        }
    }
}

