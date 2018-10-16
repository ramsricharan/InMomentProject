package com.example.ramsr.dictionaryrobot.model;

public class ResourceStrings {

    // LOG Messages
    public static final String TAG = "My Log Message";
    public static final String LOG_NETWORK_ERROR = "Network error occurred. Unable to fetch the results";
    public static final String LOG_USER_CANCEL_SEARCH = "Search stopped - User cancelled the search";
    public static final String LOG_SUCCESS_WITH_RESULTS = "Search Completed Successfully - Found the definition for the given word";
    public static final String LOG_SUCCESS_WITH_NO_RESULTS = "Search Completed Successfully - But no such word is found in the dictionary";
    public static final String LOG_OUT_OF_PAGES = "No more pages left to search for the given word";


    // Toast Messages
    public static final String SEARCH_CANCELLED = "Your ongoing search has been cancelled";

    // Progress Dialog
    public static final String SEARCH_STARTED_TITLE = "Searching the dictionary";
    public static final String WAIT_MESSAGE = "Please wait...";

    // Alert Titles
    public static final String INPUT_ERROR_TITLE = "Input Error - Cannot search the word.";
    public static final String WORD_NOT_FOUND_TITLE = "Cannot find the word";
    public static final String NETWORK_ERROR_TITLE = "Network Error Occurred";

    // Alert Messages
    public static final String ALPHANUMERIC_MESSAGE = "The keyword you have entered contains numbers in it. Please correct the input and try again.";
    public static final String SPECIAL_CHAR_MESSAGE = "The keyword you have entered contains special characters in it. Please correct the input and try again.";
    public static final String WORD_NOT_FOUND_MESSAGE = "Unable to find the definition for the word you entered.";
    public static final String NETWORK_ERROR_MESSAGE = "Unable to fetch the definition for the term at this moment due network issues. Please try again later.";


    // API Strings
    public static final String BASE_URL = "https://oke5yaeave.execute-api.us-west-2.amazonaws.com/prod/";
    public static final String API_HEADER = "x-api-key: dIRiOMwrJ57m6V6lOINoQ7cy0uR5TLho3ZYB9f0U";
    public static final String JUMP_TO_FIRST_PAGE_URL = "jump-to-first-page";
    public static final String JUMP_TO_LAST_PAGE_URL = "jump-to-last-page";
    public static final String MOVE_TO_NEXT_PAGE_URL = "move-to-next-page";
    public static final String MOVE_TO_PREVIOUS_PAGE_URL = "move-to-previous-page";

    public static final String JUMP_TO_FIRST_TERM_URL = "jump-to-first-term";
    public static final String JUMP_TO_LAST_TERM_URL = "jump-to-last-term";
    public static final String MOVE_TO_NEXT_TERM_URL = "move-to-next-term";
    public static final String MOVE_TO_PREVIOUS_TERM_URL = "move-to-previous-term";

}
