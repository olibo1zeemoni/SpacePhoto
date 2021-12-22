//
//  ViewController.swift
//  SpacePhoto
//
//  Created by Olibo moni on 21/12/2021.
//

import UIKit
@MainActor
class ViewController: UIViewController {
    let photoInfoController = PhotoInfoController()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionView: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .systemRed
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        indicator.center = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2)
        self.view.addSubview(indicator)
        
        title = ""
        
        imageView.image = UIImage(systemName: "photo.on.rectangle")
        descriptionView.text = ""
        let url = URL(string: "https://hackingwithswift.com")
        copyrightLabel.text = "" //UIApplication.shared.open(url)
        
        
        
        Task{
            do {
                let photoInfo = try await photoInfoController.fetchPhotoInfo(date: "2021-12-03")
                await updateUI(with: photoInfo)
                indicator.stopAnimating()

            } catch {
                updateUI(with: error)
                indicator.stopAnimating()
            }
            
        }
        
        
}
    func updateUI(with photoInfo: PhotoInfo) async{
       // Task {
            do{
                let image = try await photoInfoController.fetchImage(from: photoInfo.url)
                
                self.title = photoInfo.title
                self.imageView.image = image
                self.descriptionView.text = photoInfo.description
                self.copyrightLabel.text = photoInfo.copyright
                
                
            } catch {
                
                
            }
            
            
      //  }
    }
    
    
    
    func updateUI(with error: Error) {
       self.title = "Error Fetching Photo"
       self.imageView.image = UIImage(systemName: "exclamationmark.octagon")
       self.descriptionView.text = error.localizedDescription
       self.copyrightLabel.text = ""
   }
    
}

