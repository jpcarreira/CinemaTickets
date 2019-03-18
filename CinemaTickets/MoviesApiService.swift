class MoviesApiService {
    
    let api: ApiType
    
    init(api: ApiType) {
        self.api = api
    }
    
    func getMovies(completion: @escaping ([MovieData]?) -> Void) {
        api.fetchAllMovies { movieApiData in
            if let movieApiData = movieApiData {
                var movies = [MovieData]()
                for movie in movieApiData {
                    movies.append(MovieData(title: movie.title))
                }
                
                completion(movies)
            }
            
            completion(nil)
        }
    }
}