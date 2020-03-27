package com.example.androidappnachtwacht;

import androidx.appcompat.app.AppCompatActivity;

import android.app.Activity;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothSocket;
import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ListView;
import android.widget.TextView;

import com.example.androidappnachtwacht.R;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Set;
import java.util.UUID;

public class BluetoothActivity extends AppCompatActivity {

    static final UUID mUUID = UUID.fromString("00001101-0000-1000-8000-00805F9B34FB");
    TextView mBlueStatustv;
    Button mConnectBtn, mDisconnectBtn, mGetDataBtn;

    ListView mDataLv;
    ArrayList<String> mArrayList;
    ArrayAdapter<String> mArrayAdapter;

    BluetoothAdapter mBlueAdapter;
    BluetoothDevice hc05 = null;
    BluetoothSocket btSocket = null;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_bluetooth);

//        ui elements
        mBlueStatustv = findViewById(R.id.tvBlueStatus);
        mConnectBtn = findViewById(R.id.btnConnect);
        mGetDataBtn = findViewById(R.id.btnGetData);
        mDisconnectBtn = findViewById(R.id.btnDisconnect);
        mDataLv = findViewById(R.id.lvData);

//      List
        mArrayList = new ArrayList<String>();
        mArrayAdapter = new ArrayAdapter<String>(BluetoothActivity.this, android.R.layout.simple_list_item_1, mArrayList);
        mDataLv.setAdapter(mArrayAdapter);

//      bluetooth adapter
        mBlueAdapter = BluetoothAdapter.getDefaultAdapter();


//        events
        mConnectBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                connect();
            }
        });

        mDisconnectBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                disconnect();
            }
        });

        mGetDataBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                getData();
            }
        });




        System.out.println(mBlueAdapter.getBondedDevices());

        Set<BluetoothDevice> bluetoothDevices = mBlueAdapter.getBondedDevices();

        Iterator<BluetoothDevice> itr = bluetoothDevices.iterator();


        while(itr.hasNext()){
            BluetoothDevice device = itr.next();
            System.out.println(device.getName());
            if(device.getName().equals("HC-05")){
                hc05 = device;
            }
        }

        if(hc05 == null){
            mBlueStatustv.setText("Device not found");
            mConnectBtn.setEnabled(false);
            mDisconnectBtn.setEnabled(false);
            mGetDataBtn.setEnabled(false);
        }


    }


    private  void  connect(){

        int counter = 0;
        do {
            try {
                btSocket = hc05.createRfcommSocketToServiceRecord(mUUID);
                System.out.println(btSocket);
                btSocket.connect();
                System.out.println(btSocket.isConnected() + "connected!");
                mBlueStatustv.setText("Device connected!");
            } catch (IOException e) {
                e.printStackTrace();
            }
            counter++;
        } while (!btSocket.isConnected() && counter < 3);

        if(!btSocket.isConnected()){
            mBlueStatustv.setText("can't connect device");
        }
    }


    private void disconnect(){
        try {
            btSocket.close();
            System.out.println(btSocket.isConnected());
        } catch (IOException e) {
            e.printStackTrace();
        }

        if(!btSocket.isConnected()){
            mBlueStatustv.setText("Device disconnected");
        }
        else{
            mBlueStatustv.setText("Disconnecting failed");
        }
    }

    private void getData(){
        try {
            OutputStream outputStream = btSocket.getOutputStream();
            outputStream.write(48);
            System.out.println("data send");
        } catch (IOException e) {
            e.printStackTrace();
        }

        InputStream inputStream = null;
        byte[] buffer = new byte[256];  // buffer store for the stream
        int bytes; // bytes returned from read()
        try {
            inputStream = btSocket.getInputStream();
            inputStream.skip(inputStream.available());
            System.out.println("data recieving");

            for (int i = 0; i < 26; i++) {

                bytes =  inputStream.read(buffer);
                String message = new String(buffer, 0, bytes);


                mArrayList.add(message);

            }
            mArrayAdapter.notifyDataSetChanged();

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
