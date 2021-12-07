//
//  FilmsListScreen.swift
//  FilmStar
//
//  Created by Jakub Gawecki on 07/12/2021.
//

import SwiftUI

struct FilmsListScreen: View {
    @ObservedObject var viewModel: FSViewModel
    @AccessibilityFocusState var isScreenFocused: Bool
    
    var body: some View {
        VStack {
            HStack {
                
                Text("Results for the search")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.purple)
                    .padding(.leading)
                    .accessibilityLabel("Results")
                    .accessibilityAddTraits(.isHeader)
                    .accessibilityHint("Swipe right to go back or to see results")
                    .accessibilityFocused($isScreenFocused)
                    
                Spacer()
                
                FSBorederedButton(
                    title: "",
                    systemImage: "xmark",
                    colour: .yellow,
                    size: .large,
                    isAnimated: false,
                    accessibilityLabel: "Back button",
                    accessibilityHint: "Double tap to go back to the Search Screen or swipe right to see results") {
                        viewModel.listOfFilms.removeAll()
                    }
                    .padding(.horizontal)
            }
            List {
                ForEach(viewModel.listOfFilms) { film in
                    ZStack(alignment: .leading) {
                        HStack {
                            FSImageView(urlString: film.posterUrl)
                                .scaledToFit()
                                .frame(width: 60)
                                .cornerRadius(12)
                            
                            VStack(alignment: .leading) {
                                Text("\(film.title) (\(film.year))")
                                    .font(.headline)
                            }
                            Spacer()
                        }
                        .accessibilityHidden(true)

                    }
                    .frame(width: 350, height: 130, alignment: .center)
                    .cornerRadius(15)
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("\(film.title). Released in \(film.year)")
                    .accessibilityHint("Double tap to go to Film's full details")
                    .contentShape(Rectangle())
                    .accessibilitySortPriority(9)
                    .onTapGesture {
                        viewModel.fetchFilm(with: film.imdbID)
                    }
                }
            }
            .fullScreenCover(item: $viewModel.film, content: { _ in
                FilmDetailsScreen(viewModel: viewModel)
            })
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                isScreenFocused.toggle()
            }
        }

    }
}

struct FilmsListScreen_Previews: PreviewProvider {
    static var previews: some View {
        FilmsListScreen(viewModel: FSViewModel())
    }
}
