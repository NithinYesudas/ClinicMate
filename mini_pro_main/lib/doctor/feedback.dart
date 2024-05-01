import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  List<FeedbackItem> feedbackItems = [
    FeedbackItem(
      name: 'John Doe',
      rating: 4,
      feedback:
          'Great service! The doctor was very attentive and professional.',
    ),
    FeedbackItem(
      name: 'Jane Smith',
      rating: 5,
      feedback: 'Excellent experience! The staff was friendly and helpful.',
    ),
    // Add more feedback items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
      ),
      body: ListView.builder(
        itemCount: feedbackItems.length,
        itemBuilder: (context, index) {
          return FeedbackItemWidget(
            feedbackItem: feedbackItems[index],
          );
        },
      ),
    );
  }
}

class FeedbackItem {
  final String name;
  final int rating;
  final String feedback;

  FeedbackItem({
    required this.name,
    required this.rating,
    required this.feedback,
  });
}

class FeedbackItemWidget extends StatelessWidget {
  final FeedbackItem feedbackItem;

  const FeedbackItemWidget({
    required this.feedbackItem,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              feedbackItem.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Row(
              children: List.generate(
                5,
                (index) => Icon(
                  index < feedbackItem.rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Text(feedbackItem.feedback),
          ],
        ),
      ),
    );
  }
}
