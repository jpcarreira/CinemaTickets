protocol PricingItemViewDataType {
    
    var name: String { get }
    
    var price: String { get }
    
    var isDefaultSelection: Bool { get }
}


struct PricingItemViewData {
    
    let pricingItem: PricingOptionItem
}

extension PricingItemViewData: PricingItemViewDataType {
    
    var name: String {
        return pricingItem.name
    }
    
    var price: String {
        return "£\(pricingItem.price)"
    }
    
    var isDefaultSelection: Bool {
        return pricingItem.isDefaultSelection
    }
}
