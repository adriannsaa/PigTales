//
//  Player.swift
//  Pig Tales
//
//  Created by Adrian Nuñez Saa.
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
    var lives = 3
    
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
        
        walkingSpeed = defaultSpeed
        lastDirection = .Right
        self.zPosition = 10
        
        //Fisicas del jugador
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width,height: self.size.height))
        self.physicsBody?.allowsRotation = false
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
        
        if lives == 3{
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
        }
        if lives == 2{
            if !directions.isEmpty && self.currentDirection != nil {
                switch currentDirection! {
                case .Left:
                    if tick % 20 < 10 {
                        self.texture = sprites.textureNamed("vida2_1_left")
                    }
                    else {
                        self.texture = sprites.textureNamed("vida2_2_left")
                    }
                case .Right:
                    if tick % 20 < 10 {
                        self.texture = sprites.textureNamed("vida2_1")
                    }
                    else {
                        self.texture = sprites.textureNamed("vida2_2")
                    }
                }
            }
            else {
                currentDirection = nil
            }
        }
        if lives == 1{
            if !directions.isEmpty && self.currentDirection != nil {
                switch currentDirection! {
                case .Left:
                    if tick % 20 < 10 {
                        self.texture = sprites.textureNamed("vida1_1_left")
                    }
                    else {
                        self.texture = sprites.textureNamed("vida1_2_left")
                    }
                case .Right:
                    if tick % 20 < 10 {
                        self.texture = sprites.textureNamed("vida1_1")
                    }
                    else {
                        self.texture = sprites.textureNamed("vida1_2")
                    }
                }
            }
            else {
                currentDirection = nil
            }
        }

//        if !directions.isEmpty && self.currentDirection != nil {
//            switch currentDirection! {
//            case .Left:
//                if tick % 20 < 10 {
//                    self.texture = sprites.textureNamed("vida3_1_left")
//                }
//                else {
//                    self.texture = sprites.textureNamed("vida3_2_left")
//                }
//            case .Right:
//                if tick % 20 < 10 {
//                    self.texture = sprites.textureNamed("vida3_1")
//                }
//                else {
//                    self.texture = sprites.textureNamed("vida3_2")
//                }
//            }
//        }
//        else {
//            currentDirection = nil
//        }
        
        
        tick += 1
        if tick > 60 {
            tick = 0
        }
    }
    
    //Animacion saltar
    func jump(){
        let jumpSound = SKAction.playSoundFileNamed("Jump.mp3", waitForCompletion: true)
        if self.physicsBody?.velocity.dy == 0 {
            run(jumpSound)
            self.physicsBody?.applyImpulse(CGVector(dx:0 ,dy: 500))
        }
        
    }
    
    //Perder vidas
    func loseLives(){
        lives -= 1
        
        if lives == 0{
            gameOver()
        }
    }
    
    //GameOver
    public func gameOver() {
        let gameOverScene = GameOverScene(fileNamed: "GameOver")
        let transition = SKTransition.fade(withDuration: 2)
        self.scene!.view?.presentScene(gameOverScene!, transition: transition)
    }
    
}
