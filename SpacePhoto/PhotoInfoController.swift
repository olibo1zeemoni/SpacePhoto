//
//  PhotoInfoController.swift
//  SpacePhoto
//
//  Created by Olibo moni on 21/12/2021.
//

import Foundation
import UIKit

class PhotoInfoController: UIViewController {
    //static let shared = PhotoInfoController()

    func fetchPhotoInfo(date date: String) async throws -> PhotoInfo {
    //let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=23o8zS6tiFaWwuqxQKjdsFs1Ol8sJT9ax9J6rTM5")!
    //let url = URL(string: "https://api.pexels.com/videos/")!
       // let query: Dictionary<String,String> = ["date" : date]
    var urlComponents = URLComponents(string: "https://api.nasa.gov/planetary/apod")!
    urlComponents.queryItems = [
                                    "api_key" : "23o8zS6tiFaWwuqxQKjdsFs1Ol8sJT9ax9J6rTM5",
                                    
                                     //"date": "2021-12-21",
                                    "date": date
                                     ].map {URLQueryItem(name: $0.key, value: $0.value) }
 

        let jsonDecoder = JSONDecoder()
        let (data,response) = try await URLSession.shared.data(from: urlComponents.url!)
        
    guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200 else { throw PhotoInfoError.itemNotFound}
           let photoInfo = try jsonDecoder.decode(PhotoInfo.self, from: data)
            
    
    return photoInfo
}


enum PhotoInfoError: Error,LocalizedError {
    case itemNotFound
    case imageDataMissing
}
    
    func fetchImage(from url: URL) async throws -> UIImage {
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.scheme = "https"
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else { throw PhotoInfoError.itemNotFound}
        
        
        
        
        
        guard let image = UIImage(data: data) else {
            throw PhotoInfoError.imageDataMissing
        }
        
        return image
    }
    
    
    
    

}
