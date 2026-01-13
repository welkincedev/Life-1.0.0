import 'package:flutter/material.dart';
import '../models/book.dart';

class BookDetailsScreen extends StatelessWidget {
  final Book book;
  final VoidCallback? onFavoriteToggle;
  final ValueChanged<String>? onStatusUpdate;
  final bool isEditable;

  const BookDetailsScreen({
    super.key,
    required this.book,
    this.onFavoriteToggle,
    this.onStatusUpdate,
    required this.isEditable,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(book.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                book.image,
                height: 200,
                errorBuilder: (_, __, ___) => const Icon(Icons.book, size: 100),
              ),
            ),
            const SizedBox(height: 16),

            Text(
              book.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(book.author, style: const TextStyle(color: Colors.grey)),

            const SizedBox(height: 12),
            Text(
              book.description.isNotEmpty
                  ? book.description
                  : 'No description available',
            ),

            const Spacer(),

            /// 🔒 Editable actions
            if (isEditable)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      book.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                    ),
                    onPressed: onFavoriteToggle?.call,
                  ),
                  DropdownButton<String>(
                    value: book.readingStatus.isEmpty
                        ? null
                        : book.readingStatus,
                    hint: const Text('Reading status'),
                    items: const [
                      DropdownMenuItem(
                        value: 'Not Started',
                        child: Text('Not Started'),
                      ),
                      DropdownMenuItem(
                        value: 'Reading',
                        child: Text('Reading'),
                      ),
                      DropdownMenuItem(
                        value: 'Completed',
                        child: Text('Completed'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        onStatusUpdate?.call(value);
                      }
                    },
                  ),
                ],
              )
            else
              const Text(
                'Add this book to your shelf to mark as favorite or update reading status.',
                style: TextStyle(color: Colors.grey),
              ),
          ],
        ),
      ),
    );
  }
}
