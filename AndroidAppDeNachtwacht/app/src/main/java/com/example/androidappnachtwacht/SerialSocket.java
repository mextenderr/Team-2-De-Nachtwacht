package com.example.androidappnachtwacht;

import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothSocket;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Handler;
import android.os.Looper;

import java.io.IOException;
import java.io.InputStream;
import java.util.Arrays;
import java.util.Iterator;
import java.util.Set;
import java.util.UUID;
import java.util.concurrent.Executors;

public class SerialSocket implements Runnable{
    BluetoothAdapter mBlueAdapter;
    BluetoothDevice hc05 = null;
    SerialListener listener;
    BluetoothSocket btSocket = null;
    Boolean deviceFound = false;
    Boolean connected = false;
    String teststring = "teststring";



    static final UUID mUUID = UUID.fromString("00001101-0000-1000-8000-00805F9B34FB");

    SerialSocket(SerialListener listener){
        this.listener = listener;
        mBlueAdapter = BluetoothAdapter.getDefaultAdapter();
        Set<BluetoothDevice> bluetoothDevices = mBlueAdapter.getBondedDevices();

        Iterator<BluetoothDevice> itr = bluetoothDevices.iterator();


        while(itr.hasNext()){
            BluetoothDevice device = itr.next();
            System.out.println(device.getName());
            if(device.getName().equals("HC-05")){
                hc05 = device;
                deviceFound = true;
            }
        }

        if(hc05 == null){
            deviceFound = false;
        }
    }

    public void connect(){
        System.out.println("running");
        int counter = 0;
        new Handler(Looper.getMainLooper()).post(
                new Runnable() {
                    @Override
                    public void run() {
                        listener.test(teststring);
                    }
                }
        );
        do {
            try {
                btSocket = hc05.createRfcommSocketToServiceRecord(mUUID);
                System.out.println(btSocket);
                btSocket.connect();
                System.out.println(btSocket.isConnected() + "connected!");
                connected = true;
                new Handler(Looper.getMainLooper()).post(
                        new Runnable() {
                            @Override
                            public void run() {
                                listener.onConnectionSucces();
                            }
                        }
                );

            } catch (IOException e) {
                e.printStackTrace();
            }
            counter++;
        } while (!btSocket.isConnected() && counter < 10);

        if(!btSocket.isConnected()){
            new Handler(Looper.getMainLooper()).post(
                    new Runnable() {
                        @Override
                        public void run() {
                            listener.onConnectingFailed();
                        }
                    }
            );
            connected = false;
        }
    }

    public void disconnect(){
        try {
            btSocket.close();
            System.out.println(btSocket.isConnected());
        } catch (IOException e) {
            e.printStackTrace();
        }

        if(!btSocket.isConnected()){
            connected = false;
        }
        else{
            connected = true;
        }
    }
    public void run(){
        InputStream inputStream = null;
        byte[] buffer = new byte[1024];  // buffer store for the stream
        int bytes;
        int len;// bytes returned from read()
        Handler handler = new Handler(Looper.getMainLooper());
        try {
            while(true) {
                len = btSocket.getInputStream().read(buffer);
                final byte[] data = Arrays.copyOf(buffer, len);
                handler.post(new Runnable() {
                    @Override
                    public void run() {
                        listener.onSerialRead(data);
                    }
                });

            }

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
