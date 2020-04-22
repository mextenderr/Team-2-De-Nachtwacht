package com.example.androidappnachtwacht;

import android.media.MediaPlayer;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import androidx.appcompat.app.AppCompatActivity;

public class Alarm extends AppCompatActivity {
    Button alarmbt;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.alarm);
        alarmbt = (Button) findViewById(R.id.ClickNoise);
        final MediaPlayer mp = MediaPlayer.create(this, R.raw.sample);

        alarmbt.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                mp.start();
            }
        });

    }}
