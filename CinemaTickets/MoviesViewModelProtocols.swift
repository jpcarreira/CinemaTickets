// MARK: - Movies Display

/**
 This is the protocol the MoviesViewModel should conform to
 
 ## It should include:
 
 - datasource: all formatted data the view controller needs
 
 - events: sent by the view controller to self (always include a start() which is called
 by the VC in viewDidLoad() so that the VM starts all the required business logic)
 */
protocol MoviesViewModelType {
    
    /**
     delegates
     */
    
    // reference to the view delegate (so that the view model talks to the view controller)
    var viewDelegate: MoviesViewModelViewDelegate? { get set }
    
    // reference to the coordinator delegate (so that the view model talks to the coordinator)
    var coordinatorDelegate: MoviesViewModelCoordinatorDelegate? { get set }
    
    /**
     datasource
     */
    
    // title shown in nav bar
    var titleText: String { get }
    
    // number of movies to display
    func numberOfItems() -> Int
    
    // gets a specific weather item
    func itemForRow(at index: Int) -> MovieViewDataType
    
    /**
     events
     */
    
    // starts the view model
    func start()
    
    // when an action requires refreshing weather data (e.g., pull-to-refresh)
    func refreshData()
    
    // when user taps a row
    func didSelectRow(at index: Int)
}


protocol MoviesViewModelViewDelegate: class {
    
    // updates the screen when gets new movie data
    func updateScreen()
    
    // instructs the view to start/stop loading animation
    func toggleLoadingAnimation(isAnimating: Bool)
}


protocol MoviesViewModelCoordinatorDelegate: class {

    // when a touch is detected in shopping cart button
    func didPressShoppingCart()
    
    // when a row with a movie item is tapped
    func didSelect(movie: MovieViewDataType)
}


// MARK: - Ticket Options

/**
 This is the protocol the TicketOptionsViewModel should conform to
 
 ## It should include:
 
 - datasource: all formatted data the view controller needs
 
 - events: sent by the view controller to self (always include a start() which is called
 by the VC in viewDidLoad() so that the VM starts all the required business logic)
 */
protocol TicketOptionsViewModelType {
    
    /**
     delegates
     */
    
    // reference to the view delegate (so that the view model talks to the view controller)
    var viewDelegate: TicketOptionsViewModelViewDelegate? { get set }
    
    // reference to the coordinator delegate (so that the view model talks to the coordinator)
    var coordinatorDelegate: TicketOptionsViewModelCoordinatorDelegate? { get set }
    
    /**
     datasource
     */
    
    // title shown in nav bar
    var titleText: String { get }
    
    var synopsisText: String { get }
    
    var numberOfTicketsText: String { get }
    
    var buttonText: String { get }
    
    func numberOfPricingOptions() -> Int
    
    func numberOfPricingItems(forOption at: Int) -> Int
    
    func itemForRow(at index: (Int, Int)) -> PricingItemViewDataType
    
    func sectionTitle(for index: Int) -> String
    
    func isCurrentlySelected(at index:(Int, Int)) -> Bool
    
    var numberOfComponentsInTicketPicker: Int { get }
    
    var numberOfTickets: Int { get }
    
    func ticketNumber(for index: Int) -> String
    
    /**
     events
     */
    
    // starts the view model
    func start()
    
    // when user taps a row
    func didSelectPricingOption(at index: (Int, Int))
    
    func didSelectAddToCart(withPickerSelected index: Int)
    
    func didPressPrompt()
}


protocol TicketOptionsViewModelViewDelegate {
    
    func updateScreen()
    
    func updateTicketOptions()
    
    func toggleLoadingAnimation(isAnimating: Bool)
    
    func promptUserForCartOperation(_ title: String, message: String)
}


protocol TicketOptionsViewModelCoordinatorDelegate {
    
    func didPressAddToCartButton()
}
