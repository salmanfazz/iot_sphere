import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wifi_iot/wifi_iot.dart';

import 'device_info.dart';
import 'history.dart';
import 'profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<WifiNetwork?> availableNetworks = [];

  @override
  void initState() {
    super.initState();
    scanWifiNetworks();
  }

  Future<void> scanWifiNetworks() async {
    bool isWifiEnabled = await WiFiForIoTPlugin.isEnabled();

    if (isWifiEnabled) {
      try {
        List<WifiNetwork?> networks = await WiFiForIoTPlugin.loadWifiList();
        setState(() {
          availableNetworks = networks;
        });
      } catch (e) {
        setState(() {
          availableNetworks = [];
        });
        debugPrint("Error saat memuat daftar WiFi: $e");
      }
    } else {
      setState(() {
        availableNetworks = [];
      });
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("WiFi Tidak Aktif"),
          content:
              const Text("Silakan aktifkan WiFi untuk mendeteksi perangkat."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Layout pertama: Background dan Navigasi Atas
            Positioned.fill(
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/background.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(color: Colors.black.withOpacity(0.2)),
                  ),
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
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HistoryPage()),
                            );
                          },
                        ),
                        CustomButton(
                          icon: Icons.home,
                          label: "Beranda",
                          isSelected: true,
                          onPressed: () {},
                        ),
                        CustomButton(
                          icon: Icons.person,
                          label: "Profil",
                          isSelected: false,
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfilePage()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Layout Kedua dengan Daftar WiFi
            Align(
              alignment: Alignment.bottomCenter,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(15)),
                child: Container(
                  height: screenHeight * 0.85,
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '990818280091273',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(
                                    Icons.notifications_active_outlined),
                                onPressed: () {},
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // Aksi QR Code
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                side: const BorderSide(
                                  color: Colors.red,
                                  width: 0.5,
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
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Perangkat Di Sekitar Anda',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          if (availableNetworks.isEmpty)
                            const Center(
                              child: Text(
                                'Tidak ada perangkat WiFi yang terdeteksi.',
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            )
                          else
                            ...availableNetworks.map((network) {
                              return DeviceCard(
                                deviceName: network?.ssid ?? 'Tidak Diketahui',
                                status: 'Available',
                                statusColor: Colors.green,
                                macAddress: network?.bssid ?? 'Tidak Tersedia',
                                security: network?.capabilities ?? 'Unknown',
                                level:
                                    network?.level ?? 0, // Pass signal strength
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DeviceInfoPage(
                                        deviceName:
                                            network?.ssid ?? 'Tidak Diketahui',
                                        macAddress:
                                            network?.bssid ?? 'Tidak Tersedia',
                                        level: network?.level ??
                                            0, // Pass signal strength
                                      ),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
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
  final int level; // Add this to hold the signal strength
  final VoidCallback onTap;

  const DeviceCard({
    super.key,
    required this.deviceName,
    required this.status,
    required this.statusColor,
    required this.macAddress,
    required this.security,
    required this.level, // Accept the signal strength
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
                    const SizedBox(height: 8),
                    Text(
                      'Signal Strength: ${level}dBm', // Show signal strength
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
