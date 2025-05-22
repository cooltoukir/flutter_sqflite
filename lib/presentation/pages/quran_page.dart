import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/quran_controller.dart';

class QuranPage extends StatelessWidget {
  final QuranController controller = Get.put(QuranController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quran'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              controller.insertAllSurahsFromApis();
            },
          )
        ],
      ),
      body: Obx(() {
        if (controller.surahs.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: controller.surahs.length,
          itemBuilder: (context, index) {
            final surah = controller.surahs[index];
            return ListTile(
              leading: CircleAvatar(
                child: Text(controller.englishToBanglaNumber('${surah.number}')),
              ),
              title: Text(surah.bengaliName),
              subtitle: Text(
                "${surah.bengaliNameTranslation} (${controller.englishToBanglaNumber('${surah.numberOfAyahs}')})",
              ),
              trailing: Text(
                surah.name,
                style: TextStyle(fontSize: 20, fontFamily: 'QuranFont'),
              ),
            );
          },
        );
      }),
    );
  }
}
