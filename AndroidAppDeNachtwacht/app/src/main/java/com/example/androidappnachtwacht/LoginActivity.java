package com.example.androidappnachtwacht;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;


public class LoginActivity extends Activity implements View.OnClickListener{

    EditText username;
    EditText password;
    TextView createAccount;
    Button loginButton;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.login_activity);

        username = findViewById(R.id.InputFieldMakeUsername);
        password = findViewById(R.id.inputFieldMakePassword);
        createAccount = findViewById(R.id.TextBoxCreateAccount);
        loginButton = findViewById(R.id.LoginButton);

        createAccount.setOnClickListener(this);
        loginButton.setOnClickListener(this);
    }

    @Override
    public void onClick(View view) {
        switch ( view.getId() ) {
            case R.id.LoginButton:
                // write code to login


            case R.id.TextBoxCreateAccount:
                // write code to go to create account page
                Intent intent = new Intent(this, CreateAccount.class);
                startActivity(intent);

        }

    }

}
