import 'package:flutter/material.dart';

class Gallery extends StatelessWidget {
  Gallery({super.key});

  final List<String> photos = [
    'images/brizina milky way.jpg',
    'images/HD-wallpaper-nice-resive-hinata-shouyou-manga-volleyball.jpg',
    'images/hoggar milky way.jpg',
    'images/main_image_stellar_death_s_ring_miri_nircam_sidebyside-5mb.jpg',
    'images/Manipulator_minecraft_steve_holding_a_blossom_in_his_hand_b579eb59-de17-4ad2-b157-91195b778a1a.png',
    'images/moon phases.jpg',
    'images/nebula.jpg',
    'images/poke.jpg',
    'images/wallpaperflare.com_wallpaper.jpg',
  ];

  String extractTitle(String filePath) {
    // Split the filePath by '/' to get the filename
    final parts = filePath.split('/');

    // Get the last part which is the filename
    final fileName = parts.last;

    // Remove the ".jpg" extension from the filename
    final title = fileName.replaceAll(".jpg", "");

    return title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gallery"),
      ),
      body: Material(
        child: GridView.builder(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          padding: const EdgeInsets.all(1),
          itemCount: photos.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemBuilder: ((context, index) {
            return Container(
              padding: const EdgeInsets.all(0.5),
              child: GestureDetector(
                //! when u slect the picture, it will be shown bigger in new page
                onTap: () {
                  final title = extractTitle(photos[index]);
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) {
                        return Scaffold(
                          appBar: AppBar(
                              title: Text(title.isEmpty ? "Gallery" : title)),
                          body: Center(
                            child: Hero(
                              tag: photos[index],
                              child: Image.asset(
                                photos[index],
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                child: Hero(
                    tag: photos[index],
                    child: Image.asset(
                      photos[index],
                      fit: BoxFit.cover,
                    )),
              ),
            );
          }),
        ),
      ),
    );
  }
}
