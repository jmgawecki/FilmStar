import SwiftUI
import Combine
import Foundation

class ImageLoader: ObservableObject {
    @Published var image: UIImage? {
        didSet {
            print(image)
        }
    }
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
    }
}
