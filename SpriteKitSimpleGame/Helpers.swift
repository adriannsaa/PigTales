//
//  Helpers.swift
//  SpriteKitSimpleGame
//
//  Created by Adrian Nuñez Saa on 15/6/17.
//  Copyright © 2017 Adrian Nuñez Saa. All rights reserved.
//

import UIKit

public func delay (seconds: TimeInterval, completion: @escaping()->Void){
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
    }
