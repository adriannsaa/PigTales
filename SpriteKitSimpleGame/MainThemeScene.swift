//
//  MainThemeScene.swift
//  SpriteKitSimpleGame
// 
//  Escena que conforma la pantalla de inicio del título
//
//  Created by Adrian Nuñez Saa on 1/6/17.
//  Copyright © 2017 Adrian Nuñez Saa. All rights reserved.
//

import UIKit
import SpriteKit

class MainThemeScene: SKScene {
    
    let titleNode = SKSpriteNode(imageNamed: "Titulo")

    //Funcion para el comportamiento/visualizacion/ejecucion de la escena en la vista
    override func didMove(to view: SKView) {
        titleNode.size = self.frame.size
        titleNode.position = CGPoint(x: frame.midX, y: frame.midY)
        self.addChild(titleNode)
    }
    
    //Función para cuando se toque la pantalla pase al menu (Recoge la posición donde toca el nodo y la guarda)
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        titleNode.name="title"
        
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        //Si se toca la pantalla (Sobre el nodo creado) pasa a la escena Menu
        if(touchedNode.name == "title"){
            print("Touched")
            let menuScene = MenuScene(fileNamed: "MainMenu")
            let transition = SKTransition.reveal(with: .left, duration: 1.0)
            self.scene!.view?.presentScene(menuScene!, transition: transition)
        }
    }
    
}
