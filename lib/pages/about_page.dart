import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tentang Aplikasi',
          style: TextStyle(
              color: Colors.white, 
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto'), // Menambahkan font keluarga untuk tampilan yang lebih menarik
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        color: Colors.black87, // Background yang lebih gelap
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tentang MAK NEWS',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                  fontFamily: 'Roboto'), // Menambahkan font keluarga untuk tampilan yang lebih menarik
            ),
            SizedBox(height: 16),
            Text(
              'MAK NEWS adalah aplikasi berita yang menyediakan informasi terkini '
              'dari berbagai sumber terpercaya. Aplikasi ini memungkinkan pengguna '
              'untuk membaca berita terbaru dan populer secara langsung dengan desain '
              'antarmuka yang sederhana dan mudah digunakan.',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontFamily: 'Roboto'), // Menambahkan font keluarga untuk tampilan yang lebih menarik
            ),
            
            SizedBox(height: 16),
            Text(
              'Ki Ageng Nasrokh Mangkunegara Putra',
              style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                  fontFamily: 'Roboto'), // Menambahkan font keluarga untuk tampilan yang lebih menarik
            ),
          ],
        ),
      ),
    );
  }
}
