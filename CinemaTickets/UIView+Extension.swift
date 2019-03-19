import UIKit

extension UIView {
    
    var activityIndicatorViewTag: Int {
        return 269034
    }
    
    func startActivityIndicator(at center: CGPoint) {
        DispatchQueue.main.async {
            let activityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
            activityIndicatorView.style = .whiteLarge
            activityIndicatorView.backgroundColor = .gray
            activityIndicatorView.center = center
            activityIndicatorView.layer.cornerRadius = 10
            activityIndicatorView.tag = self.activityIndicatorViewTag
            
            activityIndicatorView.startAnimating()
            self.addSubview(activityIndicatorView)
        }
    }
    
    func stopActivityIndicator() {
        DispatchQueue.main.async {
            if let activityIndicator = self.subviews.filter({ $0.tag == self.activityIndicatorViewTag}).first as? UIActivityIndicatorView {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
        }
    }
}
