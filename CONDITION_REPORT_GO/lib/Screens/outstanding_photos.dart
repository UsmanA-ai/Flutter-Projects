import 'package:condition_report/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OutstandingPhotos extends StatefulWidget {
  final List<String> imagePaths;
  const OutstandingPhotos({super.key, required this.imagePaths});

  @override
  State<OutstandingPhotos> createState() => _OutstandingPhotosState();
}

class _OutstandingPhotosState extends State<OutstandingPhotos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        title: Text(
          "Outstanding Photos",
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 32, right: 32, bottom: 20),
        child: Container(
          height: 60,
          // width: 364,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: FilledButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(
                const Color.fromRGBO(98, 98, 98, 1),
              ),
            ),
            onPressed: () {},
            child: const Text(
              "Submit",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
            ),
          ),
        ),
      ),
      body: StreamBuilder<List<String>>(
        stream: FireStoreServices().fetchAllImages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error loading images"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No images found"));
          }

          final images = snapshot.data!;

          return Container(
            padding: const EdgeInsets.only(top: 1),
            color: const Color.fromRGBO(204, 204, 204, 1),
            child: Container(
              color: const Color.fromRGBO(253, 253, 253, 1),
              child: Padding(
                  padding: const EdgeInsets.only(
                    left: 32,
                    right: 32,
                    top: 20,
                  ),
                child: GridView.builder(
                  itemCount: images.length,
                  // padding: EdgeInsets.all(8),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // ✅ Show 3 images per row
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            // height: 108,
                            // width: 108,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.2),
                              image: DecorationImage(
                                image: NetworkImage(images[index]),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: SvgPicture.asset(
                                    "assets/images/Ellipse 270.svg",
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(1.39),
                                  child: SvgPicture.asset(
                                    "assets/images/Group 1353 (1).svg",
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    //   Container(
                    //   height: 108,
                    //   width: 108,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(6.2),
                    //     image: DecorationImage(
                    //       image: NetworkImage(images[index]),
                    //       fit: BoxFit.cover,
                    //     ),
                    //   ),
                    // );
                  },
                ),
              ),
            ),
          );
        },
      ),

      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       Container(
      //         padding: const EdgeInsets.only(top: 1),
      //         color: const Color.fromRGBO(204, 204, 204, 1),
      //         child: Container(
      //           height: 926,
      //           width: double.infinity,
      //           color: const Color.fromRGBO(253, 253, 253, 1),
      //           child: Padding(
      //             padding: const EdgeInsets.only(
      //               left: 32,
      //               right: 32,
      //               top: 20,
      //             ),
      //             child: SizedBox(
      //               width: 364,
      //               child: GridView.count(
      //                 crossAxisCount: 3,
      //                 mainAxisSpacing: 10,
      //                 crossAxisSpacing: 20,
      //                 children: widget.imagePaths.map((imagePath) {
      //                   return SizedBox(
      //                     height: 108,
      //                     width: 108,
      //                     child: Stack(
      //                       alignment: Alignment.topRight,
      //                       children: [
      //                         Container(
      //                           height: 108,
      //                           width: 108,
      //                           decoration: BoxDecoration(
      //                             borderRadius: BorderRadius.circular(6.2),
      //                             image: DecorationImage(
      //                               image: NetworkImage(images[index]),
      //                               fit: BoxFit.fill,
      //                             ),
      //                           ),
      //                         ),
      //                         GestureDetector(
      //                           onTap: () {},
      //                           child: Stack(
      //                             alignment: Alignment.center,
      //                             children: [
      //                               Padding(
      //                                 padding: const EdgeInsets.all(5),
      //                                 child: SvgPicture.asset(
      //                                   "assets/images/Ellipse 270.svg",
      //                                   height: 15,
      //                                   width: 15,
      //                                 ),
      //                               ),
      //                               Padding(
      //                                 padding: const EdgeInsets.all(1.39),
      //                                 child: SvgPicture.asset(
      //                                   "assets/images/Group 1353 (1).svg",
      //                                   height: 15,
      //                                   width: 15,
      //                                 ),
      //                               ),
      //                             ],
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   );
      //                 }).toList(), // Don't forget to call toList() to convert the map to a list
      //               ),
      //             ),
      //           ),
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
