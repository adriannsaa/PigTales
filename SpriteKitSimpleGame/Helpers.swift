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
public func terreno_1() -> SKSpriteNode{
    let terrenoJunto1 = SKSpriteNode()
    terrenoJunto1.name = "terrenoJunto1"
    
    let tierra1 = SKSpriteNode(imageNamed: "terreno15")
    tierra1.position = CGPoint(x: -1188.253, y:-62.587)
    terrenoJunto1.addChild(tierra1)
    
    let tierra2 = SKSpriteNode(imageNamed: "terreno18")
    tierra2.position = CGPoint(x: -1060.252, y:-62.587)
    terrenoJunto1.addChild(tierra2)
    
    let tierra3 = SKSpriteNode(imageNamed: "terreno19")
    tierra3.position = CGPoint(x: -932.253, y:-62.587)
    terrenoJunto1.addChild(tierra3)
    
    terrenoJunto1.size = CGSize(width: tierra1.size.width+tierra2.size.width+tierra3.size.width,
                                height: tierra1.size.height)
    
    terrenoJunto1.anchorPoint = CGPoint(x:0 , y:0)
    terrenoJunto1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: terrenoJunto1.size.width,
                                                                  height: terrenoJunto1.size.height))
    
    return terrenoJunto1
}
