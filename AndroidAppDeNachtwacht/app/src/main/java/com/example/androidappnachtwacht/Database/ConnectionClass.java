package com.example.androidappnachtwacht.Database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class ConnectionClass {

    Connection connection;
    Statement stmt = null;

    String ip = "127.0.0.1";
    String db = "DeNachtwachtDB";


    public String connectionDB() {
        try {
            Class.forName("org.postgresql.Driver");
            String url = "jdbc:postgresql://localhost:5432/DeNachtwachtDB";
            connection = DriverManager.getConnection(url, "postgresql", "grundel21");
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println(e.getMessage());
            //            return e.getMessage();
        }
        if (connection == null) {
            System.out.println("Connection failed!");
        } else {
            System.out.println("Connection established!");

        }
        try {
            stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM users");

            while (rs.next()) {
                int id = rs.getInt("id");
                String gebruikersnaam = rs.getString("gebruikersnaam");
                String password = rs.getString("password");

                System.out.println("Id = " + id);
                System.out.println("Gebruikersnaam = " + gebruikersnaam);
                System.out.println("------------------------");
            }

            rs.close();
            stmt.close();

            return "Class is string";

        } catch (SQLException e) {
            System.out.println("Connection with database failed");
            System.err.println(e.getMessage());
            e.printStackTrace();
            return "Connection with database failed";
        }
    }
}



