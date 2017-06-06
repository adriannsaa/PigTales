import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
    // including entities and graphs.
    override func viewDidLoad() {
        super.viewDidLoad()
        //let scene = GameScene(size: view.bounds.size)
        let mainThemScene = MainThemeScene()
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        //scene.scaleMode = .resizeFill
        mainThemScene.scaleMode = .resizeFill
        skView.presentScene(mainThemScene)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
