//
//  FSString.swift
//  FilmStar
//
//  Created by Jakub Gawecki on 08/12/2021.
//

import Foundation

enum FSImage {
    static let logoSearchScreen = "LogoSearchScreen"
}

enum SFSymbol {
    static let search = "magnifyingglass"
    static let favourite = "star.fill"
    static let notFavourite = "star"
    static let recent = "clock.fill"
    static let film = "film"
    static let close = "xmark"
    static let arkit = "arkit"
    static let settings = "gearshape.fill"
    static let dice = "dice"
    static let checkmark = "checkmark"
    static let restart = "restart.circle"
}


enum FSString {
    static let notApplicable = "N/A"
    static let arPoster = "AR Poster"
    static let save = "Save"
    static let saved = "Saved"
    static let somethingWentWrong = "Something went wrong. Please try again."
    static let back = "Back"
    static let resultsForTheSearch = "Results for the search"
    static let textFieldPlaceholder = "Search for film.."
    static let luckyShot = "Lucky shot"
    static let getTheList = "Get the list"
    static let search = "Search"
    static let favourites = "Favourites"
    static let favouriteFilms = "Favourite Films"
    static let gotIt = "Got it!"
    static let titleUnknown = "Title unknown"
    static let genreUnknown = "Genre unknown"
    static let resetSettings = "Reset settings"
    static let done = "Done"
    static let searchFilters = "Search filters"
}

typealias FSDescription = FSString

enum FSOperationalString {
    static let appStorageShouldShowOnboarding = "shouldShowOnboarding"
}

enum FSAccessibilityString {
    static let swipeDownForMoreInfoHint = "Swipe down for more info"
    static let swipeDownForThePlotHint = "Swipe down for the plot."
    static let goBack = "Go back."
    static let arPoster = "A R Poster"
    static let arExperienceNotFriendlyHint = "A R Experience is not accessibility-friendly. We apologise for the incovienience."
    static let saveToFavourites = "Save to favourites"
    static let saveToFavouritesHint = "Double tap to add Film to your favourites"
    static let resultsForTheSearch = "Results"
    static let swipeRightForResultsHint = "Swipe right to go back or to see results"
    static let doubleTapToBackOrSwipeRight = "Double tap to go back to the Search Screen or swipe right to see results"
    static let doubleTapForFilmDetails = "Double tap to go to Film's full details"
    static let doubleTapForOneFilmSearch = "Double tap to search for one film."
    static let doubleTapForList = "Double tap to search for the list of movies"
    static let doubleTapToCloseOnboarding = "Double tab to finish onboarding process."
    static let swipeDownForCellDetailsOrTapForFull = "Swipe down for more details or double tap to go to Film's full details"
    static let unknown = "unknown"
    static let doubleTapToRemoveFilters = "Double tap to remove all the filters from the search"
    static let doubleTapToConfirmSettings = "Double tap to confirm settings and go back."
    static let favouriteFilmSwipeRightForList = "Favourite Films. Swipe right to get to the list of your favourite Films."
}

typealias VoiceOver = FSAccessibilityString


enum FSOnboardingString {
    static let pageOneTitle = "Search for your favourite films"
    static let pageOneSubtitle = "Search with the title or search with the IMDb ID"
    static let pageOneImage = "mail.and.text.magnifyingglass"
    
    static let pageTwoTitle = "Add films to your favourites"
    static let pageTwoSubtitle = "And check those that you've recently searched for"
    static let pageTwoImage = "star.fill"
    
    static let pageThreeTitle = "Go through an exciting AR experience!"
    static let pageThreeSubtitle = "See how the film's poster will fit above the sofa"
    static let pageThreeImage = "arkit"
}

typealias Onboarding = FSOnboardingString
