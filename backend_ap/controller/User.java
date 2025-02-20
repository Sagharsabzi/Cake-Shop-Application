package controller;

import java.io.*;
import java.util.*;

public class User {
    private String username;
    private String email;
    private String password;
    private String accountType;
    private List<String> wishlist;
    private List<String> cartList;
    private Map<String, Integer> cakeRatings;
    private File profilePicture;
    private List<String> orderedCakes;
    private List<String> savedAddresses;

    public User(String username, String email, String password, String accountType, File profilePicture, List<String> savedAddresses) {
        this.username = username;
        this.email = email;
        this.password = password;
        this.accountType = accountType != null ? accountType : "free";
        this.wishlist = new ArrayList<>();
        this.cartList = new ArrayList<>();
        this.cakeRatings = new HashMap<>();
        this.profilePicture = profilePicture;
        this.orderedCakes = new ArrayList<>();
        this.savedAddresses = savedAddresses != null ? savedAddresses : new ArrayList<>();
    }

    // Getters and Setters
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getAccountType() {
        return accountType;
    }

    public void setAccountType(String accountType) {
        if ("free".equals(accountType) || "premium".equals(accountType)) {
            this.accountType = accountType;
        }
    }

    public List<String> getWishlist() {
        return wishlist;
    }

    public List<String> getCartList() {
        return cartList;
    }

    public Map<String, Integer> getCakeRatings() {
        return cakeRatings;
    }

    public File getProfilePicture() {
        return profilePicture;
    }

    public void setProfilePicture(File profilePicture) {
        this.profilePicture = profilePicture;
    }

    public List<String> getOrderedCakes() {
        return orderedCakes;
    }

    public List<String> getSavedAddresses() {
        return savedAddresses;
    }

    public void addToWishlist(String cakeName) {
        if (!wishlist.contains(cakeName)) {
            wishlist.add(cakeName);
        }
    }

    public void removeFromWishlist(String cakeName) {
        wishlist.remove(cakeName);
    }

    public void addToCart(String cakeName) {
        if (!cartList.contains(cakeName)) {
            cartList.add(cakeName);
        }
    }

    public void removeFromCart(String cakeName) {
        cartList.remove(cakeName);
    }

    public void rateCake(String cakeName, int rating) {
        if (rating >= 1 && rating <= 5) {
            cakeRatings.put(cakeName, rating);
        }
    }

    public void addOrder(String cakeName) {
        orderedCakes.add(cakeName);
    }

    public void clearCart() {
        cartList.clear();
    }

    public void saveUserDataToFile(String filePath) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
            writer.write(this.toString());
            writer.newLine();
        }
    }

    @Override
    public String toString() {
        return username + ",," + email + ",," + password + ",," + accountType + ",," + String.join(";;", savedAddresses);
    }
}
