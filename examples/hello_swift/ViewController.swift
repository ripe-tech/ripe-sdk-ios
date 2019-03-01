import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelView: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        let ripe = Ripe(brand: "dummy", model: "dummy")
        ripe.bindImage(imageView)
        _ = ripe.bind("post_config") { config in
            ripe.setInitials("PT", engraving: "grey")
        }
        _ = ripe.bind("price") { (price) in
            let total = price["total"] as? NSDictionary
            let priceFinal = total?["price_final"] as! Double
            let currency = total?["currency"] as! String
            self.labelView.text = "\(priceFinal) \(currency)"
        }
    }


}
