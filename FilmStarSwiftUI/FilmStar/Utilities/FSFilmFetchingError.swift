import Foundation

/// `FSFilmFetchingError` provides user-friendly information for an unsuccessful data fetch.
enum FSFilmFetchingError: String, Error {
    case wrongFormat = "Sorry but it seems that you typed the wrong format. Try to pass the film's name or its valid IMDb ID."
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Something went wrong on the server side. Please try again."
    case noDataTitleID = "Sorry, no films have been found! Please try again with another name or ID"
    case noDataTitle = "Sorry, no films have been found! Please try again with another name"
    case unableToFavorites = "Unable to add to favourites. Please try again"
    case inFavorites = "That film is already saved in your favorites 📽"
    case titleNotId = "If you are searching for a movie with the IMDb ID, please hit the other button!"
}
