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

//PAUSE
//if pause_control.contains(location) && estaPausado == true {
//    estaPausado = false
//    self.scene?.view?.isPaused = false
//}
//if pause_control.contains(location) && estaPausado == false {
//    estaPausado = true
//    self.scene?.view?.isPaused = true
//}

