import 'package:flutter/material.dart';
import 'imam_detail_page.dart';

class ImamsPage extends StatelessWidget {
  const ImamsPage({super.key});

  static const List<String> imams = [
    "Abou Hanifa",
    "Malik ibn Anas",
    "Al-Shafi'i",
    "Ahmad ibn Hanbal",
    "Ibn Arabi",
    "Al-Ghazali",
    "Ibn Ajiba",
    "Ibn Ata Allah",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101010),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Les Maîtres Spirituels",
          style: TextStyle(
            color: Color(0xFFE0C084),
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ListView.builder(
        itemCount: imams.length,
        itemBuilder: (context, index) {
          final imam = imams[index];

          return Card(
            color: const Color(0xFF1B1B1B),
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: ListTile(
              title: Text(
                imam,
                style: const TextStyle(
                  color: Color(0xFFE0C084),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: const Text(
                "Biographie et Invocations",
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              trailing: const Icon(
                Icons.menu_book,
                color: Color(0xFFE0C084),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ImamDetailPage(
                      imam: imam,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
