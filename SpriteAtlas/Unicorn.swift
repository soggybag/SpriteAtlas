//
//  Unicorn.swift
//  SpriteAtlas
//
//  Created by mitchell hudson on 7/1/16.
//  Copyright © 2016 mitchell hudson. All rights reserved.
//

import SpriteKit


class Unicorn: SKSpriteNode {
    
    var runAction: SKAction!
    var jumpAction: SKAction!
    var dashAction: SKAction!
  
    var isJumping = false
    var isDashing = false
    
    init() {
      
        let defaultTexture = SKTexture(imageNamed: "RU-1")
      
      super.init(texture: defaultTexture, color: UIColor.clear, size: defaultTexture.size())
        
        // ----------------------------------------------------------
        // Setup run action. This action is made from textures 1 to 30
        var textures = [SKTexture]()
        for i in 1...30 {
            let texture = SKTexture(imageNamed: "RU-\(i)")
            textures.append(texture)
        }
        
        // The images are in reverse order for some reason...
        textures = textures.reversed()
        
        // Make an action to play these texture frames
      let animate = SKAction.animate(with: textures, timePerFrame: 0.025, resize: true, restore: false)
        // Run forever magic Unicorn!
      runAction = SKAction.repeatForever(animate) // Save this action for later
      run(runAction)
        
        
        // ----------------------------------------------------------
        // Setup jump action. The jump is made from textures 31 to 59
        textures = []
        for i in 31...59 {
            let texture = SKTexture(imageNamed: "RU-\(i)")
            textures.append(texture)
        }
        
        // For some reason the frames are in reverse order?
        textures = textures.reversed()
        
        // An action to play the jump textures.
      let jump = SKAction.animate(with: textures, timePerFrame: 0.025, resize: true, restore: false)
        
        // The jump should also move the sprite up then down.
      let jumpUp = SKAction.moveBy(x: 0, y: 80, duration: 0.5)      // Move up
      let jumpDown = SKAction.moveBy(x: 0, y: -80, duration: 0.5)   // Move down
        let jumpUpDown = SKAction.sequence([jumpUp, jumpDown])      // The move up move down sequence
        // Use a group to play the textures and do the jump at the same time
        let jumpGroup = SKAction.group([jump, jumpUpDown])
        // When the jump is finished go back to run.
      let backToRun = SKAction.run {
        self.run(self.runAction)
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
        textures = textures.reversed()
        
        // Play the dash textures
      let dash = SKAction.animate(with: textures, timePerFrame: 0.025, resize: true, restore: false)
        // When the dash ends return to a run
      let endDash = SKAction.run {
        self.run(self.runAction)
            self.isDashing = false
        }
        // Save a dash action for later...
        dashAction = SKAction.sequence([dash, endDash])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    func jump() {
        // only jump if not jumping already
        if !isJumping {
            isJumping = true
          run(jumpAction)
        }
    }
    
    func dash() {
        // Only dash if not dashing already
        if !isDashing {
            isDashing = true
          run(dashAction)
        }
    }
    
    
    
    
}







