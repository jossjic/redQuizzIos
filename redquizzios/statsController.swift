
import UIKit
import Firebase

class statsController: UIViewController {

    
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var birth: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    let userViewModel = UserViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
 
        userViewModel.fetchData {
            let userI = self.userViewModel.fetchedUser
            self.name.text = userI.nombre + " " + userI.apellidos
            self.birth.text = userI.fechaNacimiento
            self.email.text = userI.email
            self.gender.text = userI.genero
            if userI.genero == "Masculino" {
                self.profileImg.image = UIImage(named: "placeHombre")
            } else if userI.genero == "Femenino" {
                self.profileImg.image = UIImage(named: "placeMujer")
            } else {
                print("genero no identificado")
            }
        }

        
        
        
        
       
   
    }
    
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
        profileImg.round()
        }
    
    


}
