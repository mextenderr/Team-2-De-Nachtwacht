package com.example.androidappnachtwacht;

import androidx.appcompat.app.AppCompatActivity;

import android.graphics.Color;
import android.os.Bundle;

import com.github.mikephil.charting.charts.LineChart;
import com.github.mikephil.charting.data.Entry;
import com.github.mikephil.charting.data.LineData;
import com.github.mikephil.charting.data.LineDataSet;
import com.github.mikephil.charting.interfaces.datasets.ILineDataSet;
import com.github.mikephil.charting.listener.OnChartGestureListener;
import com.github.mikephil.charting.listener.OnChartValueSelectedListener;

import java.util.ArrayList;

public class chart extends AppCompatActivity {
    private static final String TAG = "chart";
    private LineChart mChart;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_chart);

        mChart = (LineChart) findViewById(R.id.linechart);

       //   mChart.setOnChartGestureListener(chart.this);
       //   mChart.setOnChartValueSelectedListener(chart.this);
       mChart.setDragEnabled(true);
       mChart.setScaleEnabled(false);

        ArrayList<Entry>yValues = new ArrayList<>();
        yValues.add(new Entry(0,60));
        yValues.add(new Entry(1,50));
        yValues.add(new Entry(2,70));
        yValues.add(new Entry(3,30));
        yValues.add(new Entry(4,50));
        yValues.add(new Entry(5,70));
        yValues.add(new Entry(6,20));
        yValues.add(new Entry(7,60));
        yValues.add(new Entry(8,50));
        yValues.add(new Entry(9,70));
        yValues.add(new Entry(10,30));
        yValues.add(new Entry(11,50));
        yValues.add(new Entry(12,70));
        yValues.add(new Entry(13,20));

        LineDataSet Set1= new LineDataSet(yValues,"Data Set 1");

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
