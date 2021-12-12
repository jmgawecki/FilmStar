import SwiftUI
import Combine
import Foundation

/** `RotationAnimationManager` takes care of the ration of objects that instantiate it and depend its animation state on `rotationAngle` property.

 Manager can be observed by any View struct and it takes care of the animation.

 Please see the example below on how to activate the manager for the View

 ```Swift
struct SomeView: View {
    @ObservedObject private var animationManager = RotationAnimationManager()
var body: some View {
    Image(systemName: SFSymbol.notFavourite)
        .rotationEffect(.degrees(animationManager.rotationAngle))
        .animation(.easeInOut(duration: 2.5), value: animationManager.rotationAngle)
 ```
 
With the `cancel()` method you can smoothly finish the animation.
 
 ```Swift
 .onDisappear {
     animationManager.cancel()
 }
 ```
 
 With the `load()` method you can reactivate the animation.
 
 ``` Swift
 .onAppear(perform: {
     animationManager.load()
 })
 ```
 
Upon the dealocation, the manager makes sure to finish all the subscription and thus prevent any memory leaks.
 */
class RotationAnimationManager: ObservableObject {
    @Published var rotationAngle: Double = 0
    private var subscription: AnyCancellable?
    private var switcher: Bool = true
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.load()
        }
    }
    
    deinit {
        cancel()
    }
    
    func load() {
        withAnimation {
            rotationAngle -= 360
        }
        subscription = Timer.publish(every: 3.5, on: RunLoop.main, in: .common)
            .autoconnect()
            .sink(receiveValue: { [weak self] _ in
                guard let self = self else { return }
                withAnimation {
                    if self.switcher
                    {
                        self.rotationAngle += 360
                    } else {
                        self.rotationAngle -= 360
                    }
                }
                self.switcher.toggle()
            })
    }
    
    func cancel() {
        withAnimation {
            rotationAngle = 0
        }
        switcher = true
        subscription?.cancel()
        subscription = nil
    }
}
