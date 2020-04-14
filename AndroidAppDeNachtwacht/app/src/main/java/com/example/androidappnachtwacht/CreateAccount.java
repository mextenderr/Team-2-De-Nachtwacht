package com.example.androidappnachtwacht;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;


public class CreateAccount extends Activity {

    EditText username;
    EditText email;
    EditText name;
    EditText password;
    EditText password2;
    EditText age;
    Button register;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.createaccount_activity_red);

        username = findViewById(R.id.InputFieldMakeUsername);
        email = findViewById(R.id.inputEmail);
        name = findViewById(R.id.inputTextMakeName);
        password = findViewById(R.id.inputFieldMakePassword);
        password2 = findViewById(R.id.inputFieldPassword2);
        age = findViewById(R.id.inputAge);
        register = findViewById(R.id.ButtonMakeAccount);

        register.setOnClickListener((View.OnClickListener) this);


    }

}
