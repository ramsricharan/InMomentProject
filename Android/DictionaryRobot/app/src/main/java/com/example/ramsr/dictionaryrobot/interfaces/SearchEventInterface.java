package com.example.ramsr.dictionaryrobot.interfaces;

import com.example.ramsr.dictionaryrobot.model.SearchResults;

public interface SearchEventInterface
{
    void searchCompleted(SearchResults results);
    void networkErrorOccurred();
    void searchCancelled();
}
