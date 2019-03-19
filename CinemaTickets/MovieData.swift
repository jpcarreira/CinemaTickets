final class MovieData {
    
    let movieId: Int
    
    let title: String
    
    let synopsis: String?
    
    init(movieId: Int, title: String, synopsis: String?) {
        self.movieId = movieId
        self.title = title
        self.synopsis = synopsis
    }
}
