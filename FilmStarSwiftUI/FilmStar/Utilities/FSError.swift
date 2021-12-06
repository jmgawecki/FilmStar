import Foundation

enum FSError: String, Error {
    case wrongFormat = "Sorry but it seems that you typed the wrong format. Try to pass the film's name or its valid IMDb ID."
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Something went wrong on the server side. Please try again."
    case invalidData = "There was something wrong with the info about the film that we've received. Please try again."
    case unableToFavorites = "Unable to add to favourites. Please try again"
    case inFavorites = "That film is already saved in your favorites 📽"
}
