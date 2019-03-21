import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // when using an AppCoordinator, application:didFinishLaunchingWithOptions should be as simple as this, any additional setup
        // should be placed in the AppCoordinator or, if it's a setup more specific of a given flow, that should go the the respective
        // child coordinator
        window = UIWindow(frame: UIScreen.main.bounds)
        appCoordinator = AppCoordinator(window: window)
        appCoordinator.start()
        
        return true
    }
}
