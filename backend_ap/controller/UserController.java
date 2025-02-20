package controller;
import java.io.*;
import java.util.*;

public class UserController {

    private final String filePath = "C:\\Users\\sagha\\Desktop\\dekstop\\codes\\java\\backend_ap\\Database\\users.txt";

    
    private void ensureFileExists() throws IOException {
        File file = new File(filePath);
        if (!file.exists()) {
            file.getParentFile().mkdirs(); 
            file.createNewFile(); 
        }
    }


    public String addUser(User user) throws IOException {
        ensureFileExists(); 

        Scanner scanner = new Scanner(new File(filePath));

        while (scanner.hasNextLine()) {
            String line = scanner.nextLine();
            if (line.startsWith(user.getUsername() + ",,")) { 
                scanner.close();
                return "Username is already taken!";
            }
            if (line.contains(",," + user.getEmail() + ",,")) { 
                scanner.close();
                return "Email is already registered!";
            }
        }


        FileWriter writer = new FileWriter(filePath, true);
        writer.write(user.toString() + "\n");
        writer.close();
        scanner.close();
        return "User added successfully!";
    }


    public String authenticateUser(String username, String password) throws IOException {
        ensureFileExists();

        Scanner scanner = new Scanner(new File(filePath));

        while (scanner.hasNextLine()) {
            String line = scanner.nextLine();
            if (line.startsWith(username + ",,")) { 
                if (line.contains(",," + password + ",,")) { 
                    scanner.close();
                    return "Login successful: " + line;
                } else {
                    scanner.close();
                    return "Incorrect password!";
                }
            }
        }
        scanner.close();
        return "User not found!";
    }


    public String updateUser(User user) throws IOException {
        ensureFileExists();

        Scanner scanner = new Scanner(new File(filePath));
        StringBuilder fileContent = new StringBuilder();

        boolean userFound = false;
        while (scanner.hasNextLine()) {
            String line = scanner.nextLine();
            if (line.startsWith(user.getUsername() + ",,")) {
                fileContent.append(user.toString()).append("\n");
                userFound = true;
            } else {
                fileContent.append(line).append("\n");
            }
        }
        scanner.close();

        if (!userFound) {
            return "User not found!";
        }

        FileWriter writer = new FileWriter(filePath, false);
        writer.write(fileContent.toString());
        writer.close();
        return "User details updated successfully!";
    }


    public String deleteUser(String username) throws IOException {
        ensureFileExists();

        Scanner scanner = new Scanner(new File(filePath));
        StringBuilder fileContent = new StringBuilder();

        boolean userFound = false;
        while (scanner.hasNextLine()) {
            String line = scanner.nextLine();
            if (line.startsWith(username + ",,")) {
                userFound = true;
            } else {
                fileContent.append(line).append("\n");
            }
        }
        scanner.close();

        if (!userFound) {
            return "User not found!";
        }

        FileWriter writer = new FileWriter(filePath, false);
        writer.write(fileContent.toString());
        writer.close();
        return "User deleted successfully!";
    }


    public List<User> getAllUsers() throws IOException {
        ensureFileExists();

        Scanner scanner = new Scanner(new File(filePath));
        List<User> users = new ArrayList<>();

        while (scanner.hasNextLine()) {
            String[] userDetails = scanner.nextLine().split(",,");
            if (userDetails.length >= 4) {
                User user = new User(
                    userDetails[0],
                    userDetails[1],
                    userDetails[2],
                    userDetails[3],
                    null,
                    userDetails.length > 4 ? Arrays.asList(userDetails[4].split(";;")) : new ArrayList<>()
                );
                users.add(user);
            }
        }
        scanner.close();
        return users;
    }


    public String run(String command, String data) throws IOException {
        switch (command) {
            case "addUser":
                String[] addUserDetails = data.split(",,");

                User newUser = new User(
                    addUserDetails[0],
                    addUserDetails[1],
                    addUserDetails[2],
                    "free",
                    null,
                    null
                );
                return addUser(newUser);

            case "authenticateUser":
                String[] loginDetails = data.split(",,");

                return authenticateUser(loginDetails[0], loginDetails[1]);

            case "updateUser":
                String[] updateDetails = data.split("!!!");
                String username = updateDetails[0];
                String[] updatedUserDetails = updateDetails[1].split(",,");

                User updatedUser = new User(
                    username,
                    updatedUserDetails[1],
                    updatedUserDetails[2],
                    updatedUserDetails[3],
                    null,
                    null
                );
                return updateUser(updatedUser);

            case "deleteUser":
                return deleteUser(data);

            case "getAllUsers":
                List<User> users = getAllUsers();
                StringBuilder result = new StringBuilder();

                for (User user : users) {
                    result.append(user.toString()).append("\n");
                }
                return result.toString();

            default:
                return "Invalid command!";
        }
    }
}