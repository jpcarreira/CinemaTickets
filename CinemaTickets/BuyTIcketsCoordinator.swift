import UIKit


class BuyTicketsCoordinator: Coordinator {
    
    let rootViewController: UINavigationController
    let storyboard = UIStoryboard(name: "BuyTickets", bundle: Bundle.main)
    let api: ApiType
    
    var moviesViewModel: MoviesViewModelType {
        let moviesService = MoviesApiService(api: api)
        let moviesViewModel = MoviesViewModel(service: moviesService)
        moviesViewModel.coordinatorDelegate = self
        return moviesViewModel
    }
    
    init(rootViewController: UINavigationController, api: ApiType) {
        self.rootViewController = rootViewController
        self.api = api
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
        // TODO:
    }
    
    private func goToTicketOpions(movie: MovieViewDataType) {
        guard let ticketOptionsViewController = storyboard.instantiateViewController(withIdentifier: "TicketOptions") as? TicketOptionsViewController else {
            return
        }
        
        let ticketOptionsViewModel = TicketOptionsViewModel(movie: movie)
        ticketOptionsViewController.viewModel = ticketOptionsViewModel
        
        rootViewController.pushViewController(ticketOptionsViewController, animated: true)
    }
}


extension BuyTicketsCoordinator: MoviesViewModelCoordinatorDelegate {
    
    func didPressShoppingCart() {
        // TODO:
    }
    
    func didSelect(movie: MovieViewDataType) {
        goToTicketOpions(movie: movie)
    }
}
