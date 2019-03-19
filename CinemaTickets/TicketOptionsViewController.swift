import UIKit


final class TicketOptionsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var synopsisLabel: UILabel!
    
    @IBOutlet weak var optionsTable: UITableView!
    
    @IBOutlet weak var numberOfTicketsLabel: UILabel!
    
    @IBOutlet weak var numberOfTicketsPickerView: UIPickerView!
    
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
        
        numberOfTicketsPickerView.dataSource = self
        numberOfTicketsPickerView.delegate = self
    }
}


extension TicketOptionsViewController: TicketOptionsViewModelViewDelegate {
    
    func updateScreen() {
        titleLabel.text = viewModel.titleText
        synopsisLabel.text = viewModel.synopsisText
        numberOfTicketsLabel.text = viewModel.numberOfTicketsText
        addToCart.setTitle(viewModel.buttonText, for: .normal)
    }
    
    func updateTicketOptions() {
        optionsTable.reloadData()
    }
    
    func toggleLoadingAnimation(isAnimating: Bool) {
        view.isUserInteractionEnabled = !isAnimating
        
        if isAnimating {
            view.startActivityIndicator(at: view.center)
        } else {
            view.stopActivityIndicator()
        }
    }
}


extension TicketOptionsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfPricingItems(forOption: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: TicketOptionsViewController.cellIdentifier, for: indexPath) as? TicketOptionsTableViewCell
        
        if cell == nil {
            cell = TicketOptionsTableViewCell(style: .default, reuseIdentifier: TicketOptionsViewController.cellIdentifier)
        }
        
        let pricingItem = viewModel.itemForRow(at: (indexPath.section, indexPath.row))
        cell?.titleLabel.text = pricingItem.name
        cell?.priceLabel.text = "\(pricingItem.price)"
        cell?.accessoryType = viewModel.isCurrentlySelected(at: (indexPath.section, indexPath.row)) ? .checkmark : .none
        
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfPricingOptions()
    }
}


extension TicketOptionsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sectionTitle(for: section)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectPricingOption(at: (indexPath.section, indexPath.row))
    }
}


extension TicketOptionsViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return viewModel.numberOfComponentsInTicketPicker
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.numberOfTickets
    }
}


extension TicketOptionsViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.ticketNumber(for: row)
    }
}
