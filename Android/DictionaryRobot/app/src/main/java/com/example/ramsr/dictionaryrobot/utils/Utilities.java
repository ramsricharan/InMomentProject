package com.example.ramsr.dictionaryrobot.utils;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Utilities {

    private Utilities(){}


    public static Boolean isFrontSearch(String keyword)
    {
        int firstCharRank = keyword.toLowerCase().charAt(0) - 'a';
        return firstCharRank < 13;
    }

    public static boolean stringContainsNumber(String s)
    {
        Pattern p = Pattern.compile("[0-9]");
        Matcher m = p.matcher(s);
        return m.find();
    }


    public static boolean stringContainsSpecialCharacters(String s)
    {
        Pattern p = Pattern.compile("[!@#$%&*()_+=|<>?{}\\[\\]~]");
        Matcher m = p.matcher(s);
        return m.find();
    }

    public static String getTimeElapsedString(long tStart)
    {
        long tEnd = System.currentTimeMillis();
        long tDelta = tEnd - tStart;
        double elapsedSeconds = tDelta / 1000.0;
        return "Time taken for search = " + elapsedSeconds + " seconds";
    }

    public static void showDialogWith(Context context, String title, String message)
    {
        AlertDialog.Builder builder1 = new AlertDialog.Builder(context);
        builder1.setTitle(title);
        builder1.setMessage(message);
        builder1.setCancelable(true);

        builder1.setPositiveButton(
                "Okay",
                new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int id) {
                        dialog.cancel();
                    }
                });

        AlertDialog alert11 = builder1.create();
        alert11.show();
    }


}
  