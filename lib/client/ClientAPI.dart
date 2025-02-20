import 'dart:io';

class SocketClient {
  late Socket _socket;

  // Connect to the server
  Future<void> connectToServer(String host, int port) async {
    try {
      _socket = await Socket.connect(host, port);
      print('Connected to server $host:$port');
      _socket.listen(
            (data) {
          // Receive response from the server
          print('Server response: ${String.fromCharCodes(data)}');
        },
        onError: (error) {
          print('Error in communication with server: $error');
          disconnect();
        },
        onDone: () {
          print('Connection with the server closed.');
          disconnect();
        },
      );
    } catch (e) {
      print('Error connecting to server: $e');
    }
  }

  // Send a message to the server
  void sendMessage(String message) {
    if (_socket != null) {
      _socket.write(message);
      print('Message sent: $message');
    } else {
      print('No active connection to the server.');
    }
  }

  // Disconnect from the server
  void disconnect() {
    _socket.close();
    print('Connection closed.');
  }
}

void main() async {
  final client = SocketClient();

  // Server address and port
  const String host = 'localhost';
  const int port = 12345;

  // Connect to the server
  await client.connectToServer(host, port);

  // Send user requests
  client.sendMessage('users:COMMAND ARGUMENTS');

  // Send cake requests
  client.sendMessage('cakes:');

  // Close the connection after a delay
  await Future.delayed(Duration(seconds: 5));
  client.disconnect();
}
