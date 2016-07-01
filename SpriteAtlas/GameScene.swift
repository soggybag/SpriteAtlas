//
//  GameScene.swift
//  SpriteAtlas
//
//  Created by mitchell hudson on 6/30/16.
//  Copyright (c) 2016 mitchell hudson. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var unicorn: SKSpriteNode!
    var runAction: SKAction!
    var jumpAction: SKAction!
    var dashAction: SKAction!
    var isJumping = false
    var isDashing = false
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        // ----------------------------------------------------------
        // Make a Unicorn from a texture
        let texture = SKTexture(imageNamed: "RU-1")
        unicorn = SKSpriteNode(texture: texture)
        unicorn.position.x = 200
        unicorn.position.y = frame.size.height / 2
        addChild(unicorn)
        
        
        // NOTE! Becuase all of the texture images are different size we will use:
        // SKAction.animateWithTextures(_, timePerFrame: resize: restore: )
        // This version of SKAction.animateWithTextures() gives us the option to resize
        // the sprite each time we change texture.
        
        
        // ----------------------------------------------------------
        // Setup run action. This action is made from textures 1 to 30
        var textures = [SKTexture]()
        for i in 1...30 {
            let texture = SKTexture(imageNamed: "RU-\(i)")
            textures.append(texture)
        }
        
        // The images are in reverse order for some reason...
        textures = textures.reverse()
        
        // Make an action to play these texture frames
        let animate = SKAction.animateWithTextures(textures, timePerFrame: 0.025, resize: true, restore: false)
        // Run forever magic Unicorn!
        runAction = SKAction.repeatActionForever(animate) // Save this action for later
        unicorn.runAction(runAction)
        
        
        // ----------------------------------------------------------
        // Setup jump action. The jump is made from textures 31 to 59
        textures = []
        for i in 31...59 {
            let texture = SKTexture(imageNamed: "RU-\(i)")
            textures.append(texture)
        }
        
        // For some reason the frames are in reverse order?
        textures = textures.reverse()
        
        // An action to play the jump textures.
        let jump = SKAction.animateWithTextures(textures, timePerFrame: 0.025, resize: true, restore: false)
        
        // The jump should also move the sprite up then down.
        let jumpUp = SKAction.moveByX(0, y: 80, duration: 0.5)      // Move up
        let jumpDown = SKAction.moveByX(0, y: -80, duration: 0.5)   // Move down
        let jumpUpDown = SKAction.sequence([jumpUp, jumpDown])      // The move up move down sequence
        // Use a group to play the textures and do the jump at the same time
        let jumpGroup = SKAction.group([jump, jumpUpDown])
        // When the jump is finished go back to run.
        let backToRun = SKAction.runBlock { 
            self.unicorn.runAction(self.runAction)
            self.isJumping = false
        }
        // Save this action for later in a variable. We'll need it when you tap on the left side.
        jumpAction = SKAction.sequence([jumpGroup, backToRun])
        
        
        // ----------------------------------------------------------
        // Setup Dash action 
        // This will use textures 61 to 76
        textures = []
        for i in 61...76 {
            let texture = SKTexture(imageNamed: "RU-\(i)")
            textures.append(texture)
        }
        
        // Because they are in reverse order!
        textures = textures.reverse()
        
        // Play the dash textures
        let dash = SKAction.animateWithTextures(textures, timePerFrame: 0.025, resize: true, restore: false)
        // When the dash ends return to a run
        let endDash = SKAction.runBlock { 
            self.unicorn.runAction(self.runAction)
            self.isDashing = false
        }
        // Save a dash action for later...
        dashAction = SKAction.sequence([dash, endDash])
    }
    
    
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        // A touch on the left makes the unicorn jump. 
        // A touch on the right side makes the uniconr dash.
        
        
        let touch = touches.first
        let location = touch?.locationInNode(self)
        if location?.x < frame.width / 2 {
            // only jump if not jumping already
            if !isJumping {
                isJumping = true
                unicorn.runAction(jumpAction)
            }
        } else {
            // Only dash if not dashing already
            if !isDashing {
                isDashing = true
                unicorn.runAction(dashAction)
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
