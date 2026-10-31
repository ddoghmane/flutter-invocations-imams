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

    print("=== URL ===");
    print(uri);

    final res = await http.get(uri);

    print("=== STATUS ===");
    print(res.statusCode);

    print("=== BODY ===");
    print(res.body);

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
      appBar: AppBar(
        title: Text(widget.imam),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : invocations.isEmpty
              ? const Center(
                  child: Text(
                    "Aucune invocation trouvée",
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : ListView.builder(
                  itemCount: invocations.length,
                  itemBuilder: (context, index) {
                    final inv = invocations[index];

                    final titre =
                        inv["titre"] ??
                        inv["title"] ??
                        "Invocation";

                    final arabe =
                        inv["arabe"] ??
                        "";

                    final phonetique =
                        inv["phonetique"] ??
                        inv["phonétique"] ??
                        inv["phonetic"] ??
                        "";

                    final francais =
                        inv["francais"] ??
                        inv["traduction"] ??
                        "";

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              titre,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 16),

                            Text(
                              arabe,
                              textDirection: TextDirection.rtl,
                              style: const TextStyle(
                                fontSize: 24,
                              ),
                            ),

                            const SizedBox(height: 12),

                            Text(
                              phonetique,
                              style: const TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                              ),
                            ),

                            const SizedBox(height: 12),

                            Text(
                              francais,
                              style: const TextStyle(
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
