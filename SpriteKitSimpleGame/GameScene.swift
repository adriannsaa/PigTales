//
//  GameScene.swift
//  Pig Tales
//
//  Created by Adrian Nuñez Saa.
//  Copyright © 2017 Adrian Nuñez Saa. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // Touch location
    var targetLocation: CGPoint = .zero
    var pressedButtons = [SKSpriteNode]()
    
    // Scene Nodes
    var player: Player!
    var cam: SKCameraNode!
    var left_control,right_control,jump_control: SKSpriteNode!
    var fondo,finish,elefanteColec,monoColec,jirafaColec,pandaColec: SKSpriteNode!
    var vida1,vida2,vida3,vidaVacia1,vidaVacia2,vidaVacia3: SKSpriteNode!
    
    let friendsLabel = SKLabelNode(fontNamed: "Chalkduster")
    var ncoleccionables = 0
    var gameOver = false
    
    //Fisicas
    struct PhysicsCategory{
        static let PhysNone: UInt32 = 0
        static let PhysPlayer: UInt32 = 0b1 //1
        static let PhysFinish: UInt32 = 0b10 //2
        static let CatMono: UInt32 = 0b100 //4
        static let CatPanda: UInt32 = 0b1000 //8
        static let CatJirafa: UInt32 = 0b10000 //16
        static let CatElefante: UInt32 = 0b100000 //32
    }
    
    override func didMove(to view: SKView) {
        //Gravedad a cero
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        //Delegar los contactos en el engine
        physicsWorld.contactDelegate = self
        
        //Nodos
        loadSceneNodes()
        
        //Transparencia inicial de los controles
        left_control.alpha = 0.4
        right_control.alpha = 0.4
        jump_control.alpha = 0.4
        
        //Ponemos la gravedad normal después de cargar todo (Para que el personaje caiga)
        delay(seconds: 2.0){
            self.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        }
        
    }
    
    //Creacion de todos los nodos para luego cargarlos todos juntos
    func loadSceneNodes() {
        //LEVEL
        guard let fondo = childNode(withName: "FondoRectangulo")
            as? SKSpriteNode else {
                fatalError("Fondo node not loaded")
        }
        self.fondo = fondo
        //Fisica del fondo (Límites del mapa)
        let fondoPath = CGMutablePath()
        fondoPath.move(to: CGPoint(x: -fondo.size.width/2, y: -fondo.size.height/2))
        fondoPath.addLine(to: CGPoint(x: fondo.size.width/2, y: -fondo.size.height/2))
        fondoPath.addLine(to: CGPoint(x: fondo.size.width/2, y: fondo.size.height/2))
        fondoPath.addLine(to: CGPoint(x: -fondo.size.width/2, y: fondo.size.height/2))
        fondoPath.addLine(to: CGPoint(x: -fondo.size.width/2, y: -fondo.size.height/2))
        fondo.physicsBody = SKPhysicsBody(edgeLoopFrom: fondoPath)
        fondo.physicsBody?.isDynamic = false
        
        //Meta
        guard let finish = childNode(withName: "FinishSign")
            as? SKSpriteNode else {
                fatalError("Finish node not loaded")
        }
        self.finish = finish
        finish.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: finish.size.width/2,
                                                               height: finish.size.height/2))
        finish.physicsBody?.isDynamic = false
        finish.physicsBody?.usesPreciseCollisionDetection = true
        finish.physicsBody?.categoryBitMask = PhysicsCategory.PhysFinish
        finish.physicsBody?.contactTestBitMask = PhysicsCategory.PhysPlayer
        
        //Coleccionables
        guard let elefanteColec = childNode(withName: "elefante")
            as? SKSpriteNode else {
                fatalError("Elefante node not loaded")
        }
        self.elefanteColec = elefanteColec
        elefanteColec.physicsBody = SKPhysicsBody(circleOfRadius: elefanteColec.size.width/2)
        elefanteColec.physicsBody?.isDynamic = false
        elefanteColec.physicsBody?.usesPreciseCollisionDetection = true
        elefanteColec.physicsBody?.categoryBitMask = PhysicsCategory.CatElefante
        elefanteColec.physicsBody?.contactTestBitMask = PhysicsCategory.PhysPlayer
        
        guard let monoColec = childNode(withName: "mono")
            as? SKSpriteNode else {
                fatalError("Mono node not loaded")
        }
        self.monoColec = monoColec
        monoColec.physicsBody = SKPhysicsBody(circleOfRadius: monoColec.size.width/2)
        monoColec.physicsBody?.isDynamic = false
        monoColec.physicsBody?.usesPreciseCollisionDetection = true
        monoColec.physicsBody?.categoryBitMask = PhysicsCategory.CatMono
        monoColec.physicsBody?.contactTestBitMask = PhysicsCategory.PhysPlayer
        
        guard let jirafaColec = childNode(withName: "jirafa")
            as? SKSpriteNode else {
                fatalError("Jirafa node not loaded")
        }
        self.jirafaColec = jirafaColec
        jirafaColec.physicsBody = SKPhysicsBody(circleOfRadius: jirafaColec.size.width/2)
        jirafaColec.physicsBody?.isDynamic = false
        jirafaColec.physicsBody?.usesPreciseCollisionDetection = true
        jirafaColec.physicsBody?.categoryBitMask = PhysicsCategory.CatJirafa
        jirafaColec.physicsBody?.contactTestBitMask = PhysicsCategory.PhysPlayer
        
        guard let pandaColec = childNode(withName: "panda")
            as? SKSpriteNode else {
                fatalError("Panda node not loaded")
        }
        self.pandaColec = pandaColec
        pandaColec.physicsBody = SKPhysicsBody(circleOfRadius: pandaColec.size.width/2)
        pandaColec.physicsBody?.isDynamic = false
        pandaColec.physicsBody?.usesPreciseCollisionDetection = true
        pandaColec.physicsBody?.categoryBitMask = PhysicsCategory.CatPanda
        pandaColec.physicsBody?.contactTestBitMask = PhysicsCategory.PhysPlayer

        //Vidas
        guard let vida1 = childNode(withName: "corazonLleno1")
            as? SKSpriteNode else {
                fatalError("vida1 node not loaded")
        }
        self.vida1 = vida1
        guard let vida2 = childNode(withName: "corazonLleno2")
            as? SKSpriteNode else {
                fatalError("vida2 node not loaded")
        }
        self.vida2 = vida2
        guard let vida3 = childNode(withName: "corazonLleno3")
            as? SKSpriteNode else {
                fatalError("vida3 node not loaded")
        }
        self.vida3 = vida3
        
        guard let vidaVacia1 = childNode(withName: "corazonVacio_1")
            as? SKSpriteNode else {
                fatalError("vidaVacia1 node not loaded")
        }
        self.vidaVacia1 = vidaVacia1
        vidaVacia1.isHidden = true
        guard let vidaVacia2 = childNode(withName: "corazonVacio_2")
            as? SKSpriteNode else {
                fatalError("vidaVacia2 node not loaded")
        }
        self.vidaVacia2 = vidaVacia2
        vidaVacia2.isHidden = true
        guard let vidaVacia3 = childNode(withName: "corazonVacio_3")
            as? SKSpriteNode else {
                fatalError("vidaVacia3 node not loaded")
        }
        self.vidaVacia3 = vidaVacia3
        vidaVacia3.isHidden = true
        
        //Contador coleccionables
        friendsLabel.zPosition = 1
        self.addChild(friendsLabel)
        
        //JUGADOR
        player = Player(named: "vida3_1")
        player.position = CGPoint(x: -1800, y: -300)
        self.addChild(player)
        //Jugador contact-collision
        player.physicsBody?.usesPreciseCollisionDetection = true
        player.physicsBody?.categoryBitMask = PhysicsCategory.PhysPlayer
        player.physicsBody?.contactTestBitMask = PhysicsCategory.PhysFinish | PhysicsCategory.CatPanda | PhysicsCategory.CatElefante | PhysicsCategory.CatJirafa | PhysicsCategory.CatMono

        //CAMARA
        guard let cam = childNode(withName: "camera1")
            as? SKCameraNode else {
                fatalError("Camera node not loaded")
        }
        self.camera = cam

        //CONTROLES
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
        
        //SONIDO
        let backgroundMusic = SKAudioNode(fileNamed: "Bosque.mp3")
        backgroundMusic.autoplayLooped = true
        addChild(backgroundMusic)
        
    }

    //Realiza cualquier actualizacion que deba ocurrir antes de evaluar las acciones de la escena (Se realiza en cada frame
    override func update(_ currentTime: TimeInterval) {
        
        //Posicion de la camara (Un poco adelantada para ver el mapa)
        camera?.position = CGPoint(x:player.position.x+50 , y:player.position.y+30)
        
        //Posicion de los controles
        left_control.position = CGPoint(x:player.position.x-200 , y:player.position.y-110)
        right_control.position = CGPoint(x:player.position.x-40 , y:player.position.y-110)
        jump_control.position = CGPoint(x:player.position.x+275 , y:player.position.y-110)
        
        //Contador amigos
        friendsLabel.position = CGPoint(x:player.position.x-140 , y:player.position.y+175)
        friendsLabel.text = "Friends: \(ncoleccionables)/4"
        
        //Posicion de las vidas
        vida1.position = CGPoint(x:player.position.x+250 , y:player.position.y+190)
        vida2.position = CGPoint(x:player.position.x+285 , y:player.position.y+190)
        vida3.position = CGPoint(x:player.position.x+320 , y:player.position.y+190)
        vidaVacia1.position = CGPoint(x:player.position.x+250 , y:player.position.y+190)
        vidaVacia2.position = CGPoint(x:player.position.x+285 , y:player.position.y+190)
        vidaVacia3.position = CGPoint(x:player.position.x+320 , y:player.position.y+190)
        
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
        
        //Comprobación daños a jugador
        //Caer
        if player.position.y < -450{
            if player.lives == 3{
                player.texture = SKTexture(imageNamed: "vida2_3")
            }
            if player.lives == 2{
                player.texture = SKTexture(imageNamed: "vida1_3")
            }
            if player.lives == 1{
                player.texture = SKTexture(imageNamed: "vida1_3")
            }
            player.loseLives()
            print("CAE")
            if player.lives == 2{
                vida3.isHidden = true
                vidaVacia3.isHidden = false
            }
            if player.lives == 1{
                vida2.isHidden = true
                vidaVacia2.isHidden = false
            }
            if player.lives == 0{
                vida1.isHidden = true
                vidaVacia1.isHidden = false
            }
            
            player.physicsBody?.applyImpulse(CGVector(dx:-200 ,dy: 200))
            player.position = CGPoint(x: -1800, y: -300)


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
    
    //Fisicas Collision&Contact
    func didBegin(_ contact: SKPhysicsContact) {
        //Meta
        let collisionMeta = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if collisionMeta == PhysicsCategory.PhysPlayer | PhysicsCategory.PhysFinish{
            if ncoleccionables == 4{
                let winSound = SKAction.playSoundFileNamed("Win.mp3", waitForCompletion: true)
                run(winSound)
                print("META_WIN")
            }else{
                let errorSound = SKAction.playSoundFileNamed("Error.mp3", waitForCompletion: true)
                run(errorSound)
                print("META_ERROR")
            }

        }
        
        //Coleccionables
        let collisionColec = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if collisionColec == PhysicsCategory.PhysPlayer | PhysicsCategory.CatPanda{
            let colectSound = SKAction.playSoundFileNamed("Coleccionable.mp3", waitForCompletion: true)
            run(colectSound)
            ncoleccionables += 1
            monoColec.removeFromParent()
            print("MONO")
        }
        if collisionColec == PhysicsCategory.PhysPlayer | PhysicsCategory.CatJirafa{
            let colectSound = SKAction.playSoundFileNamed("Coleccionable.mp3", waitForCompletion: true)
            run(colectSound)
            ncoleccionables += 1
            jirafaColec.removeFromParent()
            print("JIRAFA")
        }
        if collisionColec == PhysicsCategory.PhysPlayer | PhysicsCategory.CatElefante{
            let colectSound = SKAction.playSoundFileNamed("Coleccionable.mp3", waitForCompletion: true)
            run(colectSound)
            ncoleccionables += 1
            elefanteColec.removeFromParent()
            print("ELEFANTE")
        }
        if collisionColec == PhysicsCategory.PhysPlayer | PhysicsCategory.CatMono{
            let colectSound = SKAction.playSoundFileNamed("Coleccionable.mp3", waitForCompletion: true)
            run(colectSound)
            ncoleccionables += 1
            monoColec.removeFromParent()
            print("MONO")
        }
    }

}
