import 'package:any_image_view/any_image_view.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_convert_heictojpg/core/component/color_custom.dart';
import 'package:flutter_convert_heictojpg/interfaces/controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  Widget build(BuildContext context, HomeController controller) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black, // navigation bar color
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light, // status bar color
    ));
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
            child: controller.result == null || controller.result!.files.isEmpty
                ? Padding(
                    padding: EdgeInsetsGeometry.only(top: 20),
                    child: Column(
                      children: [
                        Text(
                          'Upload your photos',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            controller.pickImageConvert();
                          },
                          child: DottedBorder(
                            options: RoundedRectDottedBorderOptions(
                                radius: Radius.circular(8),
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 40)),
                            child: Icon(
                              Icons.cloud_upload_outlined,
                              size: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: EdgeInsetsGeometry.only(top: 20),
                    child: Column(
                      children: [
                        Flexible(
                          child: GridView.builder(
                            padding: EdgeInsets.only(left: 10, right: 0),
                            shrinkWrap: true,
                            itemCount: controller.result!.files.length + 1,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: 3 / 3,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10),
                            itemBuilder: (context, index) {
                              if (index == controller.result?.files.length) {
                                return InkWell(
                                  onTap: () {
                                    controller.pickImageOther();
                                  },
                                  child: DottedBorder(
                                    options: RoundedRectDottedBorderOptions(
                                        radius: Radius.circular(10),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 20)),
                                    child: Center(
                                      child: Icon(
                                        Icons.cloud_upload_outlined,
                                        size: 40,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return Badge(
                                offset: Offset(0, 0),
                                padding: EdgeInsets.zero,
                                alignment: AlignmentGeometry.topLeft,
                                backgroundColor: Colors.transparent,
                                label: InkWell(
                                  onTap: () {
                                    controller.removeItem(
                                        controller.result?.files[index]);
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.delete,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: AnyImageView(
                                    height: 230,
                                    width: 200,
                                    borderRadius: BorderRadius.circular(10),
                                    fadeDuration: Duration(milliseconds: 300),
                                    imagePath:
                                        controller.result!.files[index].path!,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    )),
          ),
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsetsGeometry.only(left: 30),
                child: InkWell(
                  onTap: () async {
                    controller.saveImageConvert();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    height: 50,
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                      border: Border.all(color: blueGreen, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        'Convert to JPG',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: blueGreen,
                          fontWeight: FontWeight.w700,
                        ),
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
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  height: 50,
                  width: MediaQuery.of(context).size.width / 3,
                  decoration: BoxDecoration(
                    border: BoxBorder.all(color: blueGreen, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'Compress Photo',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: blueGreen,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  @override
  State<StatefulWidget> createState() => HomeController();
}
