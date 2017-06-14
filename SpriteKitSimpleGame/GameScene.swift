import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // Touch location
    var targetLocation: CGPoint = .zero
    var pressedButtons = [SKSpriteNode]()
    
    // Scene Nodes
    var player: Player!
    //var controls: GameControls!
    var level1Background: SKTileMapNode!
    var level1Coleccionable: SKTileMapNode!
    var level1Signals: SKTileMapNode!
    var cam: SKCameraNode!
    var left_control,right_control,jump_control: SKSpriteNode!
    
    //Fisicas
    enum CollisionTypes: UInt32 {
        case physPlayer = 1
        case physWall = 2
        case physTerrain = 4
        case physWater = 8
        case physFinish = 16
    }
    
    override func didMove(to view: SKView) {
        loadSceneNodes()
        
        //Transparencia inicial de los controles
        left_control.alpha = 0.4
        right_control.alpha = 0.4
        jump_control.alpha = 0.4
        
        //Fisicas
//        player.physicsBody?.categoryBitMask = CollisionTypes.physPlayer.rawValue
//        player.physicsBody?.contactTestBitMask = CollisionTypes.physTerrain.rawValue
//        player.physicsBody?.collisionBitMask = CollisionTypes.physTerrain.rawValue
//        player.physicsBody?.friction = 0
//        player.physicsBody?.isDynamic = true
//        
//        self.physicsWorld.contactDelegate = self
//        self.physicsBody = SKPhysicsBody(circleOfRadius: max(self.size.width / 2,
//                                                               self.size.height / 2))
//        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
//        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
    }
    
    //Creacion de todos los nodos para luego cargarlos todos juntos
    func loadSceneNodes() {

        //Level
        guard let level1Background = childNode(withName: "level1")
            as? SKTileMapNode else {
                fatalError("Background node not loaded")
        }
        self.level1Background = level1Background
//        self.physicsBody = SKPhysicsBody(rectangleOf: level1Background.mapSize, center: level1Background.centerOfTile(atColumn: 12, row: 4))
        
        guard let level1Coleccionable = childNode(withName: "coleccionables")
            as? SKTileMapNode else {
                fatalError("Coleccionables node not loaded")
        }
        self.level1Coleccionable = level1Coleccionable
        
        guard let level1Signals = childNode(withName: "decorado1")
            as? SKTileMapNode else {
                fatalError("Señales node not loaded")
        }
        self.level1Signals = level1Signals

        
        //Jugador
        player = Player(named: "vida3_1")
        player.position = CGPoint(x: -1340, y: -265)
        self.addChild(player)
//        player.physicsBody = SKPhysicsBody(circleOfRadius: max(player.size.width / 2,
//                                                                          player.size.height / 2))
//        player.physicsBody?.affectedByGravity=false

        //Camara
        guard let cam = childNode(withName: "camera1")
            as? SKCameraNode else {
                fatalError("Camera node not loaded")
        }
        self.camera = cam

        //Controles
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
        
        //Sonido
        let backgroundMusic = SKAudioNode(fileNamed: "Bosque.mp3")
        backgroundMusic.autoplayLooped = true
        addChild(backgroundMusic)
        
    }

    //Realiza cualquier actualizacion que deba ocurrir antes de evaluar las acciones de la escena (Se realiza en cada frame
    override func update(_ currentTime: TimeInterval) {
        
        //Posicion de la camara (Un poco adelantada para ver el mapa)
        camera?.position = CGPoint(x:player.position.x+75 , y:player.position.y+75)
        
        //Posicion de los controles
        left_control.position = CGPoint(x:player.position.x-340 , y:player.position.y-150)
        right_control.position = CGPoint(x:player.position.x-140 , y:player.position.y-150)
        jump_control.position = CGPoint(x:player.position.x+475 , y:player.position.y-150)
        
        //Movimiento del jugador
        if pressedButtons.index(of: left_control) != nil {
            player.walk(directions: [.Left])
        }
        if pressedButtons.index(of: right_control) != nil {
            player.walk(directions: [.Right])
        }
        if pressedButtons.index(of: jump_control) != nil {
            player.jump()
        }
        
        //Controlar las posiciones,extraer el "tile" del mapa y controlar sus fisicas
        let positionPlayer = player.position
        let column = level1Background.tileColumnIndex(fromPosition: positionPlayer)
        let row = level1Background.tileRowIndex(fromPosition: positionPlayer)
        let columnColect = level1Coleccionable.tileColumnIndex(fromPosition: positionPlayer)
        let rowColect = level1Coleccionable.tileRowIndex(fromPosition: positionPlayer)
        let tile = level1Background.tileDefinition(atColumn: column, row: row)
        let tileColect = level1Coleccionable.tileDefinition(atColumn: columnColect, row: rowColect)
        let tileSize = tile?.size

        let isTerrain = tile?.userData?.value(forKey: "isTerrain")
        let isElefante = tileColect?.userData?.value(forKey: "isElefante")
        let isJirafa = tileColect?.userData?.value(forKey: "isJirafa")
        let isMono = tileColect?.userData?.value(forKey: "isMono")
        let isPanda = tileColect?.userData?.value(forKey: "isPanda")
        
        
        for col in 0..<level1Background.numberOfColumns {
            
            for row in 0..<level1Background.numberOfRows {
                if isTerrain as? Bool == true{
                    print("terreno")
                }                
                if positionPlayer == level1Background.centerOfTile(atColumn: 4, row: 8){
                    print("PANDA")
                }
                if positionPlayer == level1Background.centerOfTile(atColumn: 13, row: 3){
                    print("ELEFANTE")
                }
                if positionPlayer == level1Background.centerOfTile(atColumn: 20, row: 8){
                    print("MONO")
                }
                if positionPlayer == level1Background.centerOfTile(atColumn: 18, row: 3){
                    print("JIRAFA")
                }
                if positionPlayer == level1Background.centerOfTile(atColumn: 2, row: 3){
                    print("!!!!! START !!!!!!!")
                }
                if positionPlayer == level1Background.centerOfTile(atColumn: 2, row: 3){
                    print("!!!!! START !!!!!!!")
                }

            }
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
