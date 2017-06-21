//
//  MenuScene.swift
//  Pig Tales
//
//  Escena que conforma el menu del juego
//
//  Created by Adrian Nuñez Saa.
//  Copyright © 2017 Adrian Nuñez Saa. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene{
    override func didMove(to view: SKView) {
        //Sonido
        let backgroundMusic = SKAudioNode(fileNamed: "MenuMusic.mp3")
        backgroundMusic.autoplayLooped = true
        addChild(backgroundMusic)
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
        let level1 = GameLevel3Scene(fileNamed: "GameLevel_3")
        let transition = SKTransition.doorsOpenVertical(withDuration: 2)
        let newGameSound = SKAction.playSoundFileNamed("MenuSelectionClick.mp3", waitForCompletion: true)
        run(newGameSound)
        self.scene!.view?.presentScene(level1!, transition: transition)
    }
    
}
