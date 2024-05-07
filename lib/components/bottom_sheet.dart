import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomSheetWidget extends StatelessWidget {
  final String title, description, imageurl, url;
  const BottomSheetWidget({
    super.key,
    required this.title,
    required this.description,
    required this.imageurl,
    required this.url,
  });

  launcher(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.47,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 300,
            child: Stack(
              children: [
                Container(
                  foregroundDecoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black, Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      image: DecorationImage(
                          image: NetworkImage(imageurl), fit: BoxFit.cover)),
                ),
                Positioned(
                  bottom: 10,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      title,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                description,
                style: const TextStyle(fontSize: 15),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.blue),
                text: 'Read full article: ',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    launcher(Uri.parse(url));
                  },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void showMyBottomSheet({
  required BuildContext context,
  required String title,
  required String description,
  required String imageurl,
  required String url,
}) {
  showBottomSheet(
      context: context,
      builder: (context) {
        return BottomSheetWidget(
          title: title,
          description: description,
          imageurl: imageurl,
          url: url,
        );
      });
}
