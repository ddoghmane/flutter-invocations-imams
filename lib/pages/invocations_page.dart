import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InvocationsPage extends StatefulWidget {
  final String imam;

  const InvocationsPage({super.key, required this.imam});

  @override
  State<InvocationsPage> createState() => _InvocationsPageState();
}

class _InvocationsPageState extends State<InvocationsPage> {
  List<dynamic> invocations = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchInvocations();
  }

  Future<void> fetchInvocations() async {
    final uri = Uri.parse(
      "http://localhost:3000/invocations/${Uri.encodeComponent(widget.imam)}",
    );

    final res = await http.get(uri);

    if (res.statusCode == 200) {
      setState(() {
        invocations = json.decode(res.body);
        loading = false;
      });
    } else {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.imam,
          style: const TextStyle(
            color: Color(0xFFE0C084),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),

      body: loading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : ListView.builder(
              itemCount: invocations.length,
              itemBuilder: (context, index) {
                final inv = invocations[index];

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          inv["titre"],
                          style: const TextStyle(
                            color: Color(0xFFE0C084),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),

                        Text(
                          inv["arabe"],
                          textDirection: TextDirection.rtl,
                          style: const TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          inv["phonetique"],
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.white70,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          inv["francais"],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
