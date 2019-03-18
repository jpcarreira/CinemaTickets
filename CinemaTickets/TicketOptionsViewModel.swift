final class TicketOptionsViewModel {
    
    var viewDelegate: TicketOptionsViewModelViewDelegate?
    
    var coordinatorDelegate: TicketOptionsViewModelCoordinatorDelegate?
    
    private var movie: MovieViewDataType
    
    init(movie: MovieViewDataType) {
        self.movie = movie
    }
}


extension TicketOptionsViewModel: TicketOptionsViewModelType {
    
    var titleText: String {
        return movie.movieTitle
    }
    
    var synopsisText: String {
        return movie.synopsis
    }
    
    var buttonText: String {
        return "Add to cart"
    }
    
    func start() {
        viewDelegate?.updateScreen()
    }
    
    func didSelectAddToCart() {
        // TODO
    }
}
