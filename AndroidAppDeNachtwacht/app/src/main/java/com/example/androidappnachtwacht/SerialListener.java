package com.example.androidappnachtwacht;

public interface SerialListener {
    void onSerialRead(byte[] data);
    void onConnectingFailed();
    void onDisconnectingFailed();
    void onConnectionSucces();
    void test(String test);
}
