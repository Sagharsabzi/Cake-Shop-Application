import 'package:flutter/material.dart';
import 'package:draft_ap/ColorPlate.dart';
import 'package:draft_ap/Logins/UserS.dart'; // فایل UserS برای کلاس User

class SupportChat extends StatefulWidget {
  final User user; // دریافت اطلاعات کاربر

  const SupportChat({Key? key, required this.user}) : super(key: key);

  @override
  _SupportChatState createState() => _SupportChatState();
}

class _SupportChatState extends State<SupportChat> {
  List<Map<String, String>> messages = []; // لیست پیام‌ها
  TextEditingController messageController = TextEditingController(); // کنترلر ورودی پیام

  void sendMessage(String message) {
    if (message.isNotEmpty) {
      setState(() {
        // افزودن پیام کاربر
        messages.add({"sender": widget.user.username, "text": message});
        // پاسخ ادمین
        messages.add({"sender": "Admin", "text": "Your message received!"});
      });
      messageController.clear(); // پاک کردن فیلد ورودی
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Support Chat - ${widget.user.username}", // نمایش نام کاربر
          style: const TextStyle(fontSize: 18),
        ),
        backgroundColor: sandyBrown,
        elevation: 4,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [lightCyan, sandyBrown.withOpacity(0.2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            // بخش نمایش پیام‌ها
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  final isUser = message["sender"] == widget.user.username; // بررسی فرستنده
                  return Align(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        color: isUser ? persianGreen : lightCyan,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment:
                        isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                        children: [
                          Text(
                            message["sender"]!,
                            style: TextStyle(
                              color: isUser ? Colors.white70 : charcoal,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            message["text"]!,
                            style: TextStyle(
                              color: isUser ? Colors.white : charcoal,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // فیلد وارد کردن پیام و دکمه ارسال
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: "Enter your message...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => sendMessage(messageController.text),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: persianGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("Send"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
