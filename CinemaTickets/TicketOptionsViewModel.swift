final class TicketOptionsViewModel {
    
    var viewDelegate: TicketOptionsViewModelViewDelegate?
    
    var coordinatorDelegate: TicketOptionsViewModelCoordinatorDelegate?
    
    private var service: TicketPricingApiService
    
    private var movie: MovieViewDataType
    
    private var pricingOptions = [PricingOption]() {
        didSet {
            self.viewDelegate?.updateTicketOptions()
        }
    }
    
    init(service: TicketPricingApiService, movie: MovieViewDataType) {
        self.service = service
        self.movie = movie
    }
    
    private func getPricingOptions() {
        service.getPricing(movie.movieId) { pricingOptions in
            if let options = pricingOptions {
                self.pricingOptions = options
            }
        }
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
    
    func numberOfPricingOptions() -> Int {
        return pricingOptions.count
    }
    
    func numberOfPricingItems(forOption at: Int) -> Int {
        return pricingOptions[at].options.count
    }
    
    func itemForRow(at index: (Int, Int)) -> PricingItemViewDataType {
        let pricingOption = pricingOptions[index.0].options[index.1]
        return PricingItemViewData(pricingItem: pricingOption)
    }
    
    func start() {
        viewDelegate?.updateScreen()
        getPricingOptions()
    }
    
    func didSelectAddToCart() {
        // TODO:
    }
}
