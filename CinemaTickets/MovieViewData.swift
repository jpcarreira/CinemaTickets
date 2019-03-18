/**
 Struct with the data the view model needs and its
 implementation of the MovieViewDataType protocol
 */
struct MovieViewData {
    
    private let movie: MovieData
    
    init(movie: MovieData) {
        self.movie = movie
    }
}


extension MovieViewData: MovieViewDataType {
    
    var movieTitle: String {
        return movie.title
    }
    
    var synopsis: String {
        return movie.synopsis ?? "Synopsis for this movie is not available"
    }
}

