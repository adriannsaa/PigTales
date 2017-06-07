//
//  GameControls.swift
//  SpriteKitSimpleGame
//
//  Created by Adrian Nuñez Saa on 7/6/17.
//  Copyright © 2017 Adrian Nuñez Saa. All rights reserved.
//

import SpriteKit

class GameControls: SKNode {
    
    //Touch Location
    var targetLocation: CGPoint = .zero
    var pressedButtons = [SKSpriteNode]()
    
    //Nodes
    var left_control,right_control,jump_control: SKSpriteNode!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(position: CGPoint) {
        self.init()
        self.position = position
    }
    
    override init() {
        super.init()
        
        self.isUserInteractionEnabled = true // Poder defecto los "touches" están desactivados
        self.zPosition = 500 // Los controles se vean siempre arriba (Capa superior)
        
        //Fijamos la transparencia de los botones al inicio
        left_control.alpha = 0.4
        right_control.alpha = 0.4
        jump_control.alpha = 0.4
        
    }
    
//    //Movimiento del jugador
//    func movementPlayer(player: Player){
//        if pressedButtons.index(of: left_control) != nil {
//            player.walk(directions: [.Left])
//        }
//        if pressedButtons.index(of: right_control) != nil {
//            player.walk(directions: [.Right])
//        }
//        if pressedButtons.index(of: jump_control) != nil {
//            player.jump()
//        }
//    }

    
//    func loadGameControlsNodes(){
//        guard let left_control = childNode(withName: "left_control")
//            as? SKSpriteNode else {
//                fatalError("Left control node not loaded")
//        }
//        self.left_control = left_control
//        
//        guard let right_control = childNode(withName: "right_control")
//            as? SKSpriteNode else {
//                fatalError("Right control node not loaded")
//        }
//        self.right_control = right_control
//        
//        guard let jump_control = childNode(withName: "jump_control")
//            as? SKSpriteNode else {
//                fatalError("Jump control node not loaded")
//        }
//        self.jump_control = jump_control
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Para cada vez que toquemos la pantalla
        for touch: AnyObject in touches {
            //Recoger la posicion de donde tocamos
            let location = touch.location(in: self)
            
            //Comprobar si se pulsan varios botones a la vez se meten en un array (comprobando si ya están)
            for button in [left_control, right_control, jump_control] {
                if (button?.contains(location))! && pressedButtons.index(of: button!) == nil {
                    pressedButtons.append(button!)
                }
            }
            
        }
        
        //Comprobamos los botones y le cambiamos la transparencia si están pulsados
        for button in [left_control, right_control, jump_control] {
            if pressedButtons.index(of: button!) == nil {
                button?.alpha = 0.4
            }
            else {
                button?.alpha = 0.8
            }
        }
    }
    
    //Funcion para cuando tenemos pulsado un nodo y nos movemos sin dejar de pulsar
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //Si nos movemos del boton pulsado lo sacamos de la lista, si es al revés lo añadimos
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            let previousLocation = touch.previousLocation(in: self)
            
            for button in [left_control, right_control, jump_control] {
                //Donde teniamos el dedo antes y lo cambiamos de posicion
                if (button?.contains(previousLocation))!
                    && !(button?.contains(location))! {
                    //Lo sacamos de la lista
                    let index = pressedButtons.index(of: button!)
                    if index != nil {
                        pressedButtons.remove(at: index!)
                    }
                }
                    //Movemos el dedo para otro boton que no esté en la lista
                else if (button?.contains(previousLocation))!
                    && (button?.contains(location))!
                    && pressedButtons.index(of: button!) == nil {
                    //Se añade
                    pressedButtons.append(button!)
                }
            }
        }
        
        //Actualizamos la transparencia de los botones
        for button in [left_control, right_control, jump_control] {
            if pressedButtons.index(of: button!) == nil {
                button?.alpha = 0.4
            }
            else {
                button?.alpha = 0.8
            }
        }
    }
    
    //Dejamos de pulsar
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesEndedOrCancelled(touches: touches, withEvent: event)
    }
    //Cuando se cancela un "touch" por alguna alerta o evento
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesEndedOrCancelled(touches: touches, withEvent: event)
    }
    
    //Para no repetir el mismo código
    func touchesEndedOrCancelled(touches: Set<NSObject>?, withEvent event: UIEvent?){
        
        for touch: AnyObject in touches! {
            let location = touch.location(in: self)
            let previousLocation = touch.previousLocation(in: self)
            
            for button in [left_control, right_control, jump_control] {
                if (button?.contains(location))! {
                    let index = pressedButtons.index(of: button!)
                    if index != nil {
                        pressedButtons.remove(at: index!)
                    }
                }
                else if (button?.contains(previousLocation))! {
                    let index = pressedButtons.index(of: button!)
                    if index != nil {
                        pressedButtons.remove(at: index!)
                    }
                }
            }
        }
        for button in [left_control, right_control, jump_control] {
            if pressedButtons.index(of: button!) == nil {
                button?.alpha = 0.4
            }
            else {
                button?.alpha = 0.8
            }
        }
    }

}
