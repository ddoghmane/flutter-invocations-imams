import 'package:flutter/material.dart';
import 'invocations_page.dart';

class ImamsPage extends StatelessWidget {
  const ImamsPage({super.key});

  final List<String> imams = const [
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Les Maîtres Spirituels",
          style: TextStyle(
            color: Color(0xFFE0C084),
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: ListView.builder(
        itemCount: imams.length,
        itemBuilder: (context, index) {
          final imam = imams[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
              trailing: const Icon(Icons.arrow_forward, color: Colors.white),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => InvocationsPage(imam: imam),
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
