import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:iot_sphere/device_info.dart';
import 'package:iot_sphere/history.dart';
import 'package:iot_sphere/profile.dart';
import 'package:iot_sphere/scan_qr.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Layout pertama: Background image
            // Layout pertama: Background image dengan blur filter
            Positioned.fill(
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/background.png'), // Ganti dengan path gambar Anda
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(
                        sigmaX: 10.0, sigmaY: 10.0), // Efek blur
                    child: Container(
                      color: Colors.black
                          .withOpacity(0.2), // Warna overlay (opsional)
                    ),
                  ),
                  // Layout pertama: Navigasi atas
                  SizedBox(
                    child: Stack(
                      children: [
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.05,
                          left: 25,
                          right: 25,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomButton(
                                icon: Icons.history,
                                label: "Riwayat",
                                isSelected: false,
                                onPressed: () {
                                  // Aksi untuk Riwayat
                                  Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          HistoryPage(),
                                      transitionDuration: Duration.zero,
                                      reverseTransitionDuration: Duration.zero,
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        return child;
                                      },
                                    ),
                                  );
                                },
                              ),
                              CustomButton(
                                icon: Icons.home,
                                label: "Beranda",
                                isSelected: true,
                                onPressed: () {
                                  // Aksi untuk Beranda
                                },
                              ),
                              CustomButton(
                                icon: Icons.person,
                                label: "Profile",
                                isSelected: false,
                                onPressed: () {
                                  // Aksi untuk pindah ke halaman Home
                                  Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          ProfilePage(),
                                      transitionDuration: Duration.zero,
                                      reverseTransitionDuration: Duration.zero,
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        return child;
                                      },
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Layout kedua dengan border radius
            Align(
              alignment: Alignment.bottomCenter,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(15)),
                child: Container(
                  height:
                      screenHeight * 0.85, // Layout kedua menempati 85% layar
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          // Konten di dalam layout kedua
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.white,
                                child: Icon(Icons.person_2_outlined,
                                    size: 40, color: Colors.red),
                              ),
                              const SizedBox(width: 16),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Baskara Valeandra',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '990818280091273',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(
                                    Icons.notifications_active_outlined,
                                    color: Colors.black),
                                onPressed: () {
                                  // Aksi untuk notifikasi
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ScanQRPage(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                side: const BorderSide(
                                  // Tambahkan properti ini
                                  color: Colors.red, // Warna border
                                  width: 0.5, // Lebar border
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                              ),
                              icon: const Icon(Icons.qr_code_scanner),
                              label: const Text('Sambungkan Dengan QR Code'),
                            ),
                          ),
                          const SizedBox(height: 30),
                          const Align(
                            alignment: Alignment
                                .centerLeft, // Pastikan teks berada di kiri
                            child: Text(
                              'Perangkat Di Sekitar Anda',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.left, // Atur text alignment
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Daftar perangkat
                          DeviceCard(
                            deviceName: 'IOTSphere-01',
                            status: 'Active',
                            statusColor: Colors.green,
                            macAddress: '25:dc:n3:j5:l1:B4',
                            security: 'WPA2',
                            onTap: () => navigateToDevice1(
                                context), // Fungsi navigasi untuk perangkat 1
                          ),
                          DeviceCard(
                            deviceName: 'IOTSphere-02',
                            status: 'Inactive',
                            statusColor: Colors.red,
                            macAddress: 'B4:25:dc:n3:j5:l1',
                            security: 'WPA2',
                            onTap: () => navigateToDevice2(
                                context), // Fungsi navigasi untuk perangkat 2
                          ),
                          DeviceCard(
                            deviceName: 'SSID-01',
                            status: 'Restarting',
                            statusColor: Colors.orange,
                            macAddress: '25:ln:n3:j5:lm:3',
                            security: 'Open',
                            onTap: () => navigateToDevice3(
                                context), // Fungsi navigasi untuk perangkat 3
                          ),
                        ],
                      ),
                    ),
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

void navigateToDevice1(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const DeviceInfoPage(
        deviceName: 'IOTSphere-01',
      ),
    ),
  );
}

void navigateToDevice2(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const DeviceInfoPage(
        deviceName: 'IOTSphere-02',
      ),
    ),
  );
}

void navigateToDevice3(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const DeviceInfoPage(
        deviceName: 'SSID-01',
      ),
    ),
  );
}

// Widget CustomButton
class CustomButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 105, // Lebar tombol tetap
      height: 35, // Tinggi tombol tetap
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.white : const Color(0xFF810303),
          foregroundColor: isSelected ? Colors.red : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: isSelected ? 6 : 2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 6), // Jarak antara ikon dan label
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class DeviceCard extends StatelessWidget {
  final String deviceName;
  final String status;
  final Color statusColor;
  final String macAddress;
  final String security;
  final VoidCallback onTap;

  const DeviceCard({
    super.key,
    required this.deviceName,
    required this.status,
    required this.statusColor,
    required this.macAddress,
    required this.security,
    required this.onTap, // Tambahkan onTap sebagai parameter wajib
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Gunakan fungsi onTap
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Column(
                children: [
                  Icon(
                    Icons.wifi,
                    color: statusColor,
                    size: 30,
                  ),
                  const SizedBox(height: 4), // Jarak antara ikon dan teks
                  Text(
                    status,
                    style: TextStyle(
                      fontSize: 12,
                      color: statusColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                  width: 16), // Jarak antara kolom Wi-Fi dan konten lainnya
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      deviceName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      macAddress,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Icon(
                    security == 'Open' ? Icons.lock_open : Icons.lock_outline,
                    color: Colors.grey,
                    size: 16,
                  ),
                  const SizedBox(width: 4), // Jarak kecil antara ikon dan teks
                  Text(
                    security,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
