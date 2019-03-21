import Foundation


/**
 By defining the ApiType as a protocol we can implement different concretizations of this protocol,
 one being the "real api" (which would connect to the production API) and the one can be a MockAPI
 (where we can fake network requests)
 */
protocol ApiType {
    
    func fetchAllMovies(completion: @escaping ([MovieApiData]?) -> Void)
    
    func fetchPricingForMovie(_ movieId: Int, completion: @escaping ([PricingOptionApiData]?) -> Void)
}


// in a real-word app we'd have to implement all methods on this class to actually fetch data
// from the API, using an HTTP client like Alamofire to get data from a server
final class Api: ApiType {
  
    func fetchAllMovies(completion: @escaping ([MovieApiData]?) -> Void) {
        fatalError("Requires implementation")
    }
    
    func fetchPricingForMovie(_ movieId: Int, completion: @escaping ([PricingOptionApiData]?) -> Void) {
        fatalError("Requires implementation")
    }
}


final class MockApi: ApiType {
    
    // network delay to fake
    static let delay = 2
    
    func fetchAllMovies(completion: @escaping ([MovieApiData]?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(MockApi.delay)) {
            completion(FakeData.Movies.movies)
        }
    }
    
    func fetchPricingForMovie(_ movieId: Int, completion: @escaping ([PricingOptionApiData]?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(MockApi.delay)) {
            completion(FakeData.PricingOptions.options)
        }
    }
}
