//
//  FilmsListScreen.swift
//  FilmStar
//
//  Created by Jakub Gawecki on 07/12/2021.
//

import SwiftUI

struct FilmsListScreen: View {
    @ObservedObject var viewModel: FSViewModel
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                FSBorederedButton(
                    title: "",
                    systemImage: "xmark",
                    colour: .yellow,
                    size: .large,
                    isAnimated: false,
                    accessibilityLabel: nil,
                    accessibilityHint: nil) {
                        viewModel.listOfFilms.removeAll()
                    }
                    .padding(.horizontal)
            }
            List {
                ForEach(viewModel.listOfFilms) { film in
                    HStack {
                        FSImageView(urlString: film.posterUrl)
                            .scaledToFit()
                            .frame(width: 60)
                            .cornerRadius(12)
                                
                        VStack(alignment: .leading) {
                            Text("\(film.title) (\(film.year))")
                                .font(.headline)
                        }
                    }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            viewModel.fetchFilm(with: film.imdbID)
                        }
                }
//                .onDelete(perform: removeFavouriteFilm)
//                .accessibilityFocused($isScreenFocused)


            }
            .fullScreenCover(item: $viewModel.film) {
                
            } content: { _ in
                FilmDetailsScreen(viewModel: viewModel)
            }

//            .onAppear {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                    isScreenFocused.toggle()
//                }
//            }
        }
    }
}

struct FilmsListScreen_Previews: PreviewProvider {
    static var previews: some View {
        FilmsListScreen(viewModel: FSViewModel())
    }
}
