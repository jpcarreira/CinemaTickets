import UIKit


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
            // TODO: show cart
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
