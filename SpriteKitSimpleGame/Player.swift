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
    
    // Velocidad de movimiento por defecto
    var defaultSpeed = CGFloat(5.0)
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
        
        //Fisicas del jugador
        //self.physicsBody = SKPhysicsBody(circleOfRadius: max(self.size.width / 2,
        //                                                       self.size.height / 2))
    }
    
    // Animacion de andar
    func walk(directions: [CharacterDirection]) {
        
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
        //Sonido saltar
        let jumpSound = SKAction.playSoundFileNamed("Jump.mp3", waitForCompletion: false)
        //Sube 20 puntos
        let jumpUpAction = SKAction.moveBy(x: 0, y:20, duration:0.2)
        //Baja 20 puntos
        let jumpDownAction = SKAction.moveBy(x: 0, y:-20, duration:0.2)
        //Secuencia completa de salto
        let jumpSequence = SKAction.sequence([jumpSound, jumpUpAction, jumpDownAction])
        //Ejecuta la secuencia
        run(jumpSequence)
    }
    
}
