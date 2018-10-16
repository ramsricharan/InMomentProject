package com.example.ramsr.dictionaryrobot.model;



public class SearchResults {



    private String keyword;
    private String definition;
    private Boolean isFetched;

    public SearchResults(String keyword, String definition, Boolean isFetched) {
        this.keyword = keyword;
        this.definition = definition;
        this.isFetched = isFetched;
    }

    public String getKeyword() {
        return keyword;
    }

    public String getDefinition() {
        return definition;
    }

    public Boolean getSearchResponse() {
        return isFetched;
    }
}
