import SwiftUI

struct FilmDetailsScreen: View {
    @ObservedObject var viewModel: SearchScreenViewModel
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
                                size: .large) {
                                    print("nothin")
                                }
                            
                            FSBorederedButton(
                                title: "AR Poster",
                                systemImage: "arkit",
                                colour: .purple,
                                size: .large) {
                                    print("arkit")
                                }
                            
//                            Spacer()
                            
                            FSBorederedButton(
                                title: "Back",
                                systemImage: "xmark",
                                colour: .black,
                                size: .large) {
                                    viewModel.film = nil
                                }

                        }
//                        .font(.title2)
                        .padding(.top)
                        .padding(.horizontal)
                        HStack(alignment:.top) {
                            ZStack(alignment: .center) {
                                if let poster = viewModel.posterImage {
                                    Image(uiImage: poster)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 200)
                                        .cornerRadius(10)
                                        .padding(.top)
                                    
                                }
                            }
                            
                        }
                        VStack {
                            
                            Text("\(film.title) (\(film.year))")
                            
                                .font(.title3)
                                .padding(.bottom)
                            
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
        FilmDetailsScreen(viewModel: SearchScreenViewModel())
            .preferredColorScheme(.light)
    }
}

