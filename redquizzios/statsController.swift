
import UIKit

class statsController: UIViewController {

    @IBOutlet weak var profileImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Test push
   
    }
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
        profileImg.round()
        
        }

}
