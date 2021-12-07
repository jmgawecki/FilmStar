import Foundation
import SwiftUI

struct FSImageView: View {
    @StateObject private var loader: ImageLoader
    
    init(urlString: String) {
        _loader = StateObject(wrappedValue: ImageLoader(urlString: urlString))
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
