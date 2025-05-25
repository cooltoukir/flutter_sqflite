import 'package:flutter/material.dart';
import 'package:flutter_sqflite/presentation/pages/surah_detail_page.dart';
import 'package:get/get.dart';
import '../controllers/quran_controller.dart';

class QuranPage extends StatelessWidget {
  final QuranController controller = Get.find<QuranController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quran'),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.add),
        //     onPressed: () {
        //       controller.insertAllSurahsFromApis();
        //     },
        //   ),
        // ],
      ),
      body: Stack(
        children: [
          Obx(() {
            if (controller.surahs.isEmpty) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
              itemCount: controller.surahs.length,
              itemBuilder: (context, index) {
                final surah = controller.surahs[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      controller.englishToBengaliNumber('${surah.number}'),
                    ),
                  ),
                  title: Text(surah.bengaliName),
                  subtitle: Text(
                    "${surah.bengaliNameTranslation} (${controller.englishToBengaliNumber('${surah.numberOfAyahs}')})",
                  ),
                  trailing: Text(
                    surah.name,
                    style: TextStyle(fontSize: 20, fontFamily: 'QuranFont'),
                  ),
                  onTap: () async {
                    controller.isLoading.value = true;

                    await controller.insertAyahsBySurahFromApis(
                      surahNumber: surah.number,
                    );
                    await controller.loadSurahByNumber(surah.number);

                    controller.isLoading.value = false;

                    Get.to(() => SurahDetailPage(surahNumber: surah.number));
                  },
                );
              },
            );
          }),
          Obx(
            () =>
                controller.isLoading.value
                    ? Container(
                      color: Colors.black.withValues(alpha: 0.4),
                      child: const Center(child: CircularProgressIndicator()),
                    )
                    : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
