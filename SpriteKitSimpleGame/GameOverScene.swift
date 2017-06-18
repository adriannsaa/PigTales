//
//  GameOverScene.swift
//  Pig Tales
//
//  Created by Adrian Nuñez Saa.
//  Copyright © 2017 Adrian Nuñez Saa. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene{
    let gameOverNode = SKSpriteNode()
    
    //Funcion para el comportamiento/visualizacion/ejecucion de la escena en la vista
    override func didMove(to view: SKView) {
        gameOverNode.size = self.frame.size
        gameOverNode.position = CGPoint(x: frame.midX, y: frame.midY)
        self.addChild(gameOverNode)
        
        //Sonido
        let backgroundMusic = SKAudioNode(fileNamed: "GameOver.mp3")
        backgroundMusic.autoplayLooped = true
        addChild(backgroundMusic)
    }
    
    //Función para cuando se toque la pantalla pase al menu (Recoge la posición donde toca el nodo y la guarda)
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        gameOverNode.name="gameOver"
        
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        //Si se toca la pantalla (Sobre el nodo creado) pasa a la escena Menu
        if(touchedNode.name == "gameOver"){
            let menuScene = MenuScene(fileNamed: "MainMenu")
            let transition = SKTransition.reveal(with: .left, duration: 1.0)
            self.scene!.view?.presentScene(menuScene!, transition: transition)
        }
    }

}
