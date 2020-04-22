package com.example.androidappnachtwacht;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.os.Handler;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ThemedSpinnerAdapter;
import android.widget.Toast;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.Socket;
import java.net.UnknownHostException;

public class MainActivity extends AppCompatActivity implements View.OnClickListener {

    static Thread sent;
    static Socket socket;
    private EditText data;
    private Button ToAlarmButton;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        Button sendDataButton = findViewById(R.id.sendDataButton);

        ToAlarmButton = findViewById(R.id.ToAlarm);
        ToAlarmButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                toAlarmActivity();
            }
        });





        data = findViewById(R.id.sendDataBox);

        sendDataButton.setOnClickListener(this);

    }

    private void toAlarmActivity() {
        Intent intent = new Intent(this, Alarm.class);
        startActivity(intent);
    }


    @Override
    public void onClick(View view) {
        switch ( view.getId() ) {
            case R.id.sendDataButton:
                sendMessage(data.getText().toString());
                break;
        }



    }

    private void sendMessage(final String msg) {
        sent = new Thread(new Runnable() {
            @Override
            public void run() {
                try {
                    System.out.println("Connecting to server...");
                    socket = new Socket("192.168.8.31", 4567);
                    System.out.println("---Connected to server!---");

                } catch (UnknownHostException e1) {
                    e1.printStackTrace();
                } catch (IOException e2) {
                    e2.printStackTrace();
                }

                try {
                    PrintWriter out = new PrintWriter(socket.getOutputStream(), true);

                    out.print(msg);
                    out.flush();

                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        });

        sent.start();

    }

}
