import 'package:any_image_view/any_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_convert_heictojpg/core/component/color_custom.dart';
import 'package:flutter_convert_heictojpg/interfaces/controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  Widget build(BuildContext context, HomeController controller) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white10,
          title: Text(
            'CONVERT AND COMPRESS IMAGE',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsetsGeometry.only(top: 30),
          child: Center(
              child: Column(
            children: [
              controller.result == null
                  ? const SizedBox()
                  : GridView.builder(
                      padding: EdgeInsets.only(left: 10),
                      shrinkWrap: true,
                      itemCount: controller.result?.files.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 3 / 3,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10),
                      itemBuilder: (context, index) => ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: AnyImageView(
                          height: 230,
                          width: 200,
                          borderRadius: BorderRadius.circular(10),
                          fadeDuration: Duration(milliseconds: 300),
                          imagePath: controller.result!.files[index].path!,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),
            ],
          )),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsetsGeometry.only(left: 30),
              child: InkWell(
                onTap: () {
                  controller.pickImageConvert();
                },
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 5,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: blueGreen,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'Select Photos',
                      style: TextStyle(color: blueGreen),
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                controller.saveImageConvert();
              },
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width / 5,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: blueGreen,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'Convert to JPG',
                    style: TextStyle(
                      color: blueGreen,
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                controller.saveCompressImage();
              },
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width / 5,
                decoration: BoxDecoration(
                  border: BoxBorder.all(
                    color: blueGreen,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'Compress Image',
                    style: TextStyle(color: blueGreen),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  @override
  State<StatefulWidget> createState() => HomeController();
}
