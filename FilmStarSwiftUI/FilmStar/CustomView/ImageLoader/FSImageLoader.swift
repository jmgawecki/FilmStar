import SwiftUI
import Combine
import Foundation

/**
 Class to asynchronously dispatch fetched `UIImage` and update the UI.

 Class uses `Combine`'s dataTaskPublisher to fetch the image and dispatch it on the main thread.

 Class currently supports `FSImageView` but can be used for other views. To do it, declare `@StateObject` of type `ImageLoader` and assign it directly to the binding struct itself as such:

 ```Swift
 struct FSImageView: View {
     @StateObject private var loader: FSImageLoader

     init(urlString: String) {
         _loader = StateObject(wrappedValue: FSImageLoader(urlString: urlString))
     }
 ```
 
 Class introduces NSCache where UIImage is saved. If the Image exists, it won't be fetched again.
 */
class FSImageLoader: ObservableObject {
    @Published var image: UIImage?
    private var urlString: String
    private var subscription: AnyCancellable?
    private let cache = NSCache<NSString, UIImage>()
    
    init(urlString: String) {
        self.urlString = urlString
    }
    
    deinit {
        cancel()
    }
    
    func load() {
        guard let url = URL(string: urlString)
        else { return }
        
        if let image = cache.object(forKey: urlString as NSString) {
            self.image = image
            return
        }

        subscription = URLSession.shared.dataTaskPublisher(for: url)
            .map({ UIImage(data: $0.data) })
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] image in
                guard
                    let self = self,
                    let image = image
                else { return }
                self.cache.setObject(image, forKey: self.urlString as NSString)
                self.image = image
            })
    }
    
    func cancel() {
        subscription?.cancel()
        subscription = nil
    }
}
