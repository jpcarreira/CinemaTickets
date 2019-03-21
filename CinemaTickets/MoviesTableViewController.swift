import UIKit


final class MoviesTableViewController: UITableViewController {
    
    private static let cellIdentifier = "MovieCell"

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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath.row)
    }
    
    private func setupView() {
        navigationItem.title = viewModel.titleText
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cart", style: .done, target: self, action: #selector(didPressShoppingCartIcon))
    }
    
    @objc private func didPressShoppingCartIcon() {
        viewModel.didPressShoppingCartIcon()
    }
}


extension MoviesTableViewController: MoviesViewModelViewDelegate {
    
    func updateScreen() {
        tableView.reloadData()
    }
    
    func toggleLoadingAnimation(isAnimating: Bool) {
        tableView.isUserInteractionEnabled = !isAnimating
        
        if isAnimating {
            view.startActivityIndicator(at: tableView.center)
        } else {
            view.stopActivityIndicator()
        }
    }
}
