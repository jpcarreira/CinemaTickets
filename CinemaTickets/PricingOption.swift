final class PricingOption {
    
    let name: String
    
    let options: [PricingOptionItem]
    
    init(name: String, options: [PricingOptionItem]) {
        self.name = name
        self.options = options
    }
}


struct PricingOptionItem {
    
    let name: String
    
    let price: Double
    
    let isDefaultSelection: Bool
}
