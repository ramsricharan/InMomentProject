package com.example.ramsr.dictionaryrobot.interfaces;

import com.example.ramsr.dictionaryrobot.model.ResourceStrings;
import com.example.ramsr.dictionaryrobot.model.RobotResponse;

import retrofit2.Call;
import retrofit2.http.Headers;
import retrofit2.http.POST;

public interface RobotServices
{
    // Robot's Mechanical arms related operations endpoints
    @Headers(ResourceStrings.API_HEADER)
    @POST(ResourceStrings.JUMP_TO_FIRST_PAGE_URL)
    Call<RobotResponse> jumpToFirstPage();

    @Headers(ResourceStrings.API_HEADER)
    @POST(ResourceStrings.JUMP_TO_LAST_PAGE_URL)
    Call<RobotResponse> jumpToLastPage();

    @Headers(ResourceStrings.API_HEADER)
    @POST(ResourceStrings.MOVE_TO_NEXT_PAGE_URL)
    Call<RobotResponse> moveToNextPage();

    @Headers(ResourceStrings.API_HEADER)
    @POST(ResourceStrings.MOVE_TO_PREVIOUS_PAGE_URL)
    Call<RobotResponse> moveToPreviousPage();


    // Robots Camera related operation endpoints
    @Headers(ResourceStrings.API_HEADER)
    @POST(ResourceStrings.JUMP_TO_FIRST_TERM_URL)
    Call<RobotResponse> jumpToFirstTerm();

    @Headers(ResourceStrings.API_HEADER)
    @POST(ResourceStrings.JUMP_TO_LAST_TERM_URL)
    Call<RobotResponse> jumpToLastTerm();

    @Headers(ResourceStrings.API_HEADER)
    @POST(ResourceStrings.MOVE_TO_NEXT_TERM_URL)
    Call<RobotResponse> moveToNextTerm();

    @Headers(ResourceStrings.API_HEADER)
    @POST(ResourceStrings.MOVE_TO_PREVIOUS_TERM_URL)
    Call<RobotResponse> moveToPreviousTerm();

}
