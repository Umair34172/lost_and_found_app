import 'package:flutter/material.dart';
import 'package:lostfound/screens/ChatScreen.dart';

class ItemDetail extends StatefulWidget {
  final String itemTitle;
  final String description;
  final String date;
  final bool isLost;
  final String itemType;
  final String contact;

  const ItemDetail({
    super.key,
    required this.itemTitle,
    required this.description,
    required this.date,
    required this.isLost,
    required this.itemType,
    required this.contact,
  });

  @override
  State<ItemDetail> createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  bool isReturned = false;

  // Helper method to get icon based on item type
  IconData _getItemIcon() {
    switch (widget.itemType.toLowerCase()) {
      case 'keys':
        return Icons.key;
      case 'phone':
        return Icons.phone_android;
      case 'wallet':
        return Icons.wallet;
      case 'pet':
        return Icons.pets;
      case 'headphones':
        return Icons.headphones;
      case 'bag':
        return Icons.backpack;
      case 'laptop':
        return Icons.laptop;
      case 'glasses':
        return Icons.visibility;
      default:
        return Icons.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.itemTitle),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                _getItemIcon(),
                size: 80,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),

            // Title
            Text(
              widget.itemTitle,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Description
            Text(
              widget.description,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),

            // Date
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today, color: Colors.blue),
                  const SizedBox(width: 10),
                  Text(
                    '${widget.isLost ? 'Date Lost' : 'Date Found'}: ${widget.date}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Contact User Button
           /* SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ChatScreen(
                            contactName: widget.isLost ? 'Finder' : 'Owner',

                            // Or use a specific name like:
                            // contactName: 'Jane D',
                          ),
                    ),
                  );

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'CONTACT ${widget.isLost ? 'FINDER' : 'OWNER'}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            */
            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.phone, color: Colors.green),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Contact: ${widget.contact}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Mark Returned Button (only for found items)
            if (!widget.isLost)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isReturned = !isReturned;
                    });
                    // Show confirmation message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          isReturned
                              ? '${widget.itemTitle} marked as returned'
                              : '${widget.itemTitle} marked as not returned',
                        ),
                        backgroundColor: isReturned ? Colors.green : Colors.blue,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isReturned ? Colors.green : Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    isReturned ? 'RETURNED ✓' : 'MARK AS RETURNED',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}