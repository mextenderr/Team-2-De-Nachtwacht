package com.example.androidappnachtwacht;

import androidx.appcompat.app.AppCompatActivity;

import android.app.Activity;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothSocket;
import android.net.sip.SipSession;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
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
import java.util.Arrays;
import java.util.Iterator;
import java.util.Set;
import java.util.Timer;
import java.util.TimerTask;
import java.util.UUID;

public class BluetoothActivity extends AppCompatActivity implements SerialListener{

    static final UUID mUUID = UUID.fromString("00001101-0000-1000-8000-00805F9B34FB");
    TextView mBlueStatusTv;
    TextView mHeartrateTv;
    Button mConnectBtn, mDisconnectBtn, mGetDataBtn;

    ListView mDataLv;
    ArrayList<String> mArrayList;
    ArrayAdapter<String> mArrayAdapter;

    BluetoothAdapter mBlueAdapter;
    BluetoothDevice hc05 = null;
    BluetoothSocket btSocket = null;
    SerialSocket  socket;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_bluetooth);

//        ui elements
        mBlueStatusTv = findViewById(R.id.tvBlueStatus);
        mConnectBtn = findViewById(R.id.btnConnect);
        mGetDataBtn = findViewById(R.id.btnGetData);
        mDisconnectBtn = findViewById(R.id.btnDisconnect);
        mHeartrateTv = findViewById(R.id.tvHeartrate);
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
                recieveData();
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
            mBlueStatusTv.setText("Device not found");
            mConnectBtn.setEnabled(false);
            mDisconnectBtn.setEnabled(false);
            mGetDataBtn.setEnabled(false);
        }


    }


    private  void  connect(){

            socket = new SerialSocket(this);
            Thread t = new Thread(new Runnable() {
                @Override
                public void run() {
                    socket.connect();
                }
            });
            t.start();

//        int counter = 0;
//        do {
//            try {
//                btSocket = hc05.createRfcommSocketToServiceRecord(mUUID);
//                System.out.println(btSocket);
//                btSocket.connect();
//                System.out.println(btSocket.isConnected() + "connected!");
//                mBlueStatusTv.setText("Device connected!");
//            } catch (IOException e) {
//                e.printStackTrace();
//            }
//            counter++;
//        } while (!btSocket.isConnected() && counter < 3);
//
//        if(!btSocket.isConnected()){
//            mBlueStatusTv.setText("can't connect device");
//        }
    }


    private void disconnect(){
        if(socket != null) {
            socket.disconnect();
        }
            //        try {
//            btSocket.close();
//            System.out.println(btSocket.isConnected());
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//
//        if(!btSocket.isConnected()){
//            mBlueStatusTv.setText("Device disconnected");
//        }
//        else{
//            mBlueStatusTv.setText("Disconnecting failed");
//        }
    }

    private void recieveData(){
        if(socket != null) {
            Thread t = new Thread(socket);
            t.start();
        }
        //        try {
//            OutputStream outputStream = btSocket.getOutputStream();
//            outputStream.write(48);
//            System.out.println("data send");
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//
//        InputStream inputStream = null;
//        byte[] buffer = new byte[1024];  // buffer store for the stream
//        int bytes;
//        int len;// bytes returned from read()
//        try {
//            while(true) {
//                len = btSocket.getInputStream().read(buffer);
//                byte[] data = Arrays.copyOf(buffer, len);
//            }
//
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
    }


    @Override
    public void onSerialRead(byte[] data) {
        mHeartrateTv.setText(new String(data));
    }

    @Override
    public void onConnectingFailed() {
        mBlueStatusTv.setText("can't connect device");
    }

    @Override
    public void onDisconnectingFailed() {
//        mBlueStatusTv.setText("Disconnecting failed");
    }

    @Override
    public void onConnectionSucces() {
        System.out.println("callback");
        mBlueStatusTv.setText("connected!");
    }

    @Override
    public void test(String test){
        mBlueStatusTv.setText(test);
    }

}
