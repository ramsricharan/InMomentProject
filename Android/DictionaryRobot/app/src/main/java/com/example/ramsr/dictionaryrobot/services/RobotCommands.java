package com.example.ramsr.dictionaryrobot.services;

import android.util.Log;

import com.example.ramsr.dictionaryrobot.interfaces.RobotServices;
import com.example.ramsr.dictionaryrobot.interfaces.SearchEventInterface;
import com.example.ramsr.dictionaryrobot.model.LogLevel;
import com.example.ramsr.dictionaryrobot.model.RobotResponse;
import com.example.ramsr.dictionaryrobot.model.ResourceStrings;
import com.example.ramsr.dictionaryrobot.model.SearchResults;
import com.example.ramsr.dictionaryrobot.utils.Utilities;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

public class RobotCommands {

    private static RobotServices robotServices;
    private static Boolean isFrontSearch;
    private static SearchEventInterface searchEventInterface;
    private static Call<RobotResponse> call;


    public RobotCommands(SearchEventInterface instance){
        Retrofit retrofit = new Retrofit.Builder()
                .baseUrl(ResourceStrings.BASE_URL).addConverterFactory(GsonConverterFactory.create())
                .build();
        robotServices = retrofit.create(RobotServices.class);
        searchEventInterface = instance;
    }



    // Cancel the ongoing search
    public void cancelSearch()
    {
        call.cancel();
    }

    // Start the searching process
    public void searchForKeyword(final String keyword)
    {
        // Check best side to start the search
        isFrontSearch = Utilities.isFrontSearch(keyword);

        if(LogLevel.I) Log.i(ResourceStrings.TAG, "Started searching for the word " + keyword);
        if(LogLevel.D) Log.d(ResourceStrings.TAG, "Is it a front search? " + isFrontSearch);

        // Start calling API's
        call = isFrontSearch ? robotServices.jumpToFirstPage() : robotServices.jumpToLastPage();

        call.enqueue(new Callback<RobotResponse>() {
            @Override
            public void onResponse(Call<RobotResponse> call, Response<RobotResponse> response) {

                if(isFrontSearch)
                    RobotCommands.jumpToLastTermAndSearch(keyword);
                else
                    RobotCommands.jumpToFirstTermAndSearch(keyword);
            }

            @Override
            public void onFailure(Call<RobotResponse> call, Throwable t) {
                // Error occurred
                RobotCommands.errorOccurred(call);
            }
        });

    }



    private static void  jumpToFirstTermAndSearch(final String keyword)
    {
        if(LogLevel.D) Log.d(ResourceStrings.TAG, "Inside jumpToFirstTermAndSearch()");

        call =  robotServices.jumpToFirstTerm();
        call.enqueue(new Callback<RobotResponse>() {
            @Override
            public void onResponse(Call<RobotResponse> call, Response<RobotResponse> response) {

                RobotResponse model = response.body();
                if(LogLevel.D) Log.d(ResourceStrings.TAG, "Current First term is " + model.getCurrentTerm());

                int compareScore = model.getCurrentTerm().compareTo(keyword);

                if(LogLevel.D) Log.d(ResourceStrings.TAG, "Current Compare Score is " + compareScore);
                if(compareScore == 0)
                {
                    // This is the word that we want
                    RobotCommands.searchCompleted( model.getCurrentTerm(), model.getCurrentTermDefinition());
                }
                else if(compareScore < 0)
                {
                    // Required term is present on this page
                    if(LogLevel.D) Log.d(ResourceStrings.TAG, "The required word could be on this page, current term is: " + response.body().getCurrentTerm());
                    RobotCommands.checkCurrentPageForTerm(keyword);
                }
                else
                {
                    // Go to next page and search
                    if(model.getHasPreviousPage())
                        RobotCommands.moveToPage(keyword);
                    else
                    {
                        // Reached to the first page and no more previous pages left to search
                        if(LogLevel.D) Log.d(ResourceStrings.TAG, ResourceStrings.LOG_OUT_OF_PAGES);
                        RobotCommands.searchCompleted();
                    }
                }
            }

            @Override
            public void onFailure(Call<RobotResponse> call, Throwable t) {
                // Error occurred
                RobotCommands.errorOccurred(call);
            }
        });
    }



    // Jump to the last term of the page and check for match
    // then decide where to go next to fetch the required term
    private static void jumpToLastTermAndSearch(final String keyword)
    {
        if(LogLevel.D) Log.d(ResourceStrings.TAG, "Inside jumpToLastTermAndSearch()");

        call = robotServices.jumpToLastTerm();
        call.enqueue(new Callback<RobotResponse>() {
            @Override
            public void onResponse(Call<RobotResponse> call, Response<RobotResponse> response) {
                RobotResponse model = response.body();

                int compareScore = model.getCurrentTerm().compareTo(keyword);
                if(LogLevel.D) Log.d(ResourceStrings.TAG, "Current Compare Score is " + compareScore);

                if(compareScore == 0)
                {
                    // This is the word that we want
                    RobotCommands.searchCompleted(model.getCurrentTerm(), model.getCurrentTermDefinition());
                }
                else if(compareScore > 0)
                {
                    // Keyword is present before the current term in the dictionary
                    // Check for the keyword in the entire page.
                    if(LogLevel.D) Log.d(ResourceStrings.TAG, "The required word could be on this page, current term is: " + response.body().getCurrentTerm());
                    RobotCommands.checkCurrentPageForTerm(keyword);
                }
                else
                {
                    // Goto next page and search
                    if(model.getHasNextPage())
                        RobotCommands.moveToPage(keyword);
                    else {
                        // Reached to the end of dictionary but word not found
                        if(LogLevel.D) Log.d(ResourceStrings.TAG, ResourceStrings.LOG_OUT_OF_PAGES);
                        RobotCommands.searchCompleted();
                    }
                }
            }

            @Override
            public void onFailure(Call<RobotResponse> call, Throwable t) {
                // Error occurred
                RobotCommands.errorOccurred(call);
            }
        });
    }



    // Move to next/previous page based on the search direction and
    // then jumps to the last or first term based on the search direction
    private static void moveToPage(final String keyword)
    {
        call = isFrontSearch ? robotServices.moveToNextPage() : robotServices.moveToPreviousPage();

        call.enqueue(new Callback<RobotResponse>() {
            @Override
            public void onResponse(Call<RobotResponse> call, Response<RobotResponse> response) {
                if(isFrontSearch)
                    RobotCommands.jumpToLastTermAndSearch(keyword);
                else
                    RobotCommands.jumpToFirstTermAndSearch(keyword);
            }

            @Override
            public void onFailure(Call<RobotResponse> call, Throwable t) {
                // Error occurred
                RobotCommands.errorOccurred(call);
            }
        });
    }



    // Search all the terms within a page functions
    // This function calls itself recursively until it either finds the word
    // or reaches the end/start of the page.
    private static void checkCurrentPageForTerm(final String keyword)
    {
        call = isFrontSearch ? robotServices.moveToPreviousTerm() : robotServices.moveToNextTerm();

        call.enqueue(new Callback<RobotResponse>() {
            @Override
            public void onResponse(Call<RobotResponse> call, Response<RobotResponse> response) {
                RobotResponse model = response.body();
                if(LogLevel.D) Log.d(ResourceStrings.TAG, "Dealing with the Current term: " + model.getCurrentTerm());

                if(keyword.equalsIgnoreCase(model.getCurrentTerm()))
                {
                    RobotCommands.searchCompleted(model.getCurrentTerm(), model.getCurrentTermDefinition());
                }
                else
                {
                    if(isFrontSearch && model.getHasPreviousTerm())
                        // Go to previous term if there is any
                        RobotCommands.checkCurrentPageForTerm(keyword);

                    else if(!isFrontSearch && model.getHasNextTerm())
                        // Go to next term if there is any
                        RobotCommands.checkCurrentPageForTerm(keyword);

                    else
                        // Reached to the beginning or end of the page but term not found
                        RobotCommands.searchCompleted();
                }
            }

            @Override
            public void onFailure(Call<RobotResponse> call, Throwable t) {
                // Search Failed
                RobotCommands.errorOccurred(call);
            }
        });
    }





    // Use this method overload when search is completed successfully & keyword is found
  private static void searchCompleted(String word, String definition)
  {
      if(LogLevel.I) Log.i(ResourceStrings.TAG, ResourceStrings.LOG_SUCCESS_WITH_RESULTS);
      if(LogLevel.I) Log.i(ResourceStrings.TAG, "The definition is for " + word + " is -> " + definition);

      SearchResults results = new SearchResults(word, definition, true);
      searchEventInterface.searchCompleted(results);
  }


  // Use this method overload when search is completed successfully but no results are obtained
  private static void searchCompleted()
  {
      if(LogLevel.I) Log.i(ResourceStrings.TAG, ResourceStrings.LOG_SUCCESS_WITH_NO_RESULTS);

      SearchResults results = new SearchResults("", "", false);
      searchEventInterface.searchCompleted(results);
  }


  private static void errorOccurred(Call<RobotResponse> call)
  {
      if(call.isCanceled())
      {
          // Search Cancelled by user
          if(LogLevel.E) Log.e(ResourceStrings.TAG, ResourceStrings.LOG_USER_CANCEL_SEARCH);
          searchEventInterface.searchCancelled();
      }
      else
      {
          // Search failed due to network error
          if(LogLevel.E) Log.e(ResourceStrings.TAG, ResourceStrings.LOG_NETWORK_ERROR);
          searchEventInterface.networkErrorOccurred();
      }
  }


}
