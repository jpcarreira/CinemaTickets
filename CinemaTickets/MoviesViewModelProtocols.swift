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
    
    // when user taps shopping cart bar button item
    func didPressShoppingCartIcon()
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
    
    // text shown for movie synopsis
    var synopsisText: String { get }
    
    // number of tickets as String to use in the label
    var numberOfTicketsText: String { get }
    
    // text used add to cart button
    var buttonText: String { get }
    
    // number of pricing options we have (ticket type, extras, ...)
    func numberOfPricingOptions() -> Int
    
    // number of pricing items for a given pricing option
    func numberOfPricingItems(forOption at: Int) -> Int
    
    // returns the pricing item view data type
    func itemForRow(at index: (Int, Int)) -> PricingItemViewDataType
    
    // text used in the pricing options sections
    func sectionTitle(for index: Int) -> String
    
    // checks if the pricing options is currently highlighted
    func isCurrentlySelected(at index:(Int, Int)) -> Bool
    
    // number of components used in the ticket picker
    var numberOfComponentsInTicketPicker: Int { get }
    
    // number of tickets the user can add to the cart
    var numberOfTickets: Int { get }
    
    // ticket number as a string to be used in the picker
    func ticketNumber(for index: Int) -> String
    
    /**
     events
     */
    
    // starts the view model
    func start()
    
    // when user taps a row
    func didSelectPricingOption(at index: (Int, Int))
    
    // when the user presses the button to add the item to the cart
    func didSelectAddToCart(withPickerSelected index: Int)
    
    // when the user presses the ok button on the alert that is prompted
    func didPressPrompt()
}


protocol TicketOptionsViewModelViewDelegate {
    
    // updates the UI
    func updateScreen()
    
    // updates the table view with ticket options
    func updateTicketOptions()
    
    // hides / show spinner
    func toggleLoadingAnimation(isAnimating: Bool)
    
    // display alert confirming item was added to cart
    func promptUserForCartOperation(_ title: String, message: String)
}


protocol TicketOptionsViewModelCoordinatorDelegate {
    
    // tells the coordinator that a button was pressed
    func didPressAddToCartButton()
}


// MARK: - Empty Cart

protocol EmptyCartViewModelType {

    var coordinatorDelegate: EmptyCartViewModelCoordinatorDelegate? { get set }
    
    /**
     datasource
     */
    
    // title shown in nav bar
    var titleText: String { get }
    
    // description shown in the VC
    var mainText: String { get }
    
    /**
     events
     */
    
    // when user presses bar button to close
    func didPressClose()
}


protocol EmptyCartViewModelCoordinatorDelegate {
    
    // tells the coordinator that a button to close was pressed
    func didPressClose()
}


// MARK: - Cart

protocol CartViewModelType {
    
    var coordinatorDelegate: CartViewModelCoordinatorDelegate? { get set }
    
    /**
     datasource
     */
    
    // title shown in nav bar
    var titleText: String { get }
    
    // text to show in total price label
    var totalPriceText: String { get }
    
    // number of movies to display
    func numberOfCartItems() -> Int
    
    // gets a specific weather item
    // TODO: to keep it consistent we should use here a CartItemType too (instead of this concrete type)
    func itemCartForRow(at index: Int) -> CartItem
    
    // formatted text to show all options for the ticket
    func optionsTextForItem(at index: Int) -> String
    
    // price as String to be used for a given cart item
    func priceTextForItem(at index:Int) -> String
    
    /**
     events
     */
    
    // starts the view model
    func start()
    
    // when user presses the close button
    func didPressClose()
}


protocol CartViewModelCoordinatorDelegate {
    
    // tells the coordinator that a button to close was pressed
    func didPressCloseCart()
}
