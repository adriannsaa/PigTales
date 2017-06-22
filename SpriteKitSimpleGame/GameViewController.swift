import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
    // including entities and graphs.
    override func viewDidLoad() {
        super.viewDidLoad()
        let mainThemScene = MainThemeScene()
        let skView = view as! SKView
        skView.ignoresSiblingOrder = true
        mainThemScene.scaleMode = .resizeFill
        skView.presentScene(mainThemScene)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
