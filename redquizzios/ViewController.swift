//
//  ViewController.swift
//  redquizzios
//
//  Created by Administrador on 19/10/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var registerBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Test push
        registerBtn.round()
    }

}
extension UIButton{
    func round(){
        let roundPts = self.frame.size.height / 2
        self.layer.cornerRadius = roundPts
        self.layer.masksToBounds = true
    }
}

