protocol StorageType {
    
    var numberOfCartItems: Int { get }
    
    func save(_ cartItem: CartItem)
    
    func getAllCartItems() -> [CartItem]
    
    func clearAllData()
}


/**
 A rudimentary in-memory storage, in a real-world app we'd replace this for Realm or CoreData
 (however it's a good practise to keep the StorageType protocol so that we could easily swap
 for another storage)
 */
final class InMemoryStorage: StorageType {
    
    private var data = [CartItem]()
    
    var numberOfCartItems: Int {
        return data.count
    }
    
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

