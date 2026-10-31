import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ImamDetailPage extends StatefulWidget {
  final String imam;

  const ImamDetailPage({
    super.key,
    required this.imam,
  });

  @override
  State<ImamDetailPage> createState() => _ImamDetailPageState();
}

class _ImamDetailPageState extends State<ImamDetailPage> {
  Map<String, dynamic>? imamInfo;
  List<dynamic> invocations = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final imamRes = await http.get(
        Uri.parse(
          "http://localhost:4000/api/imams/${Uri.encodeComponent(widget.imam)}",
        ),
      );

      final invocationsRes = await http.get(
        Uri.parse(
          "http://localhost:4000/api/invocations/sheikh/${Uri.encodeComponent(widget.imam)}",
        ),
      );

      setState(() {
        if (imamRes.statusCode == 200) {
          imamInfo = json.decode(imamRes.body);
        }

        if (invocationsRes.statusCode == 200) {
          invocations = json.decode(invocationsRes.body);
        }

        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }

  Widget infoTile(String titre, String valeur) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "$titre : ",
              style: const TextStyle(
                color: Color(0xFFE0C084),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            TextSpan(
              text: valeur,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
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
          : SingleChildScrollView(
              child: Column(
                children: [
                  if (imamInfo != null)
                    Card(
                      color: const Color(0xFF1B1B1B),
                      margin: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              imamInfo!["nom"] ?? "",
                              style: const TextStyle(
                                color: Color(0xFFE0C084),
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 15),

                            infoTile(
                              "Surnom",
                              imamInfo!["surnom"] ?? "",
                            ),

                            infoTile(
                              "Naissance",
                              "${imamInfo!["naissance"] ?? ""}",
                            ),

                            infoTile(
                              "Décès",
                              "${imamInfo!["deces"] ?? ""}",
                            ),

                            infoTile(
                              "Pays",
                              imamInfo!["pays"] ?? "",
                            ),

                            infoTile(
                              "Doctrine",
                              imamInfo!["doctrine"] ?? "",
                            ),

                            infoTile(
                              "Idée principale",
                              imamInfo!["idee_principale"] ?? "",
                            ),

                            infoTile(
                              "Œuvre majeure",
                              imamInfo!["oeuvre_majeure"] ?? "",
                            ),

                            const SizedBox(height: 20),

                            const Text(
                              "Biographie",
                              style: TextStyle(
                                color: Color(0xFFE0C084),
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 12),

                            Text(
                              imamInfo!["biographie"] ?? "",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Invocations",
                      style: TextStyle(
                        color: Color(0xFFE0C084),
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  ...invocations.map((inv) {
                    final titre =
                        inv["titre"] ?? "Invocation";

                    final arabe =
                        inv["arabe"] ?? "";

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

                            const SizedBox(height: 15),

                            Text(
                              arabe,
                              textDirection: TextDirection.rtl,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                height: 1.8,
                              ),
                            ),

                            const Divider(
                              color: Color(0xFFE0C084),
                            ),

                            Text(
                              phonetique,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontStyle: FontStyle.italic,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Text(
                              traduction,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
    );
  }
}
