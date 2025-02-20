# Cake Shop Application

This project is a **Cake Shop** application developed with a full-stack approach, using **Flutter/Dart** for the front-end (which runs on both **Web** and **Android**), and **Java** for the back-end. The application includes product management, customer orders, and real-time interaction via a **WebSocket** server.

## Features
- **Front-end**: Built using **Flutter** and **Dart** for cross-platform compatibility (Web, Android).
- **Back-end**: Built with **Java**, handling requests, managing product data, and processing transactions.
- **Database**: **MySQL** for managing products, orders, and customer data.
- **WebSocket Server**: Real-time communication between the front-end and back-end, providing instant updates and order tracking.
- **File-based Database Client**: A custom file-based database client developed in **Java** to handle client-side operations.

## Architecture Overview
1. **Front-end**:
   - Developed with **Flutter** and **Dart** for cross-platform compatibility (iOS, Android, Web).
   - User-friendly interface for browsing cakes, placing orders, and tracking the order status.
2. **Back-end**:
   - Developed in **Java**, using **WebSocket** for real-time communication with the front-end.
   - Manages data for cakes, orders, and customer information.
3. **Database**:
   - **MySQL** is used for storing product data, customer information, and order details.
   - Product data (name, price, description, etc.) is stored in the database.
   - A custom **file-based database client** is used for specific client-side functionalities, ensuring smooth interaction with the back-end.
   
## Installation

### Front-end (Flutter/Dart):
1. Install **Flutter** and **Dart** on your machine. [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)
2. Clone the repository and navigate to the **front-end** directory:
   ```bash
   git clone https://github.com/yourusername/cake-shop-app.git
   cd cake-shop-app/front-end
