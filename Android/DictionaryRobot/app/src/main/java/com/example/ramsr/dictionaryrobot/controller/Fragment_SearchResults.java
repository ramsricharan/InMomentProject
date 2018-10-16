package com.example.ramsr.dictionaryrobot.controller;


import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;

import com.example.ramsr.dictionaryrobot.R;

/**
 * A simple {@link Fragment} subclass.
 * Use the {@link Fragment_SearchResults#newInstance} factory method to
 * create an instance of this fragment.
 */
public class Fragment_SearchResults extends Fragment {
    // the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";

    private String keyword;
    private String definition;


    public Fragment_SearchResults() {
        // Required empty public constructor
    }

    public static Fragment_SearchResults newInstance(String keyword, String definition) {
        Fragment_SearchResults fragment = new Fragment_SearchResults();
        Bundle args = new Bundle();
        args.putString(ARG_PARAM1, keyword);
        args.putString(ARG_PARAM2, definition);
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (getArguments() != null) {
            keyword = getArguments().getString(ARG_PARAM1);
            definition = getArguments().getString(ARG_PARAM2);
        }
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View view =  inflater.inflate(R.layout.fragment_fragment__search_results, container, false);

        TextView keywordTextView = (TextView) view.findViewById(R.id.keyword_textView);
        keywordTextView.setText(keyword);

        TextView definitionTextView = (TextView) view.findViewById(R.id.definition_textView);
        definitionTextView.setText(definition);

        Button backButton = (Button) view.findViewById(R.id.back_button);
        backButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                getActivity().getSupportFragmentManager().popBackStack();
            }
        });


        return view;
    }

}
