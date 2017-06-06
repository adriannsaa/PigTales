import SpriteKit

//class GameScene: SKScene {
//    
//    // 1
//    let player = SKSpriteNode(imageNamed: "player")
//    
//    override func didMove(to view: SKView) {
//        // 2
//        backgroundColor = SKColor.white
//        // 3
//        player.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
//        // 4
//        addChild(player)
//        
//        //Ejecutar en secuencia la creacion de monstruos para que aparezcan continuamente (Creados en addMonster())
//        run(SKAction.repeatForever(
//            SKAction.sequence([
//                SKAction.run(addMonster),
//                SKAction.wait(forDuration: 1.0)
//                ])
//        ))
//    }
//    
//    //Funciones random para calcular el tiempo de aparacion o posicion.
//    func random() -> CGFloat {
//        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
//    }
//    
//    func random(min: CGFloat, max: CGFloat) -> CGFloat {
//        return random() * (max - min) + min
//    }
//    
//    func addMonster() {
//        
//        // Create sprite
//        let monster = SKSpriteNode(imageNamed: "monster")
//        
//        // Determine where to spawn the monster along the Y axis
//        let actualY = random(min: monster.size.height/2, max: size.height - monster.size.height/2)
//        
//        // Position the monster slightly off-screen along the right edge,
//        // and along a random position along the Y axis as calculated above
//        monster.position = CGPoint(x: size.width + monster.size.width/2, y: actualY)
//        
//        // Add the monster to the scene
//        addChild(monster)
//        
//        // Determine speed of the monster
//        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
//        
//        // Create the actions
//        let actionMove = SKAction.move(to: CGPoint(x: -monster.size.width/2, y: actualY), duration: TimeInterval(actualDuration))
//        let actionMoveDone = SKAction.removeFromParent()
//        monster.run(SKAction.sequence([actionMove, actionMoveDone]))
//        
//    }
//}
//
//
//
//
//
//class GameScene: SKScene {
//    
//    // constants
//    let waterMaxSpeed: CGFloat = 200
//    let landMaxSpeed: CGFloat = 4000
//    
//    // if within threshold range of the target, car begins slowing
//    let targetThreshold:CGFloat = 200
//    
//    var maxSpeed: CGFloat = 0
//    var acceleration: CGFloat = 0
//    
//    // touch location
//    var targetLocation: CGPoint = .zero
//    
//    // Scene Nodes
//    var car:SKSpriteNode!
//    
//    override func didMove(to view: SKView) {
//        loadSceneNodes()
//        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
//        maxSpeed = landMaxSpeed
//    }
//    
//    func loadSceneNodes() {
//        guard let car = childNode(withName: "car") as? SKSpriteNode else {
//            fatalError("Sprite Nodes not loaded")
//        }
//        self.car = car
//    }
//    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first else { return }
//        targetLocation = touch.location(in: self)
//    }
//    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first else { return }
//        targetLocation = touch.location(in: self)
//    }
//    
//    
//    override func update(_ currentTime: TimeInterval) {
//    }
//    
//    override func didSimulatePhysics() {
//        
//        let offset = CGPoint(x: targetLocation.x - car.position.x,
//                             y: targetLocation.y - car.position.y)
//        let distance = sqrt(offset.x * offset.x + offset.y * offset.y)
//        let carDirection = CGPoint(x:offset.x / distance,
//                                   y:offset.y / distance)
//        let carVelocity = CGPoint(x: carDirection.x * acceleration,
//                                  y: carDirection.y * acceleration)
//        
//        car.physicsBody?.velocity = CGVector(dx: carVelocity.x, dy: carVelocity.y)
//        
//        if acceleration > 5 {
//            car.zRotation = atan2(carVelocity.y, carVelocity.x)
//        }
//        
//        // update acceleration
//        // car speeds up to maximum
//        // if within threshold range of the target, car begins slowing
//        // if maxSpeed has reduced due to different tiles,
//        // may need to decelerate slowly to the new maxSpeed
//        
//        if distance < targetThreshold {
//            let delta = targetThreshold - distance
//            acceleration = acceleration * ((targetThreshold - delta)/targetThreshold)
//            if acceleration < 2 {
//                acceleration = 0
//            }
//        } else {
//            if acceleration > maxSpeed {
//                acceleration -= min(acceleration - maxSpeed, 80)
//            }
//            if acceleration < maxSpeed {
//                acceleration += min(maxSpeed - acceleration, 40)
//            }
//        }
//        
//    }
//}









class GameScene: SKScene {
    
    // Touch location
    var targetLocation: CGPoint = .zero
    var pressedButtons = [SKSpriteNode]()
    
    // Scene Nodes
    var player: SKSpriteNode!
    var level1Background: SKTileMapNode!
    var cam: SKCameraNode!
    var left_control,right_control,jump_control: SKSpriteNode!

    override func didMove(to view: SKView) {
        loadSceneNodes()
        player.position = CGPoint(x: -1373.998, y: -239.514)
    }
    
    //Creacion de todos los nodos para luego cargarlos todos juntos
    func loadSceneNodes() {

        guard let level1Background = childNode(withName: "level1")
            as? SKTileMapNode else {
                fatalError("Background node not loaded")
        }
        self.level1Background = level1Background
        
        guard let player = childNode(withName: "player")
            as? SKSpriteNode else {
                fatalError("Player node not loaded")
        }
        self.player = player
       // self.player.physicsBody = SKPhysicsBody(circleOfRadius: max(player.size.width / 2,
        //                                                            player.size.height / 2))

        guard let cam = childNode(withName: "camera1")
            as? SKCameraNode else {
                fatalError("Camera node not loaded")
        }
        self.camera = cam
        
        guard let left_control = childNode(withName: "left_control")
            as? SKSpriteNode else {
                fatalError("Left control node not loaded")
        }
        self.left_control = left_control
        
        guard let right_control = childNode(withName: "right_control")
            as? SKSpriteNode else {
                fatalError("Right control node not loaded")
        }
        self.right_control = right_control
        
        guard let jump_control = childNode(withName: "jump_control")
            as? SKSpriteNode else {
                fatalError("Jump control node not loaded")
        }
        self.jump_control = jump_control
        
    }

    //Realiza cualquier actualizacion que deba ocurrir antes de evaluar las acciones de la escena (Se realiza en cada frame
    override func update(_ currentTime: TimeInterval) {
        
        //Controlar las posiciones y extraer el "tile" del mapa
        let position = player.position
        let column = level1Background.tileColumnIndex(fromPosition: position)
        let row = level1Background.tileRowIndex(fromPosition: position)
        let tile = level1Background.tileDefinition(atColumn: column, row: row)
        
        //Posicion de la camara (Un poco adelantada para ver el mapa)
        camera?.position = CGPoint(x:player.position.x+75 , y:player.position.y+75)
        
        //Posicion de los controles
        left_control.position = CGPoint(x:player.position.x-140 , y:player.position.y-80)
        left_control.alpha = 0.2
        right_control.position = CGPoint(x:player.position.x-40 , y:player.position.y-80)
        right_control.alpha = 0.2
        jump_control.position = CGPoint(x:player.position.x+325 , y:player.position.y-80)
        
        //Movimiento del jugador
        if pressedButtons.index(of: left_control) != nil {
            player.position.x -= 2.0
        }
        if pressedButtons.index(of: right_control) != nil {
            player.position.x += 2.0
        }
        if pressedButtons.index(of: jump_control) != nil {
            player.position.y += 4.0
        }
        
    }
    
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
                button?.alpha = 0.9
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
                button?.alpha = 0.9
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
                button?.alpha = 0.9
            }
        }
    }
    
    
    
    
    
}
