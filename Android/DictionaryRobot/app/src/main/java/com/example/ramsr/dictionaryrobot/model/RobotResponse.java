package com.example.ramsr.dictionaryrobot.model;

public class RobotResponse {

    private String status;
    private String currentTerm;
    private String currentTermDefinition;
    private Boolean hasNextPage;
    private Boolean hasPreviousPage;
    private Boolean hasNextTerm;
    private Boolean hasPreviousTerm;

    public RobotResponse(String status, String currentTerm, String currentTermDefinition, Boolean hasNextPage, Boolean hasNextTerm, Boolean hasPreviousTerm, Boolean hasPreviousPage) {
        this.status = status;
        this.currentTerm = currentTerm;
        this.currentTermDefinition = currentTermDefinition;
        this.hasNextPage = hasNextPage;
        this.hasNextTerm = hasNextTerm;
        this.hasPreviousTerm = hasPreviousTerm;
        this.hasPreviousPage = hasPreviousPage;
    }

    public String getStatus() {
        return status;
    }

    public String getCurrentTerm() {
        return currentTerm;
    }

    public String getCurrentTermDefinition() {
        return currentTermDefinition;
    }

    public Boolean getHasNextPage() {
        return hasNextPage;
    }

    public Boolean getHasNextTerm() {
        return hasNextTerm;
    }

    public Boolean getHasPreviousTerm() {
        return hasPreviousTerm;
    }

    public Boolean getHasPreviousPage() {
        return hasPreviousPage;
    }

}
