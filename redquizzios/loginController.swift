//
//  ViewController.swift
//  redquizzios
//
//  Created by Administrador on 19/10/23.
//

import UIKit

class loginController: UIViewController {

    @IBOutlet weak var registerBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Test push
    }

}


extension UIImageView{
    func round(){
        layer.borderWidth = 1
        layer.masksToBounds = false
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = min(self.frame.width, self.frame.height) / 2

        clipsToBounds = true
    }
}

