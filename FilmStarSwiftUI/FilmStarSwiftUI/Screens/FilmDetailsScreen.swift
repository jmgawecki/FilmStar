import SwiftUI

struct FilmDetailsScreen: View {
    @ObservedObject var viewModel: FSViewModel
    @FocusState private var isTextFieldFocused
    var body: some View {
        if let film = viewModel.film {
            ScrollView(.vertical) {
                ZStack {
                    VStack() {
                        HStack {
                            FSBorederedButton(
                                title: "Save",
                                systemImage: "star",
                                colour: .purple,
                                size: .large,
                                accessibilityLabel: "Save to favourites",
                                accessibilityHint: "Double tap to add Film to your favourites") {
                                    print("nothin")
                                }
                            
                            
                            FSBorederedButton(
                                title: "AR Poster",
                                systemImage: "arkit",
                                colour: .purple,
                                size: .large,
                                accessibilityLabel: "A R Poster",
                                accessibilityHint: "A R Experience is not accessibility-friendly. We apologise for the incovienience.") {
                                    viewModel.isARPresenting.toggle()
                                }
                                .fullScreenCover(
                                    isPresented: $viewModel.isARPresenting,
                                    onDismiss: nil) {
                                        PosterARScreen(viewModel: viewModel)
                                    }
                            
//                            Spacer()
                            
                            FSBorederedButton(
                                title: "",
                                systemImage: "xmark",
                                colour: .yellow,
                                size: .large,
                                accessibilityLabel: "Go back") {
                                    viewModel.film = nil
                                }

                        }
//                        .font(.title2)
                        .padding(.top)
                        .padding(.horizontal)
                        HStack(alignment:.top) {
                            ZStack(alignment: .center) {
                                if let poster = viewModel.film?.posterImage {
                                    Image(uiImage: poster)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 200)
                                        .cornerRadius(10)
                                        .padding(.top)
                                        .accessibilityHidden(true)
                                    
                                }
                            }
                            
                        }
                        VStack {
                            
                            Text("\(film.title) (\(film.year))")
                                .font(.title3)
                                .padding(.bottom)
                                .accessibilityLabel(Text("\(film.title). Released in \(film.year)"))
                                .accessibilityAddTraits(.isHeader)
                            
                            Text(film.plot)
                                .font(.callout)
                                .padding(.bottom)
                        }
                        .multilineTextAlignment(.center)
                        VStack(alignment: .leading) {
                            Text(film.genre)
                                .font(.callout)
                            Text("Directed by \(film.director)")
                                .font(.callout)
                            Text("Written by \(film.writer)")
                                .font(.caption)
                            Text("Actors: \(film.actors)")
                                .font(.caption)
                            Text("Box office: \(film.boxOffice)")
                                .font(.subheadline)
                            Text(film.awards)
                                .font(.subheadline)
                        }
                        .multilineTextAlignment(.leading)
                        .padding(.trailing)
                        .padding(.bottom)
                        
                        ScrollView(.horizontal, showsIndicators: true) {
                            LazyHGrid(rows: [GridItem()]) {
                                ForEach(film.ratings) { rating in
                                    VStack {
                                        Text(rating.source)
                                            .fontWeight(.medium)
                                        Text(rating.value)
                                            .fontWeight(.bold)
                                    }
                                    .multilineTextAlignment(.center)
                                    .font(.subheadline)
                                    .foregroundColor(Color.white)
                                    .frame(width: 200, height: 75)
                                    .background(Color.purple)
                                    .cornerRadius(15)
                                    .accessibilityElement(children: .ignore)
                                    .accessibilityAddTraits(.isStaticText)
                                    .accessibilityLabel(Text("\(rating.source) rate. \(rating.value)"))
                                }
                            }
                        }
                        Spacer()
                    }
                }
            }
        }
    }
}

struct FilmDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        FilmDetailsScreen(viewModel: FSViewModel())
            .preferredColorScheme(.light)
    }
}

