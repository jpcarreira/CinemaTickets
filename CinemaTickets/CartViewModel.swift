final class CartViewModel {
    
    var coordinatorDelegate: CartViewModelCoordinatorDelegate?
}


extension CartViewModel: CartViewModelType {
  
    var titleText: String {
        return "Shopping Cart"
    }
    
    var totalPriceText: String {
        // TODO:
        return "Total: £89"
    }
    
    func start() {
        // TODO:
    }
    
    func didPressClose() {
        coordinatorDelegate?.didPressCloseCart()
    }
}
