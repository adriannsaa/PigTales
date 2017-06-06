//
//  MenuScene.swift
//  SpriteKitSimpleGame
//
//  Escena que conforma el menu del juego
//
//  Created by Adrian Nuñez Saa on 1/6/17.
//  Copyright © 2017 Adrian Nuñez Saa. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene{
    
    override func didMove(to view: SKView) {

    }
    
    //Funcion para localizar si tocamos en New Game (Start) y ejecutar el startGame()
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            if atPoint(location).name == "Start"{
                startGame()
            }
        }
    }
    
    private func startGame() {
//        let gameScene = GameScene(size: view!.bounds.size)
//        gameScene.scaleMode = .aspectFill
//        let transition = SKTransition.doorsOpenVertical(withDuration: 2)
//        view!.presentScene(gameScene, transition: transition)
        
        let level1 = GameScene(fileNamed: "GameLevel1")
        let transition = SKTransition.doorsOpenVertical(withDuration: 2)
        self.scene!.view?.presentScene(level1!, transition: transition)
    }
}
