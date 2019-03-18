import Foundation


/**
 By defining the ApiType as a protocol we can implement different concretizations of this protocol,
 one being the "real api" (which would connect to the production API) and the one can be a MockAPI
 (where we can fake network requests)
 */
protocol ApiType {
    
    func fetchAllMovies(completion: @escaping ([MovieApiData]?) -> Void)
}


// in a real-word app we'd have to implement all methods on this class to actually fetch data
// from the API, using an HTTP client like Alamofire to get data from a server
final class Api: ApiType {
    
    func fetchAllMovies(completion: @escaping ([MovieApiData]?) -> Void) {
        fatalError("Requires implementation")
    }
}


final class MockApi: ApiType {
    
    // network delay to fake
    static let delay = 2
    
    // some fake movie data
    static let movies = [
        MovieApiData(
            title: "Star Wars Ep I: The Phantom Menace",
            actors: ["Liam Neeson", "Ewan McGregor", "Natalie Portman"]),
        MovieApiData(
            title: "Star Wars Ep II: Attack Of The Clones",
            actors: ["Ewan McGregor", "Hayden Christensen", "Natalie Portman"]),
        MovieApiData(
            title: "Star Wars Ep III: Revenge Of The Sith",
            actors: ["Ewan McGregor", "Hayden Christensen", "Natalie Portman"]),
        MovieApiData(
            title: "Star Wars Ep IV: A New Hope",
            actors: ["Mark Hamill", "Harrison Ford", "Carrie Fisher"]),
        MovieApiData(
            title: "Star Wars Ep V: The Empire Strikes Back",
            actors: ["Mark Hamill", "Harrison Ford", "Carrie Fisher"]),
        MovieApiData(
            title: "Star Wars Ep VI: The Return of The Jedi",
            actors: ["Mark Hamill", "Harrison Ford", "Carrie Fisher"]),
        MovieApiData(
            title: "Star Wars Ep VII: The Force Awakens",
            actors: ["Mark Hamill", "Harrison Ford", "Carrie Fisher", "Adam Driver", "Daisy Ridley"]),
        MovieApiData(
            title: "Star Wars Ep VIII: The Last Jedi",
            actors: ["Mark Hamill", "Harrison Ford", "Carrie Fisher", "Adam Driver", "Daisy Ridley"])
    ]
    
    func fetchAllMovies(completion: @escaping ([MovieApiData]?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(MockApi.delay)) {
            completion(MockApi.movies)
        }
    }
}
