import 'package:flutter/material.dart';
import 'dart:math' as math;

class DeviceInfoPage extends StatefulWidget {
  final String deviceName;
  final String macAddress;
  final int level;
  const DeviceInfoPage({
    Key? key,
    required this.deviceName,
    required this.macAddress,
    required this.level,
  }) : super(key: key);

  @override
  State<DeviceInfoPage> createState() => _DeviceInfoPageState();
}

class _DeviceInfoPageState extends State<DeviceInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // AppBar
          Container(
            color: Colors.red,
            padding:
                const EdgeInsets.only(top: 40, left: 8, right: 8, bottom: 16),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.deviceName, // Ambil nama device dari widget
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "Ruang Tengah lt.1", // Bisa diganti dengan data dinamis
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert, color: Colors.white),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Main Content
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    // Status Message
                    Container(
                      margin: const EdgeInsets.all(8), // Mengurangi margin
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        children: [
                          Text(
                            "Sinyal anda kuat dan dalam kondisi stabil.",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Signal Strength Card
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8), // Hanya margin horizontal
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Sinyal WiFi",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                              height: 8), // Kurangi jarak antara teks dan ikon
                          const Icon(
                            Icons.computer_rounded,
                            size: 24,
                            color: Colors.black87,
                          ),
                          SizedBox(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  height: 120, // Ukuran lingkaran progres
                                  child: CustomPaint(
                                    painter: CircularProgressPainter(
                                      progress: 0.8, // 80% progress for example
                                      backgroundColor: const Color(0xFFEEEEEE),
                                      progressColor: Colors.green,
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      widget.level
                                          .toString(), // Display the actual signal level
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const Text(
                                      'DBM',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Hapus SizedBox di sini agar tidak ada jarak di bawah CircularProgressBar
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F5E9),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              "Kuat",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Test Signal Button
                    Container(
                      margin: const EdgeInsets.all(8), // Mengurangi margin
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.refresh),
                        label: const Text("Tes Ulang Kekuatan Sinyal"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.all(8), // Mengurangi margin
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.refresh),
                        label: const Text("Lihat Solusi Penanganan"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),

                    // WiFi Information
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4), // Lebih rapat
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Informasi Wifi",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8), // Mengurangi jarak
                          _buildInfoRow("Nomor Seri", "261120240015"),
                          _buildInfoRow("MAC", "25:dc:n3:j5:l1:B4"),
                          _buildInfoRow("IP", "128.180.65.12"),
                          _buildInfoRow(
                              "Tanggal Pembuatan", "17/07/2017 17:17"),
                          _buildInfoRow("Bergaransi", "Ya"),
                          _buildInfoRow("Jumlah Port", "16 Port"),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10), // Jarak bawah yang lebih kecil
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// Add this CustomPainter class
class CircularProgressPainter extends CustomPainter {
  final double progress;
  final Color backgroundColor;
  final Color progressColor;

  CircularProgressPainter({
    required this.progress,
    required this.backgroundColor,
    required this.progressColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const radius = 100 / 2;
    const strokeWidth = 18.0;

    // Draw background arc
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi,
      math.pi,
      false,
      backgroundPaint,
    );

    // Draw progress arc
    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi,
      math.pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
