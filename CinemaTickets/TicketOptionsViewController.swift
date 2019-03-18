import UIKit


final class TicketOptionsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var synopsisLabel: UILabel!
    
    @IBOutlet weak var optionsTable: UITableView!
    
    @IBOutlet weak var addToCart: UIButton!
    
    private static let cellIdentifier = "OptionCell"
    
    var viewModel: TicketOptionsViewModelType! {
        didSet {
            viewModel.viewDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        viewModel.start()
    }
    
    @IBAction func didPressAddToCartButton(_ sender: Any) {
        viewModel.didSelectAddToCart()
    }
    
    private func setupView() {
        optionsTable.dataSource = self
        optionsTable.delegate = self
    }
}


extension TicketOptionsViewController: TicketOptionsViewModelViewDelegate {
    
    func updateScreen() {
        titleLabel.text = viewModel.titleText
        synopsisLabel.text = viewModel.synopsisText
        addToCart.setTitle(viewModel.buttonText, for: .normal)
    }
}


extension TicketOptionsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO:
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: TicketOptionsViewController.cellIdentifier, for: indexPath) as? TicketOptionsTableViewCell
        
        if cell == nil {
            cell = TicketOptionsTableViewCell(style: .default, reuseIdentifier: TicketOptionsViewController.cellIdentifier)
        }
        
        // TODO: placeholder text
        cell?.titleLabel.text = "special offer"
        cell?.priceLabel.text = "$9.9"
        
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // TODO:
        return 2
    }
}


extension TicketOptionsViewController: UITableViewDelegate {
    
}
