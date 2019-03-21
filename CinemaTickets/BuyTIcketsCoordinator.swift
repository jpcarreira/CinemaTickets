import UIKit

/**
 In this demo there's just one scene (Buy Tickets) so this is the only coordinator we'll use
 However, in a real-world app, where we have more features (login, onboarding, etc...) we would use
 a different coordinator for each use-case, that way we ensure that the app's related functionality is
 restricted to it's own coordinator
 
 (for example, if the app had a login flow before getting into the buy tickets feature, the AppCoordinator
 would have the LoginCoordinator added as a child and, once the login was done, it would be removed from the
 AppCoordinator which would then add this one and have it started, as it is right now)
 
 This is also a nice way to manage dependencies, each coordinator only has the dependencies it needs. For example,
 a login flow might need the ApiType to communicate with the server so a LoginCoordinator would have that dependency
 injected, however as it doesn't need anything like storage or geolocation we can keep these services away from it
 and only inject them in the coordinators where we need them
 */
class BuyTicketsCoordinator: Coordinator {
    
    let rootViewController: UINavigationController
    let storyboard = UIStoryboard(name: "BuyTickets", bundle: Bundle.main)
    let api: ApiType
    let storage: StorageType
    
    var moviesViewModel: MoviesViewModelType {
        let moviesService = MoviesApiService(api: api)
        let moviesViewModel = MoviesViewModel(service: moviesService)
        moviesViewModel.coordinatorDelegate = self
        return moviesViewModel
    }
    
    init(rootViewController: UINavigationController, api: ApiType, storage: StorageType) {
        self.rootViewController = rootViewController
        self.api = api
        self.storage = storage
    }
    
    override func start() {
        guard let moviesViewController = storyboard.instantiateInitialViewController() as? MoviesTableViewController else {
            return
        }
        
        moviesViewController.viewModel = moviesViewModel
        rootViewController.setViewControllers([moviesViewController], animated: true)
    }
    
    override func finish() {
        rootViewController.popToRootViewController(animated: true)
    }
    
    // navigation
    private func goToShoppingCart() {
        if storage.numberOfCartItems == 0 {
            guard let emptyCartViewController = storyboard.instantiateViewController(withIdentifier: "EmptyCart") as? EmptyCartViewController else {
                return
            }
            
            let emptyCartViewModel = EmptyCartViewModel()
            emptyCartViewModel.coordinatorDelegate = self
            emptyCartViewController.viewModel = emptyCartViewModel
            let navigationController = UINavigationController(rootViewController: emptyCartViewController)
            rootViewController.present(navigationController, animated: true, completion: nil)
        } else {
            guard let cartViewController = storyboard.instantiateViewController(withIdentifier: "Cart") as? CartViewController else {
                return
            }
            
            let cartViewModel = CartViewModel(storage: storage)
            cartViewModel.coordinatorDelegate = self
            cartViewController.viewModel = cartViewModel
            let navigationController = UINavigationController(rootViewController: cartViewController)
            rootViewController.present(navigationController, animated: true, completion: nil)
        }
    }
    
    private func goToTicketOptions(movie: MovieViewDataType) {
        guard let ticketOptionsViewController = storyboard.instantiateViewController(withIdentifier: "TicketOptions") as? TicketOptionsViewController else {
            return
        }
        
        let ticketPricingService = TicketPricingApiService(api: api)
        let ticketOptionsViewModel = TicketOptionsViewModel(service: ticketPricingService, storage: storage, movie: movie)
        ticketOptionsViewModel.coordinatorDelegate = self
        ticketOptionsViewController.viewModel = ticketOptionsViewModel
        
        rootViewController.pushViewController(ticketOptionsViewController, animated: true)
    }
}


extension BuyTicketsCoordinator: MoviesViewModelCoordinatorDelegate {
    
    func didPressShoppingCart() {
        goToShoppingCart()
    }
    
    func didSelect(movie: MovieViewDataType) {
        goToTicketOptions(movie: movie)
    }
}


extension BuyTicketsCoordinator: TicketOptionsViewModelCoordinatorDelegate {
    
    func didPressAddToCartButton() {
        rootViewController.popViewController(animated: true)
    }
}


extension BuyTicketsCoordinator: EmptyCartViewModelCoordinatorDelegate {
    
    func didPressClose() {
        rootViewController.dismiss(animated: true, completion: nil)
    }
}


extension BuyTicketsCoordinator: CartViewModelCoordinatorDelegate {
    
    func didPressCloseCart() {
        rootViewController.dismiss(animated: true, completion: nil)
    }
}
