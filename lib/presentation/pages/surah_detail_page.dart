import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/quran_controller.dart';

class SurahDetailPage extends StatelessWidget {
  final int surahNumber;
  final QuranController controller = Get.find<QuranController>();

  SurahDetailPage({super.key, required this.surahNumber});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final ayahs = controller.ayahs;
      final surah = controller.selectedSurah.value;

      if (surah == null || ayahs.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Column(
            children: [
              Text(
                surah.bengaliName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "${surah.bengaliRevelationType} | আয়াত সংখ্যা ${controller.englishToBengaliNumber('${surah.numberOfAyahs}')}",
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
        body: ListView.builder(
          itemCount: ayahs.length,
          itemBuilder: (context, index) {
            final ayah = ayahs[index];

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {},
                splashColor: Colors.green.withValues(alpha: 0.2),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        child: Text(
                          controller.englishToBengaliNumber(
                            '${ayah.numberInSurah}',
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          ayah.text,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontSize: 18,
                            fontFamily: 'Amiri',
                          ),
                        ),
                      ),
                      const Divider(color: Colors.grey),
                      // After Arabic text
                      const SizedBox(height: 8),
                      Text(
                        ayah.pronunciationBn,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Divider(color: Colors.grey),
                      // After pronunciationBn
                      const SizedBox(height: 4),
                      Text(
                        ayah.translateBn,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Divider(color: Colors.grey),
                      // After translateBn
                      const SizedBox(height: 4),
                      Text(
                        ayah.translateEn,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
