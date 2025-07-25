import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AIConsultationView extends StatefulWidget {
  @override
  State<AIConsultationView> createState() => _AIConsultationViewState();
}

class _AIConsultationViewState extends State<AIConsultationView> {
  final TextEditingController questionController = TextEditingController();
  String aiAnswer = '';
  bool isLoading = false;

  void askAI() async {
    setState(() {
      isLoading = true;
      aiAnswer = '';
    });
    await Future.delayed(Duration(seconds: 2)); // Simulasi loading
    setState(() {
      aiAnswer =
          'Ini adalah jawaban AI (dummy) untuk: "${questionController.text}"';
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Color(0xFF181F2B)),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'AI Consultation',
          style: TextStyle(
            color: Color(0xFF181F2B),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ask anything about your finance:',
              style: TextStyle(fontSize: 16, color: Color(0xFF181F2B)),
            ),
            SizedBox(height: 16),
            TextField(
              controller: questionController,
              decoration: InputDecoration(
                hintText: 'Type your question... ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Color(0xFFDEE3EB)),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              minLines: 1,
              maxLines: 3,
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading || questionController.text.isEmpty
                    ? null
                    : askAI,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2563EB),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: isLoading
                    ? SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      )
                    : Text(
                        'Ask AI',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
              ),
            ),
            SizedBox(height: 32),
            if (aiAnswer.isNotEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  aiAnswer,
                  style: TextStyle(fontSize: 16, color: Color(0xFF181F2B)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
