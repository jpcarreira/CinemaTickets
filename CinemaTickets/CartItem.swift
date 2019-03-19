struct CartItem {
    
    var movieTitle: String
    
    var numberOfTickets: Int

    var options: [PricingOptionItem]
    
    init(movieTitle: String, numberOfTickets: Int, options: [PricingOptionItem]) {
        self.movieTitle = movieTitle
        self.numberOfTickets = numberOfTickets
        self.options = options
    }
}
