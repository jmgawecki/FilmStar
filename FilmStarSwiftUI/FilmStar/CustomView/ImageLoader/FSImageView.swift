import Foundation
import SwiftUI


/// `FSImageView` is binded to `FSImageLoader` that fetches an image asynchronously for the view.
///
/// Struct uses the `ProgressView` as placeholder until the image is loaded
///
/// Structs accessibility is disabled. Use `.accessibilityLabel(T##label: Text##Text)` to set a custom label.
struct FSImageView: View {
    @StateObject private var loader: FSImageLoader
    
    init(urlString: String) {
        _loader = StateObject(wrappedValue: FSImageLoader(urlString: urlString))
    }
    
    var body: some View {
        ZStack {
            if loader.image != nil {
                Image(uiImage: loader.image!)
                    .resizable()
            } else {
                ProgressView()
            }
        }
        .onAppear(perform: loader.load)
        .accessibilityHidden(true)
    }
}
