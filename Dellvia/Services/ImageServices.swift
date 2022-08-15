
import Foundation
import Firebase
import FirebaseStorage
import UIKit

struct ImageServices{
    
    static var shared = ImageServices()
    
    func uploadImage(image : UIImage , completion: @escaping (String)-> Void ) {
        let uuid = UUID().uuidString
        guard let imageData = image.jpegData(compressionQuality: 0.2) else {
            print("foto dataya çevrilemedi")
            return}
        var ref = Storage.storage().reference(withPath: "/image/\(uuid)")
            ref.putData(imageData) { _, error in
                guard error == nil else {
                    print("put edilemedi görsel")
                    return}
                ref.downloadURL { url, error in
                    guard let url = url else {
                        print("indirilemedi görsel")
                        return
                    }
                    var urlString = url.absoluteString
                    completion(urlString)
                }
            }
        
    }
    
}
