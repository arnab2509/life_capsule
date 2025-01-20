import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class PDFPage extends StatefulWidget {
  const PDFPage({super.key});

  @override
  _PDFPageState createState() => _PDFPageState();
}

class _PDFPageState extends State<PDFPage> {
  String? _filePath;
  bool _uploading = false;
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  // Function to pick a PDF file
  Future<void> _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _filePath = result.files.single.path;
      });
    }
  }

  // Function to upload the selected PDF to Firebase Storage
  Future<void> _uploadPDF() async {
    if (_filePath != null && user != null) {
      setState(() {
        _uploading = true;
      });
      
      String fileName = _filePath!.split('/').last;
      File file = File(_filePath!);

      try {
        // Upload PDF to Firebase Storage under the user's folder
        String userId = user!.uid;
        await storage.ref('users/$userId/pdfs/$fileName').putFile(file);

        // Get the download URL of the PDF
        String downloadURL = await storage.ref('users/$userId/pdfs/$fileName').getDownloadURL();

        // Store the download URL in Firestore under the user's documents
        await firestore.collection('users').doc(userId).collection('pdfs').add({'url': downloadURL});

        setState(() {
          _uploading = false;
          _filePath = null;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('PDF uploaded successfully')),
        );
      } catch (e) {
        setState(() {
          _uploading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload PDF: $e')),
        );
      }
    }
  }

  // Function to fetch PDFs from Firestore for the current user
  Future<List<Map<String, dynamic>>> _fetchPDFs() async {
    if (user != null) {
      QuerySnapshot snapshot = await firestore
          .collection('users')
          .doc(user!.uid)
          .collection('pdfs')
          .get();
      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload and View PDF'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: _pickPDF,
              icon: const Icon(Icons.upload_file),
              label: const Text('Upload PDF'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),
          ),
          if (_filePath != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _uploadPDF,
                child: _uploading ? const CircularProgressIndicator() : const Text('Submit PDF'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
              ),
            ),
          const SizedBox(height: 16),
          const Text(
            'Uploaded PDFs:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _fetchPDFs(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  List<Map<String, dynamic>> pdfs = snapshot.data!;
                  return ListView.builder(
                    itemCount: pdfs.length,
                    itemBuilder: (context, index) {
                      String pdfUrl = pdfs[index]['url'];
                      return ListTile(
                        title: Text('PDF ${index + 1}'),
                        subtitle: Text(pdfUrl),
                        trailing: IconButton(
                          icon: const Icon(Icons.open_in_new),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PDFViewerPage(pdfUrl: pdfUrl),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('No PDFs uploaded yet'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PDFViewerPage extends StatelessWidget {
  final String pdfUrl;

  const PDFViewerPage({required this.pdfUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View PDF'),
      ),
      body: PDFView(
        filePath: pdfUrl,
      ),
    );
  }
  Future<void> signInAnonymously() async {
  try {
    await FirebaseAuth.instance.signInAnonymously();
  } catch (e) {
    print("Error signing in: $e");
  }
}

}
