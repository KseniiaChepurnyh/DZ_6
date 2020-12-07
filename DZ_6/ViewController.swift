//
//  ViewController.swift
//  DZ_6
//
//  Created by Ксения Чепурных on 07.12.2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var fullScreanImage: UIImageView!
    public var image: UIImage = UIImage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullScreanImage.image = image
        
    }
    

    @IBAction func exitVC(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
