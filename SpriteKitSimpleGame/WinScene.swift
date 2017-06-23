//
//  WinScene.swift
//  Pig Tales
//
//  Created by Adrian Nuñez Saa.
//  Copyright © 2017 Adrian Nuñez Saa. All rights reserved.
//

import Foundation
import SpriteKit

class WinScene: SKScene{
    
    override func didMove(to view: SKView) {
        //Sonido
        let backgroundMusic = SKAudioNode(fileNamed: "Congratulations.mp3")
        backgroundMusic.autoplayLooped = true
        addChild(backgroundMusic)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        if(touchedNode.name == "finalNode"){
            let menuScene = MenuScene(fileNamed: "MainMenu")
            let transition = SKTransition.reveal(with: .left, duration: 1.0)
            self.scene!.view?.presentScene(menuScene!, transition: transition)
        }
    }
    
}

