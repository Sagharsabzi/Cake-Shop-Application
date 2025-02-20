package server;

import java.io.*;
import java.net.*;
import java.sql.*;
import java.util.*;

public class SocketServer {

    private static final int PORT = 12345; 
    private static Connection connection; 
    private static final String USER_FILE = "users.txt";

    public static void main(String[] args) {
        try {

            connection = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/cakeShop", 
                "root", 
                "sssaghar1382" 
            );
            System.out.println("Database connection established!");

            try (ServerSocket serverSocket = new ServerSocket(PORT)) {
                System.out.println("Socket server is running on port " + PORT + "...");

                while (true) {
                    Socket clientSocket = serverSocket.accept();
                    System.out.println("Client connected: " + clientSocket.getInetAddress());
                    new Thread(() -> handleClient(clientSocket)).start();
                }
            }
        } catch (SQLException e) {
            System.err.println("Error connecting to the database: " + e.getMessage());
        } catch (IOException e) {
            System.err.println("Server error: " + e.getMessage());
        }
    }

    private static void handleClient(Socket clientSocket) {
        try (
            BufferedReader in = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
            PrintWriter out = new PrintWriter(clientSocket.getOutputStream(), true);
        ) {
            out.println("Welcome to the server! Available commands: 'users' or 'cakes'");

            String message;
            while ((message = in.readLine()) != null) {
                if (message.equalsIgnoreCase("users")) {

                    List<String> users = fetchUsersFromFile();
                    out.println("User list:");
                    for (String user : users) {
                        out.println(user);
                    }
                } else if (message.equalsIgnoreCase("cakes")) {

                    List<String> cakes = fetchCakesFromDatabase();
                    out.println("Cake list:");
                    for (String cake : cakes) {
                        out.println(cake);
                    }
                } else {
                    out.println("Invalid command! Please send 'users' or 'cakes'.");
                }
            }
        } catch (IOException e) {
            System.err.println("Error communicating with the client: " + e.getMessage());
        } finally {
            try {
                clientSocket.close();
            } catch (IOException e) {
                System.err.println("Error closing client connection: " + e.getMessage());
            }
        }
    }


    private static List<String> fetchUsersFromFile() {
        List<String> users = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(USER_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                users.add(line);
            }
        } catch (IOException e) {
            System.err.println("Error reading user file: " + e.getMessage());
        }
        return users;
    }


    private static List<String> fetchCakesFromDatabase() {
        List<String> cakes = new ArrayList<>();
        String query = "SELECT name, price FROM cakes";
        try (Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(query)) {
            while (resultSet.next()) {
                String name = resultSet.getString("name");
                int price = resultSet.getInt("price");
                cakes.add(name + " - $" + price);
            }
        } catch (SQLException e) {
            System.err.println("Error executing query: " + e.getMessage());
        }
        return cakes;
    }
}
