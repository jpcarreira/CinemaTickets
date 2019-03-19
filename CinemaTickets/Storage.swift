protocol StorageType {
    
    func save(_ cartItem: CartItem)
    
    func getAllCartItems() -> [CartItem]
    
    func clearAllData()
}


final class InMemoryStorage: StorageType {
    
    private var data = [CartItem]()
    
    func save(_ cartItem: CartItem) {
        data.append(cartItem)
    }
    
    func getAllCartItems() -> [CartItem] {
        return data
    }
    
    func clearAllData() {
        data.removeAll()
    }
}

