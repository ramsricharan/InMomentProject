package com.example.ramsr.dictionaryrobot.controller;

import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.example.ramsr.dictionaryrobot.interfaces.SearchEventInterface;
import com.example.ramsr.dictionaryrobot.model.LogLevel;
import com.example.ramsr.dictionaryrobot.model.ResourceStrings;
import com.example.ramsr.dictionaryrobot.model.SearchResults;
import com.example.ramsr.dictionaryrobot.R;
import com.example.ramsr.dictionaryrobot.services.RobotCommands;
import com.example.ramsr.dictionaryrobot.utils.Utilities;

public class MainActivity extends AppCompatActivity implements SearchEventInterface{

    TextView progressTextView;
    EditText keywordEditText;
    Button searchButton;
    ProgressDialog progressdialog;
    RobotCommands robotCommands;
    long startTime;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        initializeViews();
    }


    // Initialize all the view objects
    private void initializeViews()
    {
        // Initialize Progress dialog
        progressdialog = new ProgressDialog(this);
        progressdialog.setTitle(ResourceStrings.SEARCH_STARTED_TITLE);
        progressdialog.setMessage(ResourceStrings.WAIT_MESSAGE);
        progressdialog.setCancelable(false);
        progressdialog.setButton(DialogInterface.BUTTON_NEGATIVE, "Cancel", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {
                robotCommands.cancelSearch();
            }
        });

        // Initialize progress TextView
        progressTextView = (TextView) findViewById(R.id.progress_TextView);
        progressTextView.setVisibility(View.GONE);

        // Initialize EditText View
        keywordEditText = (EditText) findViewById(R.id.searchKeyword_editText);

        // Setup Search Button
        searchButton = (Button) findViewById(R.id.search_button);
        searchButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                keywordEditText.clearFocus();
                if(!keywordEditText.getText().toString().trim().isEmpty())
                {
                    checkAndSearch();
                }
            }
        });
    }

    // Checks for user input errors & proceeds to search the word if everything is ok
    private void checkAndSearch() {
        String userInput = keywordEditText.getText().toString().trim().toUpperCase();

        if(Utilities.stringContainsNumber(userInput))
            // User input has numbers in it
            Utilities.showDialogWith(this, ResourceStrings.INPUT_ERROR_TITLE, ResourceStrings.ALPHANUMERIC_MESSAGE);

        else if(Utilities.stringContainsSpecialCharacters(userInput))
            // User input has special characters except '-'
            Utilities.showDialogWith(this, ResourceStrings.INPUT_ERROR_TITLE, ResourceStrings.SPECIAL_CHAR_MESSAGE);

        else
            // User input is clean and so proceed to search
            searchTheWord(userInput);
    }



    private void searchTheWord(String keyword) {
        robotCommands = new RobotCommands(this);
        robotCommands.searchForKeyword(keyword);

        startTime = System.currentTimeMillis();

        progressTextView.setVisibility(View.VISIBLE);
        progressdialog.show();
    }


    @Override
    public void searchCompleted(SearchResults results) {
        progressdialog.dismiss();
        progressTextView.setVisibility(View.GONE);

        if(LogLevel.I) Log.i(ResourceStrings.TAG, Utilities.getTimeElapsedString(startTime));

        if(results.getSearchResponse())
        {
            keywordEditText.setText("");
            Fragment_SearchResults resultsFragment = Fragment_SearchResults.newInstance(results.getKeyword(), results.getDefinition());
            getSupportFragmentManager().beginTransaction().add(R.id.Root_Frame, resultsFragment).addToBackStack(null).commit();
        }
        else
        {
            // Word not found
            Utilities.showDialogWith(this, ResourceStrings.WORD_NOT_FOUND_TITLE, ResourceStrings.WORD_NOT_FOUND_MESSAGE);
        }
    }

    @Override
    public void networkErrorOccurred() {
        progressdialog.dismiss();
        progressTextView.setVisibility(View.GONE);
        Utilities.showDialogWith(this, ResourceStrings.NETWORK_ERROR_TITLE, ResourceStrings.NETWORK_ERROR_MESSAGE);
    }

    @Override
    public void searchCancelled() {
        progressTextView.setVisibility(View.GONE);
        Toast.makeText(this,  ResourceStrings.SEARCH_CANCELLED, Toast.LENGTH_SHORT).show();
    }
}
