import UIKit


final class CartViewController: UIViewController {
    
    @IBOutlet weak var cartTable: UITableView!
    
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    var viewModel: CartViewModelType!
    
    private static let cellIdentifier = "CartCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.start()
        
        setupView()
    }
    
    private func setupView() {
        cartTable.dataSource = self
        cartTable.delegate = self
        
        navigationItem.title = viewModel.titleText
        totalPriceLabel.text = viewModel.totalPriceText
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didPressClose))
    }
    
    @objc private func didPressClose() {
        viewModel.didPressClose()
    }
}


extension CartViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCartItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = cartTable.dequeueReusableCell(withIdentifier: CartViewController.cellIdentifier, for: indexPath) as? CartItemCell
        
        if cell == nil {
            cell = CartItemCell(style: .default, reuseIdentifier: CartViewController.cellIdentifier)
        }
        
        let cartItem = viewModel.itemCartForRow(at: indexPath.row)
        cell?.movieTitleLabel.text = cartItem.movieTitle
        cell?.ticketOptionsLabel.text = viewModel.optionsTextForItem(at: indexPath.row)
        cell?.priceLabel.text = viewModel.priceTextForItem(at: indexPath.row)
    
        return cell!
    }
}


extension CartViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
