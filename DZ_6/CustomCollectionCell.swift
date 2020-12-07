//
//  CustomCollectionCell.swift
//  DZ_6
//
//  Created by Ксения Чепурных on 07.12.2020.
//

import UIKit

class CustomCollectionCell: UICollectionViewCell {

    
    @IBOutlet weak var cellImage: UIImageView!
    
    
    func setImage(photoModel: Photo, completion: @escaping (UIImage?) -> Void) {
        if let image = photoModel.image {
            cellImage.image = image
            return
        }
        
        guard let imageURL = URL(string: photoModel.url) else {
            return
        }
        URLSession.shared.dataTask(with: imageURL) {data, _ ,_ in
            if let data = data, let image = UIImage(data: data) {
                completion(image)
                DispatchQueue.main.async {
                    self.cellImage.image = image
                }
            }
            
        }.resume()
    }
}
