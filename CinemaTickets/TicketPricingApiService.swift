class TicketPricingApiService {
    
    private let api: ApiType
    
    init(api: ApiType) {
        self.api = api
    }

    func getPricing(_ movieID: Int, completion: @escaping ([PricingOption]?) -> Void) {
        api.fetchPricingForMovie(movieID) { pricingData in
            if let pricingData = pricingData {
                var pricingOptions = [PricingOption]()
                for pricingOption in pricingData {
                    var pricingOptionItems = [PricingOptionItem]()
                    // TODO: inner-loop?? refactor this...
                    for item in pricingOption.options {
                        pricingOptionItems.append(PricingOptionItem(name: item.0, price: item.1, isDefaultSelection: item.2))
                    }
                    pricingOptions.append(PricingOption(name: pricingOption.name, options: pricingOptionItems))
                }
                
                completion(pricingOptions)
            }
            
            completion(nil)
        }
    }
}
