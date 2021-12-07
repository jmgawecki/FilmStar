//
//  FilmsListScreen.swift
//  FilmStar
//
//  Created by Jakub Gawecki on 07/12/2021.
//

import SwiftUI

struct FilmsSearchCollectionScreen: View {
    @ObservedObject var viewModel: FSViewModel
    @AccessibilityFocusState var isViewFocused: Bool
    
    var body: some View {
        VStack {
            FilmSearchCollectionTopBar(viewModel: viewModel, isViewFocused: _isViewFocused)
            List {
                ForEach(viewModel.listOfTeasers) { filmTeaser in
                    FilmsSearchCollectionCell(filmTeaser: filmTeaser)
                        .onTapGesture {
                            viewModel.fetchFilm(with: filmTeaser.imdbID)
                        }
                }
            }
            .fullScreenCover(item: $viewModel.film, content: { _ in
                FilmDetailsScreen(viewModel: viewModel)
            })
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                isViewFocused.toggle()
            }
        }
        
    }
}

struct FilmsListScreen_Previews: PreviewProvider {
    static var previews: some View {
        FilmsSearchCollectionScreen(viewModel: FSViewModel())
    }
}

fileprivate struct FilmSearchCollectionTopBar: View {
    @ObservedObject var viewModel: FSViewModel
    @AccessibilityFocusState var isViewFocused: Bool
    
    var body: some View {
        HStack {
            Text("Results for the search")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.purple)
                .padding(.leading)
                .accessibilityLabel("Results")
                .accessibilityAddTraits(.isHeader)
                .accessibilityHint("Swipe right to go back or to see results")
                .accessibilityFocused($isViewFocused)
            
            Spacer()
            
            FSBorederedButton(
                title: "",
                systemImage: "xmark",
                colour: .yellow,
                size: .large,
                accessibilityLabel: "Back button",
                accessibilityHint: "Double tap to go back to the Search Screen or swipe right to see results") {
                    viewModel.listOfTeasers.removeAll()
                }
                .padding(.horizontal)
        }
    }
}

fileprivate struct FilmsSearchCollectionCell: View {
    var filmTeaser: FilmTeaser
    
    var body: some View {
        ZStack(alignment: .leading) {
            HStack {
                FSImageView(urlString: filmTeaser.posterUrl)
                    .scaledToFit()
                    .frame(width: 60)
                    .cornerRadius(12)
                
                VStack(alignment: .leading) {
                    Text("\(filmTeaser.title) (\(filmTeaser.year))")
                        .font(.headline)
                }
                Spacer()
            }
            .accessibilityHidden(true)
            
        }
        .frame(width: 350, height: 130, alignment: .center)
        .cornerRadius(15)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(filmTeaser.title). Released in \(filmTeaser.year)")
        .accessibilityHint("Double tap to go to Film's full details")
        .contentShape(Rectangle())
        .accessibilitySortPriority(9)
    }
}
