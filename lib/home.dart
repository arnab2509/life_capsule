import 'package:flutter/material.dart';
import 'package:life_capsule/pdf.dart';


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Profile and Reports Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/logo.jpg'), // Replace with your profile image
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Your Reports',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Files: 3',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // Reports, Prescription, and Due Prescription buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children:  [
                  GestureDetector(onTap: () {
                     Navigator.push(context,
                   MaterialPageRoute(builder: (context) => PDFPage()));
                  },
                    child: ReportCard(icon: Icons.description, title: 'Reports')),
                  GestureDetector
                  (onTap: () {
                    
                  },
                    child: ReportCard(icon: Icons.assignment, title: 'Prescription')),
                  GestureDetector(onTap: () {
                    
                  },
                    child: ReportCard(icon: Icons.pending_actions, title: 'Due Prescription')),
                ],
              ),
            ),

            // Medication Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SizedBox(height: 16),
                  Text(
                    'Medication',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  MedicationTabs(),
                  SizedBox(height: 16),
                  MedicationCarousel(),
                ],
              ),
            ),

            // Doctor Appointment Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: const [
                  AppointmentBookingCard(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

class ReportCard extends StatelessWidget {
  final IconData icon;
  final String title;

  const ReportCard({required this.icon, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, size: 40, color: Colors.green), // Use green color for icons
        title: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        trailing: IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: () {},
        ),
      ),
    );
  }
}

class MedicationTabs extends StatelessWidget {
  const MedicationTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        MedicationTabButton(text: 'This week', selected: true),
        MedicationTabButton(text: 'This month', selected: false),
        MedicationTabButton(text: 'This year', selected: false),
      ],
    );
  }
}

class MedicationTabButton extends StatelessWidget {
  final String text;
  final bool selected;

  const MedicationTabButton({required this.text, required this.selected, super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: selected ? Colors.white : Colors.black,
        backgroundColor: selected ? Colors.green : Colors.transparent, // Green for selected tabs
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
      ),
      onPressed: () {},
      child: Text(text),
    );
  }
}

class MedicationCarousel extends StatelessWidget {
  const MedicationCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          MedicationItem(name: 'Lexapro', timesToday: '1 time today'),
          MedicationItem(name: 'Gabapentin', timesToday: '3 times today'),
          MedicationItem(name: 'Atorvastatin', timesToday: '3 times tomorrow'),
          MedicationItem(name: 'Codeine', timesToday: '3 times tomorrow'),
        ],
      ),
    );
  }
}

class MedicationItem extends StatelessWidget {
  final String name;
  final String timesToday;

  const MedicationItem({required this.name, required this.timesToday, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(timesToday, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

class AppointmentBookingCard extends StatelessWidget {
  const AppointmentBookingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: AssetImage('assets/doctor.jpg'), // Replace with a doctor's image
              radius: 30,
            ),
            title: const Text('Dr. Steller Kane', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            subtitle: const Text('Heart Surgeon'),
            trailing: IconButton(
              icon: const Icon(Icons.message, color: Colors.green), // Green icon color
              onPressed: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: const [
                    Text('Sat', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('June 09'),
                    Text('03:00 pm'),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Green button
                  ),
                  child: const Text('Book an Appointment'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.green, // Use green for selected items
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}
