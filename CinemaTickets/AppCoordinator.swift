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
        let buyTicketsCoordinator = BuyTicketsCoordinator(rootViewController: rootViewController, api: api, storage: storage)
        addChildCoordinator(buyTicketsCoordinator)
        return buyTicketsCoordinator
    }()
    
    // with the AppCoordinator not knowing which concrete type is being used, we can easily replace the ApiType for
    // anything conforming to the ApiType protocol
    let api: ApiType = {
        // for the sake of this demo we just return the MockApi, meaning the entire app will always use fake requests
        // everywhere. However, here we could check for any arg passed in during the lunch, meaning we can easily make
        // a setup with different schemes, each with a different arg (e.g., we could always return the Api() object
        // unless we had an arg like "-mockApi")
        return MockApi()
    }()
    
    // what was said above to the ApiType also applies to the storage object,
    // here we'll just use a simple in-memory array but we could easily replace
    // for another storage mechanism
    let storage: StorageType = {
        return InMemoryStorage()
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
