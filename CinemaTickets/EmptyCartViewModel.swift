final class EmptyCartViewModel {

    var coordinatorDelegate: EmptyCartViewModelCoordinatorDelegate?
}


extension EmptyCartViewModel: EmptyCartViewModelType {

    var titleText: String {
        return "Shopping Cart"
    }
    
    var mainText: String {
        return "You didn't had any movie ticket to your shopping cart!"
    }
    
    func didPressClose() {
        coordinatorDelegate?.didPressClose()
    }
}
