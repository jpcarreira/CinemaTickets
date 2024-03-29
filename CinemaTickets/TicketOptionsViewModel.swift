final class TicketOptionsViewModel {
    
    var viewDelegate: TicketOptionsViewModelViewDelegate?
    
    var coordinatorDelegate: TicketOptionsViewModelCoordinatorDelegate?
    
    private var service: TicketPricingApiService
    
    private var storage: StorageType
    
    private var movie: MovieViewDataType

    private var pricingOptions = [PricingOption]() {
        didSet {
            self.viewDelegate?.updateTicketOptions()
            
            // TODO: chained for-loops, refactor!
            for (outerIndex, option) in pricingOptions.enumerated() {
                for (innerIndex, item) in option.options.enumerated() {
                    if item.isDefaultSelection {
                        currentlySelectedOptions.append((outerIndex, innerIndex))
                    }
                }
            }
        }
    }
    
    private var currentlySelectedOptions = [(Int, Int)]()
    
    private func getCurrentlySelectedOptionsPricingOptionItems() -> [PricingOptionItem] {
        var items = [PricingOptionItem]()
        for index in currentlySelectedOptions {
            items.append(pricingOptions[index.0].options[index.1])
        }
        
        return items
    }

    private var ticketNumbers: [Int] = {
        // TODO: keeping a simple model assuming every user can only buy 5 tickets
        // (here we could request our service to only display how many tickets are available
        return [1, 2, 3, 4, 5]
    }()
    
    private var isLoading: Bool = false {
        didSet {
            viewDelegate?.toggleLoadingAnimation(isAnimating: isLoading)
        }
    }
    
    init(service: TicketPricingApiService, storage: StorageType, movie: MovieViewDataType) {
        self.service = service
        self.storage = storage
        self.movie = movie
    }
    
    private func getPricingOptions() {
        isLoading = true
        service.getPricing(movie.movieId) { pricingOptions in
            if let options = pricingOptions {
                self.pricingOptions = options
                self.isLoading = false
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
    
    var numberOfTicketsText: String {
        return "Number of tickets:"
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
    
    func sectionTitle(for index: Int) -> String {
        return pricingOptions[index].name
    }
    
    func isCurrentlySelected(at index: (Int, Int)) -> Bool {
        return currentlySelectedOptions.contains { option in
            return index == option
        }
    }
    
    var numberOfComponentsInTicketPicker: Int {
        return 1
    }
    
    var numberOfTickets: Int {
        return ticketNumbers.count
    }
    
    func ticketNumber(for index: Int) -> String {
        return "\(ticketNumbers[index])"
    }
    
    func start() {
        viewDelegate?.updateScreen()
        getPricingOptions()
    }
    
    func didSelectPricingOption(at index: (Int, Int)) {
        var updatedSelection = currentlySelectedOptions.filter { $0.0 != index.0 }
        updatedSelection.append(index)
        currentlySelectedOptions = updatedSelection
        
        viewDelegate?.updateTicketOptions()
    }
    
    func didSelectAddToCart(withPickerSelected index: Int) {
        let cartItem = CartItem(movieTitle: movie.movieTitle, numberOfTickets: ticketNumbers[index], options: getCurrentlySelectedOptionsPricingOptionItems())
        storage.save(cartItem)
        
        viewDelegate?.promptUserForCartOperation("Added to cart", message: "\(cartItem.numberOfTickets) tickets to watch \"\(cartItem.movieTitle)\" were added to your shopping cart.")
    }
    
    func didPressPrompt() {
        coordinatorDelegate?.didPressAddToCartButton()
    }
}
