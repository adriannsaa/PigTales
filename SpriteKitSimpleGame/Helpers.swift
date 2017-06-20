//
//  Helpers.swift
//  Pig Tales
//
//  Created by Adrian Nuñez Saa.
//  Copyright © 2017 Adrian Nuñez Saa. All rights reserved.
//

import UIKit
import SpriteKit

public func delay (seconds: TimeInterval, completion: @escaping()->Void){
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
}

// ********   LEVEL1   ********* //
//        //Comprobacion cruzar fisicas
//        if ((player.physicsBody?.velocity.dy)! < CGFloat(0.0)) {
//            terreno1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: terreno1.size.width, height: 0.01))
//            terreno1.physicsBody?.isDynamic = false
//            terreno2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: terreno1.size.width, height: 0.01))
//            terreno2.physicsBody?.isDynamic = false
//            terreno3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: terreno1.size.width, height: 0.01))
//            terreno3.physicsBody?.isDynamic = false
//        }else{
//            terreno1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: terreno1.size.width, height: 0))
//            terreno1.physicsBody?.isDynamic = false
//            terreno2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: terreno1.size.width, height: 0))
//            terreno2.physicsBody?.isDynamic = false
//            terreno3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: terreno1.size.width, height: 0))
//            terreno3.physicsBody?.isDynamic = false
//        }
