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
 */
class FSImageLoader: ObservableObject {
    @Published var image: UIImage?
    private var urlString: String
    private var subscription: AnyCancellable?
    
    init(urlString: String) {
        self.urlString = urlString
    }
    
    deinit {
        cancel()
    }
    
    func load() {
        guard let url = URL(string: urlString)
        else { return }

        subscription = URLSession.shared.dataTaskPublisher(for: url)
            .map({ UIImage(data: $0.data) })
            .replaceError(with: nil)
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] in self?.image = $0 })
    }
    
    func cancel() {
        subscription?.cancel()
        subscription = nil
    }
}
