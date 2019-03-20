import UIKit


final class EmptyCartViewController: UIViewController {
    
    @IBOutlet weak var emptyCartLabel: UILabel!
    
    var viewModel: EmptyCartViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        navigationItem.title = viewModel.titleText
        emptyCartLabel.text = viewModel.mainText
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didPressClose))
    }
    
    @objc private func didPressClose() {
        viewModel.didPressClose()
    }
}
