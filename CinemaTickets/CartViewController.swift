import UIKit


final class CartViewController: UIViewController {
    
    @IBOutlet weak var optionsTable: UITableView!
    
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    @IBOutlet weak var buyNowButton: UIButton!
    
    var viewModel: CartViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        navigationItem.title = viewModel.titleText
        totalPriceLabel.text = viewModel.totalPriceText
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didPressClose))
    }
    
    @objc private func didPressClose() {
        viewModel.didPressClose()
    }
}
