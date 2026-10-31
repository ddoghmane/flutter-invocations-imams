import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InvocationsPage extends StatefulWidget {
  final String imam;

  const InvocationsPage({
    super.key,
    required this.imam,
  });

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
      "http://localhost:4000/api/invocations/sheikh/${Uri.encodeComponent(widget.imam)}",
    );

    final res = await http.get(uri);

    if (res.statusCode == 200) {
      setState(() {
        invocations = json.decode(res.body);
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101010),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.imam,
          style: const TextStyle(
            color: Color(0xFFE0C084),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: loading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFE0C084),
              ),
            )
          : invocations.isEmpty
              ? const Center(
                  child: Text(
                    "Aucune invocation trouvée",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: invocations.length,
                  itemBuilder: (context, index) {
                    final inv = invocations[index];

                    final titre =
                        inv["titre"] ??
                        "Invocation";

                    final arabe =
                        inv["arabe"] ??
                        "";

                    final phonetique =
                        inv["phonetique"] ??
                        inv["phonétique"] ??
                        inv["phonetic"] ??
                        "";

                    final traduction =
                        inv["francais"] ??
                        inv["traduction"] ??
                        "";

                    return Card(
                      color: const Color(0xFF1B1B1B),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 6,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              titre,
                              style: const TextStyle(
                                color: Color(0xFFE0C084),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 18),

                            Text(
                              arabe,
                              textDirection:
                                  TextDirection.rtl,
                              style: const TextStyle(
                                fontSize: 28,
                                color: Colors.white,
                                height: 1.8,
                              ),
                            ),

                            const Divider(
                              color: Color(0xFFE0C084),
                              height: 30,
                            ),

                            Text(
                              phonetique,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                              ),
                            ),

                            const SizedBox(height: 14),

                            Text(
                              traduction,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                height: 1.5,
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
