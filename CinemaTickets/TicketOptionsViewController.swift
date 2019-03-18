import UIKit


final class TicketOptionsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var synopsisLabel: UILabel!
    
    @IBOutlet weak var addToCart: UIButton!
    
    var viewModel: TicketOptionsViewModelType! {
        didSet {
            viewModel.viewDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.start()
    }
    
    @IBAction func didPressAddToCartButton(_ sender: Any) {
        viewModel.didSelectAddToCart()
    }
}


extension TicketOptionsViewController: TicketOptionsViewModelViewDelegate {
    
    func updateScreen() {
        titleLabel.text = viewModel.titleText
        synopsisLabel.text = viewModel.synopsisText
        addToCart.setTitle(viewModel.buttonText, for: .normal)
    }
}
