class MoviesApiService {
    
    private let api: ApiType
    
    init(api: ApiType) {
        self.api = api
    }
    
    func getMovies(completion: @escaping ([MovieData]?) -> Void) {
        api.fetchAllMovies { movieApiData in
            if let movieApiData = movieApiData {
                var movies = [MovieData]()
                for movie in movieApiData {
                    movies.append(MovieData(movieId: movie.movieId, title: movie.title, synopsis: movie.synopsis))
                }
                
                completion(movies)
            }
            
            completion(nil)
        }
    }
}
