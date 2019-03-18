final class MoviesViewModel {
    
    var viewDelegate: MoviesViewModelViewDelegate?
    
    var coordinatorDelegate: MoviesViewModelCoordinatorDelegate?
    
    var service: MoviesApiService
    
    private var isLoading: Bool = false {
        didSet {
            viewDelegate?.toggleLoadingAnimation(isAnimating: isLoading)
        }
    }
    
    private var movies = [MovieViewDataType]() {
        didSet {
            viewDelegate?.updateScreen()
        }
    }
    
    init(service: MoviesApiService) {
        self.service = service
    }
    
    private func getMovies() {
        isLoading = true
        service.getMovies { moviesData in
            if let moviesData = moviesData {
                for movie in moviesData {
                    self.movies.append(MovieViewData(movie: movie))
                }
            }
            self.isLoading = false
        }
    }
}


extension MoviesViewModel: MoviesViewModelType {
    
    var titleText: String {
        return "Select a movie"
    }
    
    func numberOfItems() -> Int {
        return movies.count
    }
    
    func itemForRow(at index: Int) -> MovieViewDataType {
        return movies[index]
    }
    
    func start() {
        getMovies()
    }
    
    func refreshData() {
        getMovies()
    }
}
