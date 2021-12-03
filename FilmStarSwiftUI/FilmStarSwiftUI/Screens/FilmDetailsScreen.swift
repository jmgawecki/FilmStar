import SwiftUI

struct FilmDetailsScreen: View {
    @Binding var film: Film
    var body: some View {
        ScrollView(.vertical) {
            ZStack {
                VStack() {
                    HStack(alignment:.top) {
                        ZStack(alignment: .topTrailing) {
                            Rectangle()
                                .frame(width: 250, height: 400)
                            Image(systemName: "star")
                                .font(.title)
                                .foregroundColor(Color.purple)
                                .padding()
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

struct FilmDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        FilmDetailsScreen(film: .constant(Film(
            title: "Guardians of the Galaxy Vol. 2",
            year: "2017",
            rated: "PG-13",
            released: "05 May 2017",
            runtime: "136 min",
            genre: "Action, Adventure, Comedy",
            director: "James Gunn",
            writer: "James Gunn, Dan Abnett, Andy Lanning",
            actors: "Chris Pratt, Zoe Saldana, Dave Bautista",
            plot: "The Guardians struggle to keep together as a team while dealing with their personal family issues, notably Star-Lord's encounter with his father the ambitious celestial being Ego.",
            language: "English",
            country: "United States",
            awards: "Nominated for 1 Oscar. 15 wins & 58 nominations total",
            poster: "https://m.media-amazon.com/images/M/MV5BNjM0NTc0NzItM2FlYS00YzEwLWE0YmUtNTA2ZWIzODc2OTgxXkEyXkFqcGdeQXVyNTgwNzIyNzg@._V1_SX300.jpg",
            ratings: [
                FilmRating(
                    source: "Internet Movie Database",
                    value: "7.6/10"
                ),
                FilmRating(
                    source: "Rotten Tomatoes",
                    value: "85%"
                ),
                FilmRating(
                    source: "Metacritic",
                    value: "67/100"
                )
            ],
            metaScore: "67",
            imdbRating: "7.6",
            imdbVotes: "617,524",
            imdbID: "tt3896198",
            type: "movie",
            boxOffice: "$389,813,101"
        )))
            .preferredColorScheme(.light)
        FilmDetailsScreen(film: .constant(Film(
            title: "Guardians of the Galaxy Vol. 2",
            year: "2017",
            rated: "PG-13",
            released: "05 May 2017",
            runtime: "136 min",
            genre: "Action, Adventure, Comedy",
            director: "James Gunn",
            writer: "James Gunn, Dan Abnett, Andy Lanning",
            actors: "Chris Pratt, Zoe Saldana, Dave Bautista",
            plot: "The Guardians struggle to keep together as a team while dealing with their personal family issues, notably Star-Lord's encounter with his father the ambitious celestial being Ego.",
            language: "English",
            country: "United States",
            awards: "Nominated for 1 Oscar. 15 wins & 58 nominations total",
            poster: "https://m.media-amazon.com/images/M/MV5BNjM0NTc0NzItM2FlYS00YzEwLWE0YmUtNTA2ZWIzODc2OTgxXkEyXkFqcGdeQXVyNTgwNzIyNzg@._V1_SX300.jpg",
            ratings: [
                FilmRating(
                    source: "Internet Movie Database",
                    value: "7.6/10"
                ),
                FilmRating(
                    source: "Rotten Tomatoes",
                    value: "85%"
                ),
                FilmRating(
                    source: "Metacritic",
                    value: "67/100"
                )
            ],
            metaScore: "67",
            imdbRating: "7.6",
            imdbVotes: "617,524",
            imdbID: "tt3896198",
            type: "movie",
            boxOffice: "$389,813,101"
        )))
            .preferredColorScheme(.dark)
    }
}

