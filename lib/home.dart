import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gambar untuk layout pertama
          Positioned.fill(
            child: Column(
              children: [
                // Layout pertama: Background image
                Container(
                  height: 100,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/background.png'), // Ganti dengan path gambar Anda
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Layout kedua: Background putih
                Expanded(
                  child: Container(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              // Layout pertama: Navigasi atas
              SizedBox(
                height: 100,
                child: Stack(
                  children: [
                    Positioned(
                      top: 16,
                      left: 16,
                      right: 16,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomButton(
                            icon: Icons.history,
                            label: "Riwayat",
                            isSelected: false,
                            onPressed: () {
                              // Aksi untuk Riwayat
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
                              // Aksi untuk Profil
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Layout kedua: Konten utama
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Informasi Pengguna
                            Row(
                              children: [
                                const CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: Icon(Icons.person,
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
                            // Tombol QR Code dengan panjang simetris
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  // Aksi untuk QR Code
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                ),
                                icon: const Icon(Icons.qr_code_scanner),
                                label: const Text('Sambungkan Dengan QR Code'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Daftar Perangkat
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Perangkat Di Sekitar Anda',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 16),
                            DeviceCard(
                              deviceName: 'IOTSphere-01',
                              status: 'Active',
                              statusColor: Colors.green,
                              macAddress: '25:dc:n3:j5:l1:B4',
                              security: 'WPA2',
                            ),
                            DeviceCard(
                              deviceName: 'IOTSphere-02',
                              status: 'Inactive',
                              statusColor: Colors.red,
                              macAddress: 'B4:25:dc:n3:j5:l1',
                              security: 'WPA2',
                            ),
                            DeviceCard(
                              deviceName: 'SSID-01',
                              status: 'Restarting',
                              statusColor: Colors.orange,
                              macAddress: '25:ln:n3:j5:lm:3',
                              security: 'Open',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
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
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.white : Colors.red.shade800,
        foregroundColor: isSelected ? Colors.red : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        elevation: isSelected ? 6 : 2,
      ),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

// Widget DeviceCard
class DeviceCard extends StatelessWidget {
  final String deviceName;
  final String status;
  final Color statusColor;
  final String macAddress;
  final String security;

  const DeviceCard({
    super.key,
    required this.deviceName,
    required this.status,
    required this.statusColor,
    required this.macAddress,
    required this.security,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              Icons.wifi,
              color: statusColor,
              size: 30,
            ),
            const SizedBox(width: 16),
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
                  Text(
                    status,
                    style: TextStyle(
                      fontSize: 12,
                      color: statusColor,
                    ),
                  ),
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
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(
                  security == 'Open' ? Icons.lock_open : Icons.lock,
                  color: Colors.grey,
                  size: 16,
                ),
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
    );
  }
}
