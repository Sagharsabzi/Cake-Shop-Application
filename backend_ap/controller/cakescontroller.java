package controller;

import java.sql.*;

public class cakescontroller {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/cakeShop";
    private static final String USER = "root";
    private static final String PASSWORD = "sssaghar1382";

    private Connection connection;

    public cakescontroller() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            connection = DriverManager.getConnection(DB_URL, USER, PASSWORD);
            System.out.println(" connected successfully");
        } catch (ClassNotFoundException e) {
            System.out.println(" jdbc couldnt find ");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println(" couldnt connect to db ");
            e.printStackTrace();
        }
    }

    public void updateCakeInDatabase(int id, int stock, double rating) {
        String query = "UPDATE cakes SET stock = ?, rating = ? WHERE id = ?";
        
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, stock);
            preparedStatement.setDouble(2, rating);
            preparedStatement.setInt(3, id);

            int rowsUpdated = preparedStatement.executeUpdate();
            if (rowsUpdated > 0) {
                System.out.println("cake info updated");
            } else {
                System.out.println("no changes have been done.");
            }
        } catch (SQLException e) {
            System.out.println(" error in updating data");
            e.printStackTrace();
        }
    }

    public void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
                System.out.println("   connection to db has been closed.");
            }
        } catch (SQLException e) {
            System.out.println(" error in closing connection to db   ");
            e.printStackTrace();
        }
    }

}
