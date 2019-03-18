import UIKit


final class MoviesTableViewController: UITableViewController {
    
    static let cellIdentifier = "MovieCell"
    
    private var activityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    
    var viewModel: MoviesViewModelType! {
        didSet {
            viewModel.viewDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        viewModel.start()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MoviesTableViewController.cellIdentifier, for: indexPath)
        
        let movie = viewModel.itemForRow(at: indexPath.row)
        cell.textLabel?.text = movie.movieTitle
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    private func setupView() {
        navigationItem.title = viewModel.titleText
        
        // TODO: move to UIView extension
        activityIndicatorView.style = .whiteLarge
        activityIndicatorView.backgroundColor = .gray
        activityIndicatorView.center = tableView.center
        activityIndicatorView.layer.cornerRadius = 10
        view.addSubview(activityIndicatorView)
    }
}


extension MoviesTableViewController: MoviesViewModelViewDelegate {
    func updateScreen() {
        tableView.reloadData()
    }
    
    func toggleLoadingAnimation(isAnimating: Bool) {
        tableView.isUserInteractionEnabled = !isAnimating
        
        if isAnimating {
            activityIndicatorView.startAnimating()
        } else {
            activityIndicatorView.stopAnimating()
        }
    }
}
