import UIKit


class BuyTicketsCoordinator: Coordinator {
    
    let rootViewController: UINavigationController
    let storyboard = UIStoryboard(name: "BuyTickets", bundle: Bundle.main)
    let api: ApiType
    
    // TODO: add reference to the view model and set it up as a computed var
    
    init(rootViewController: UINavigationController, api: ApiType) {
        self.rootViewController = rootViewController
        self.api = api
    }
    
    override func start() {
        guard let moviesViewController = storyboard.instantiateInitialViewController() as? MoviesTableViewController else {
            return
        }
        
        // TODO: set the viewmodel
        rootViewController.setViewControllers([moviesViewController], animated: true)
    }
    
    override func finish() {
        rootViewController.popToRootViewController(animated: true)
    }
}
