//
//  Player.swift
//  SpriteKitSimpleGame
//
//  Created by Adrian Nuñez Saa on 7/6/17.
//  Copyright © 2017 Adrian Nuñez Saa. All rights reserved.
//

import SpriteKit

// Creamos un enum con las direcciones del personaje
enum CharacterDirection : Int {
    case Left
    case Right
}

class Player: SKSpriteNode {
    let sprites = SKTextureAtlas(named: "Player")
    
    
    // Hacia donde mira el personaje
    var currentDirection: CharacterDirection?
    // Hacia donde miraba el personaje antes de hacer una acción
    var lastDirection: CharacterDirection?
    
    // Velocidad de movimiento media
    var defaultSpeed = CGFloat(2.4)
    // Velocidad al arrancar
    var walkingSpeed = CGFloat(0.0)
    //Instante
    var tick = 0
    
    //"Constructor"
    convenience init(named: String) {
        let texture = SKTextureAtlas(named:"Player").textureNamed(named)
        texture.filteringMode = .nearest
        self.init(texture: texture)
        self.setScale(2.0)
        
        self.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        walkingSpeed = defaultSpeed
        lastDirection = .Right
        self.zPosition = 10        
    }
    
    // Animacion de andar
    func walk(directions: [CharacterDirection]) {
        var walkingSpeed: CGFloat = 2.0
        
        if directions.count == 2 {
            walkingSpeed = walkingSpeed / sqrt(2.0)
        }
        
        // Cogemos la direccion del sprite y se mueve
        if directions.index(of: .Left) != nil {
            self.position.x -= walkingSpeed
            if currentDirection == nil || directions.count == 1 {
                currentDirection = .Left
            }
        }
        if directions.index(of: .Right) != nil {
            self.position.x += walkingSpeed
            if currentDirection == nil || directions.count == 1 {
                currentDirection = .Right
            }
        }
        
        if currentDirection != nil {
            lastDirection = currentDirection
        }
        
        if !directions.isEmpty && self.currentDirection != nil {
            switch currentDirection! {
            case .Left:
                if tick % 20 < 10 {
                    self.texture = sprites.textureNamed("vida3_1_left")
                }
                else {
                    self.texture = sprites.textureNamed("vida3_2_left")
                }
            case .Right:
                if tick % 20 < 10 {
                    self.texture = sprites.textureNamed("vida3_1")
                }
                else {
                    self.texture = sprites.textureNamed("vida3_2")
                }
            }
        }
        else {
            currentDirection = nil
        }
        
        tick += 1
        if tick > 60 {
            tick = 0
        }
    }
    
    //Animacion saltar
    func jump(){
        //Sube 20 puntos
        let jumpUpAction = SKAction.moveBy(x: 0, y:20, duration:0.2)
        //Baja 20 puntos
        let jumpDownAction = SKAction.moveBy(x: 0, y:-20, duration:0.2)
        //Secuencia completa de salto
        let jumpSequence = SKAction.sequence([jumpUpAction, jumpDownAction])
        //Ejecuta la secuencia
        run(jumpSequence)
    }
    
}
