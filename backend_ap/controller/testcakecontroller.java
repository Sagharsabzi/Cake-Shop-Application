package controller;

import java.sql.*;

public class testcakecontroller {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/cakeShop";
    private static final String USER = "root";
    private static final String PASSWORD = "sssaghar1382";

    private Connection connection;

    public testcakecontroller() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(DB_URL, USER, PASSWORD);
            System.out.println("connected succesfully");
        } catch (ClassNotFoundException e) {
            System.out.println("jdbc not found");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("can not connect to database");
            e.printStackTrace();
        }
    }

    public void testUpdateCake() {
        cakescontroller controller = new cakescontroller();

        int testCakeId = 1; 
        int newStock = 20; 
        double newRating = 4.8; 

        controller.updateCakeInDatabase(testCakeId, newStock, newRating);

        String query = "SELECT stock, rating FROM cakes WHERE id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, testCakeId);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                int updatedStock = resultSet.getInt("stock");
                double updatedRating = resultSet.getDouble("rating");

                if (updatedStock == newStock && updatedRating == newRating) {
                    System.out.println("cake info updated");
                } else {
                    System.out.println("coudlnt update");
                }
            } else {
                System.out.println("couldnt find the cake");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        testcakecontroller test = new testcakecontroller();
        test.testUpdateCake();
    }
}
