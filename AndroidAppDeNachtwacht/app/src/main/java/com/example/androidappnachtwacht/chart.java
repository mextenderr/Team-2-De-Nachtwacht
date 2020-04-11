package com.example.androidappnachtwacht;

import androidx.appcompat.app.AppCompatActivity;

import android.graphics.Color;
import android.os.Bundle;
import android.util.Log;

import com.github.mikephil.charting.charts.LineChart;
import com.github.mikephil.charting.data.Entry;
import com.github.mikephil.charting.data.LineData;
import com.github.mikephil.charting.data.LineDataSet;
import com.github.mikephil.charting.interfaces.datasets.ILineDataSet;
import com.github.mikephil.charting.listener.OnChartGestureListener;
import com.github.mikephil.charting.listener.OnChartValueSelectedListener;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;

public class chart extends AppCompatActivity {
    private static final String TAG = "chart";
    private LineChart mChart;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_chart);


        mChart = (LineChart) findViewById(R.id.linechart);

        mChart.setDragEnabled(true);
        mChart.setScaleEnabled(false);

        InputStream is = getResources().openRawResource(R.raw.data);
        BufferedReader reader = new BufferedReader(
                new InputStreamReader(is, Charset.forName("UTF-8")));

        String line = "";
        ArrayList<Entry> yValues = new ArrayList<>();
        try {
            while ((line = reader.readLine()) != null) {
                //split by
                String[] tokens = line.split(",");
                yValues.add(new Entry(Integer.parseInt(tokens[0]),Integer.parseInt(tokens[1])));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }


        LineDataSet Set1 = new LineDataSet(yValues, "Data Set 1");

        Set1.setFillAlpha(110);
        Set1.setColor(Color.RED);
        Set1.setLineWidth(3f);
        Set1.setValueTextColor(Color.BLUE);
        Set1.setValueTextSize(10f);
        ArrayList<ILineDataSet> dataSets = new ArrayList<>();
        dataSets.add(Set1);
        LineData data = new LineData(dataSets);
        mChart.setData(data);

    }
    }
