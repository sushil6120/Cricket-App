import 'package:flutter/material.dart';

class GroundImagesWidget extends StatefulWidget {
  const GroundImagesWidget({super.key});

  @override
  _GroundImagesWidgetState createState() => _GroundImagesWidgetState();
}

class _GroundImagesWidgetState extends State<GroundImagesWidget> {
  @override
  Widget build(BuildContext context) {
    List<String> images = [
      'https://i0.wp.com/cricketgraph.com/wp-content/uploads/2022/06/Haryana-Cricket-Academy-Ground-2.jpg?fit=720%2C480&ssl=1',
      'https://dhhu8n9celg6x.cloudfront.net/system/assets/files/17126/large/Capture.PNG?1496215747',
      'https://content3.jdmagicbox.com/v2/comp/noida/m5/011pxx11.xx11.240209220643.a7m5/catalogue/nehru-cricket-academy-noida-sports-ground-zs3ja4dua3.jpg',
      'https://content.jdmagicbox.com/comp/kharar/v9/0172px172.x172.200108232230.f6v9/catalogue/fateh-cricket-academy-and-ground-kharar-kharar-cricket-coaching-classes-zbzxtktxz4.jpg',
      'https://i0.wp.com/cricketgraph.com/wp-content/uploads/2022/06/Haryana-Cricket-Academy-Ground-2.jpg?fit=720%2C480&ssl=1',
      'https://dhhu8n9celg6x.cloudfront.net/system/assets/files/17126/large/Capture.PNG?1496215747',
      'https://content3.jdmagicbox.com/v2/comp/noida/m5/011pxx11.xx11.240209220643.a7m5/catalogue/nehru-cricket-academy-noida-sports-ground-zs3ja4dua3.jpg',
      'https://content.jdmagicbox.com/comp/kharar/v9/0172px172.x172.200108232230.f6v9/catalogue/fateh-cricket-academy-and-ground-kharar-kharar-cricket-coaching-classes-zbzxtktxz4.jpg',
      // Ensure all URLs are unique
    ];

    return ListView.builder(
      itemCount: (images.length / 2).ceil(), // Number of rows
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, rowIndex) {
        int index1 = rowIndex * 2;
        int index2 = rowIndex * 2 + 1;

        // Alternate item heights to create a staggered effect
        double height1 = (index1 < images.length && rowIndex % 2 == 0)
            ? MediaQuery.of(context).size.height * .24
            : MediaQuery.of(context).size.height * .26;
        double height2 = (index2 < images.length && rowIndex % 2 == 0)
            ? MediaQuery.of(context).size.height * .26
            : MediaQuery.of(context).size.height * .24;

        return Padding(
          padding: const EdgeInsets.only(
            left: 12,
            right: 12,
            bottom: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (index1 < images.length)
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    images[index1],
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width * .44,
                    height: height1,
                  ),
                ),
              if (index2 < images.length)
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    images[index2],
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width * .44,
                    height: height2,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
