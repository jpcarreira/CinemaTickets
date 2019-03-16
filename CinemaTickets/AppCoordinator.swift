/**
 Main Coordinator object, needs to be owned by the AppDelegate
 */
import UIKit


class AppCoordinator: Coordinator {
    
    let window: UIWindow?
    
    lazy var rootViewController: UINavigationController = {
        return UINavigationController(rootViewController: UIViewController())
    }()
    
    lazy var buyTicketsCoordinator: BuyTicketsCoordinator = {
        let buyTicketsCoordinator = BuyTicketsCoordinator(rootViewController: rootViewController, api: api)
        addChildCoordinator(buyTicketsCoordinator)
        return buyTicketsCoordinator
    }()
    
    // with the AppCoordinator not knowing which concrete type is being used, we can easily replace the ApiType for
    // anything conforming to the ApiType protocol
    let api: ApiType = {
        // for the sake of this demo we just return the MockApi, meaning the entire app will always use fake requests
        // everwhere. However, here we could check for any arg passed in during the lunch, meaning we can easily make
        // a setup with different schemes, each with a different arg (e.g., we could always return the Api() object
        // unless we had an arg like "-mockApi")
        return MockApi()
    }()
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    override func start() {
        guard let window = window else {
            return
        }
        
        buyTicketsCoordinator.start()
        
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    
    override func finish() {
        // intentionally left blank
    }
}
