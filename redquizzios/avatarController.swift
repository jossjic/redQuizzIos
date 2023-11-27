import UIKit
import Firebase

class avatarController: UIViewController {

    // Outlets
    @IBOutlet weak var playeraHombre: UIImageView!
    @IBOutlet weak var pantalonHombre: UIImageView!
    @IBOutlet weak var zapatosHombre: UIImageView!
    @IBOutlet weak var editAvatarBtn: UIButton!
    @IBOutlet weak var maleAvatar: UIImageView!
    @IBOutlet weak var femaleAvatar: UIImageView!
    @IBOutlet weak var playeraMujer: UIImageView!
    @IBOutlet weak var pantalonMujer: UIImageView!
    @IBOutlet weak var zapatosMujer: UIImageView!
    @IBOutlet weak var returnBtn: UIButton!

    // Firestore references
    let db = Firestore.firestore()
    let uid = Auth.auth().currentUser?.uid

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserData()
    }

    // Function to fetch user data from Firestore
    func fetchUserData() {
        if let uid = uid {
            // Fetch data from rqUsers collection
            db.collection("rqUsers").document(uid).getDocument { (document, error) in
                if let document = document, document.exists {
                    let data = document.data()
                    if let genero = data?["genero"] as? String,
                       let puntaje = data?["puntaje"] as? Int,
                       let prendaI = data?["prendaI"] as? Int,
                       let prendaS = data?["prendaS"] as? Int {
                        
                        // Update UI based on gender
                        self.updateUIForGender(genero)
                        
                        // Assign clothing based on prendaS and prendaI values
                        self.assignClothing(genero: genero, prendaS: prendaS, prendaI: prendaI)

                        // Fetch data from rqRecompensas collection
                        self.fetchRecompensasDataAndUpdateFirestore(uid,puntaje)
                    }
                } else {
                    print("Document does not exist")
                }
            }
        }
    }
    // Function to assign clothing based on prendaS and prendaI values
        func assignClothing(genero: String, prendaS: Int, prendaI: Int) {
            if genero == "Masculino" {
                // Assign clothing for male avatar
                switch prendaS {
                case 1:
                    self.playeraHombre.image = UIImage(named: "prenda1Shombre")
                case 2:
                    self.playeraHombre.image = UIImage(named: "prenda2Shombre")
                case 3:
                    self.playeraHombre.image = UIImage(named: "prenda3Shombre")
                case 4:
                    self.playeraHombre.image = UIImage(named: "prenda4Shombre")
                default:
                    break
                }

                switch prendaI {
                case 1:
                    self.pantalonHombre.image = UIImage(named: "prenda1Ihombre")
                case 2:
                    self.pantalonHombre.image = UIImage(named: "prenda2Ihombre")
                case 3:
                    self.pantalonHombre.image = UIImage(named: "prenda3Ihombre")
                default:
                    break
                }
            } else {
                // Assign clothing for female avatar
                switch prendaS {
                case 1:
                    self.playeraMujer.image = UIImage(named: "prenda1Smujer")
                case 2:
                    self.playeraMujer.image = UIImage(named: "prenda2Smujer")
                case 3:
                    self.playeraMujer.image = UIImage(named: "prenda3Smujer")
                case 4:
                    self.playeraMujer.image = UIImage(named: "prenda4Smujer")
                default:
                    break
                }

                switch prendaI {
                case 1:
                    self.pantalonMujer.image = UIImage(named: "prenda1Imujer")
                case 2:
                    self.pantalonMujer.image = UIImage(named: "prenda2Imujer")
                case 3:
                    self.pantalonMujer.image = UIImage(named: "prenda3Imujer")
                default:
                    break
                }
            }
        }


    // Function to update UI based on gender
    func updateUIForGender(_ genero: String) {
        if genero == "Masculino" {
            maleAvatar.isHidden = false
            femaleAvatar.isHidden = true
            playeraHombre.isHidden = false
            pantalonHombre.isHidden = false
            zapatosHombre.isHidden = false
            playeraMujer.isHidden = true
            pantalonMujer.isHidden = true
            zapatosMujer.isHidden = true
        } else {
            maleAvatar.isHidden = true
            femaleAvatar.isHidden = false
            playeraHombre.isHidden = true
            pantalonHombre.isHidden = true
            zapatosHombre.isHidden = true
            playeraMujer.isHidden = false
            pantalonMujer.isHidden = false
            zapatosMujer.isHidden = false
        }
    }

    // Function to fetch data from rqRecompensas collection and update Firestore
    func fetchRecompensasDataAndUpdateFirestore(_ uid: String, _ puntaje: Int) {
        db.collection("rqRecompensas").document(uid).getDocument { (document, error) in
            if let document = document, document.exists {
                var recompensa1 = false
                var recompensa2 = false
                var recompensa3 = false
                var recompensa4 = false
                var recompensa5 = false
                
                if puntaje >= 50 {
                    recompensa1 = true
                    }

                if puntaje >= 100 {
                        recompensa2 = true
                    }
                if puntaje >= 200 {
                        recompensa3 = true
                    }
                if puntaje >= 400 {
                        recompensa4 = true
                    }
                if puntaje >= 800 {
                        recompensa5 = true
                    }
                    self.updateRecompensasInFirestore(recompensa1, recompensa2, recompensa3, recompensa4, recompensa5)
                } else {
                    print("rqRecompensas document does not exist")
                }
            }
        }
    // Function to update recompensa states in Firestore
    func updateRecompensasInFirestore(_ recompensa1: Bool, _ recompensa2: Bool, _ recompensa3: Bool, _ recompensa4: Bool, _ recompensa5: Bool) {
        if let uid = uid {
            db.collection("rqUsers").document(uid).updateData([
                "recompensa1": recompensa1,
                "recompensa2": recompensa2,
                "recompensa3": recompensa3,
                "recompensa4": recompensa4,
                "recompensa5": recompensa5]) { error in
                    if let error = error {
                        print("Error updating recompensa states: \(error.localizedDescription)")
                    } else {
                        print("Recompensa states updated successfully")
                    }
                }
            }
        }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    @IBAction func editAvatarBtnTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "editAvatarSegue", sender: self)
    }

    @IBAction func returnBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "homeSegue", sender: self)
    }
}

