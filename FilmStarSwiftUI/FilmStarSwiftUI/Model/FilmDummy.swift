import Foundation


/// Class should be excluded from the production code
enum FilmDummy {
    // MARK: - Static Mocks
    static let mock = Film(
        title: "Guardians of the Galaxy Vol. 2",
        year: "2017",
        released: "05 May 2017",
        genre: "Action, Adventure, Comedy",
        director: "James Gunn",
        writer: "James Gunn, Dan Abnett, Andy Lanning",
        actors: "Chris Pratt, Zoe Saldana, Dave Bautista",
        plot: "The Guardians struggle to keep together as a team while dealing with their personal family issues, notably Star-Lord's encounter with his father the ambitious celestial being Ego.",
        awards: "Nominated for 1 Oscar. 15 wins & 58 nominations total",
        posterUrl: "https://m.media-amazon.com/images/M/MV5BNjM0NTc0NzItM2FlYS00YzEwLWE0YmUtNTA2ZWIzODc2OTgxXkEyXkFqcGdeQXVyNTgwNzIyNzg@._V1_SX300.jpg",
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
        imdbID: "tt3896198",
        boxOffice: "$389,813,101"
    )
    
    static let mockOptional: Film? = Film(
        title: "Guardians of the Galaxy Vol. 2",
        year: "2017",
        released: "05 May 2017",
        genre: "Action, Adventure, Comedy",
        director: "James Gunn",
        writer: "James Gunn, Dan Abnett, Andy Lanning",
        actors: "Chris Pratt, Zoe Saldana, Dave Bautista",
        plot: "The Guardians struggle to keep together as a team while dealing with their personal family issues, notably Star-Lord's encounter with his father the ambitious celestial being Ego.",
        awards: "Nominated for 1 Oscar. 15 wins & 58 nominations total",
        posterUrl: "https://m.media-amazon.com/images/M/MV5BNjM0NTc0NzItM2FlYS00YzEwLWE0YmUtNTA2ZWIzODc2OTgxXkEyXkFqcGdeQXVyNTgwNzIyNzg@._V1_SX300.jpg",
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
        imdbID: "tt3896198",
        boxOffice: "$389,813,101"
    )
}
