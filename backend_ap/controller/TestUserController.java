package controller;

public class TestUserController {

    public static void main(String[] args) {
        try {

            UserController userController = new UserController();


            System.out.println("=== Adding Users ===");
            User user1 = new User("Ali", "ali@example.com", "1234", "free", null, null);
            User user2 = new User("Sara", "sara@example.com", "5678", "premium", null, null);
            System.out.println(userController.addUser(user1));
            System.out.println(userController.addUser(user2));

            User user3 = new User("saghar", "saghar@gmail.com", "lvmldkv", "free", null, null);
            userController.addUser(user3);

            System.out.println("=== Adding Duplicate User ===");
            User duplicateUser = new User("Ali", "another@example.com", "abcd", "free", null, null);
            System.out.println(userController.addUser(duplicateUser));


            System.out.println("=== Authenticating User ===");
            System.out.println(userController.authenticateUser("Ali", "1234"));
            System.out.println(userController.authenticateUser("Ali", "wrongpassword")); 
            System.out.println(userController.authenticateUser("NotExists", "1234"));


            System.out.println("=== Updating User ===");
            User updatedUser = new User("Ali", "ali_updated@example.com", "newpassword", "premium", null, null);
            System.out.println(userController.updateUser(updatedUser));


            System.out.println("=== All Users ===");
            System.out.println(userController.getAllUsers());


            System.out.println("=== Deleting User ===");
            System.out.println(userController.deleteUser("Ali"));
            System.out.println(userController.deleteUser("NotExists")); 


            System.out.println("=== All Users After Deletion ===");
            System.out.println(userController.getAllUsers());

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
