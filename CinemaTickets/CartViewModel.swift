final class CartViewModel {
    
    var coordinatorDelegate: CartViewModelCoordinatorDelegate?
    
    private var storage: StorageType
    
    private var allItems = [CartItem]()
    
    init(storage: StorageType) {
        self.storage = storage
    }
}


extension CartViewModel: CartViewModelType {

    var titleText: String {
        return "Shopping Cart"
    }
    
    var totalPriceText: String {
        var total = 0.0
        for item in allItems {
            total += item.options.map({ $0.price }).reduce(0.0, +) * Double(item.numberOfTickets)
            total = total.rounded(toPlaces: 2)
        }
        
        return "Total: £\(total)"
    }
    
    func numberOfCartItems() -> Int {
        return allItems.count
    }
    
    func itemCartForRow(at index: Int) -> CartItem {
        return allItems[index]
    }
    
    func optionsTextForItem(at index: Int) -> String {
        let itemOptions = allItems[index].options
        
        var optionsString = "\(allItems[index].numberOfTickets) tickets"
        for option in itemOptions {
            optionsString.append(", ")
            optionsString.append(option.name)
        }
        
        return optionsString
    }
    
    func priceTextForItem(at index: Int) -> String {
        let itemOptions = allItems[index].options
        
        var price = 0.0
        for option in itemOptions {
            price += option.price
        }
        
        price *= Double(allItems[index].numberOfTickets)
        price = price.rounded(toPlaces: 2)
        
        return "£\(price)"
    }
    
    func start() {
        allItems = storage.getAllCartItems()
    }
    
    func didPressClose() {
        coordinatorDelegate?.didPressCloseCart()
    }
}
