//
//  GameScene.swift
//  SpriteAtlas
//
//  Created by mitchell hudson on 6/30/16.
//  Copyright (c) 2016 mitchell hudson. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    // Make a Unicorn
    let unicorn = Unicorn()
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        // Setup the unicorn
        addChild(unicorn)
        unicorn.position.x = 200
        unicorn.position.y = frame.size.height / 2
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        // A touch on the left makes the unicorn jump. 
        // A touch on the right side makes the uniconr dash.
        
        let touch = touches.first
        let location = touch?.locationInNode(self)
        if location?.x < frame.width / 2 {
            // make the unicorn jump
            unicorn.jump()
        } else {
            // Make the unicorn dash
            unicorn.dash()
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
