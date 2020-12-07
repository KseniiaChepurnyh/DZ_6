//
//  CollectionViewController.swift
//  DZ_6
//
//  Created by Ксения Чепурных on 07.12.2020.
//

import UIKit

class CollectionViewController: UIViewController {


    @IBOutlet weak var collectionView: UICollectionView!
    
    var photos: [Photo] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "CustomCollectionCell", bundle: nil), forCellWithReuseIdentifier: "CustomCollectionCell")
    }
    

    @IBAction func downloadImages(_ sender: Any) {
        getPhotos()
    }
    
    func getPhotos() {
        guard let imageURL = URL(string: "https://jsonplaceholder.typicode.com/photos") else { return }
        URLSession.shared.dataTask(with: imageURL) { data, _ ,_ in
            guard let data = data, let photos = try? JSONDecoder().decode([Photo].self, from: data) else { return }
            
            self.photos = photos.prefix(20).map { Photo(url: $0.url)}
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }.resume()

    }
    

}

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count > 0 ? photos.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionCell", for: indexPath) as! CustomCollectionCell
        if photos.count != 0 {
                cell.setImage(photoModel: photos[indexPath.item]) { [weak self] (image) in
                    self?.photos[indexPath.item].image = image
                }
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        guard let image: UIImage = photos[indexPath.item].image else {
            return
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let fullScreanVC = storyboard.instantiateViewController(identifier: "fullScreanImageVC") as! ViewController
        fullScreanVC.modalPresentationStyle = .fullScreen
        fullScreanVC.image = image
        present(fullScreanVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewWidth = view.frame.width - 65
        let width = viewWidth / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
}

struct Photo: Codable {
    let url: String
    var image: UIImage?
    
    init(url: String) {
        self.url = url
    }
    
    private enum CodingKeys: String, CodingKey {
        case url = "url"
    }
    
}
