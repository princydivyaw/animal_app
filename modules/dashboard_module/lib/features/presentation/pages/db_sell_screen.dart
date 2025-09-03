import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:share_module/core/constants/app_colors.dart';
import 'package:share_module/core/theme/text_styles.dart';
import 'package:share_module/core/utils/app_common_utils.dart';

class DbSellScreen extends StatefulWidget {
  const DbSellScreen({Key? key}) : super(key: key);

  @override
  State<DbSellScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<DbSellScreen> {
  final TextEditingController _textController = TextEditingController();

  List<File> selectedFiles = [];
  List<PlatformFile> pickedFiles = [];

  // Future<void> requestPermissions() async {
  //   if (Theme.of(context).platform == TargetPlatform.android) {
  //     var camera = await Permission.camera.status;
  //     if (camera.isDenied || camera.isRestricted) {
  //       await Permission.camera.request();
  //     }
  //     var storage = await Permission.storage.status;
  //     if (storage.isDenied || storage.isRestricted) {
  //       await Permission.storage.request();
  //     }
  //     var photos = await Permission.photos.status;
  //     if (photos.isDenied || photos.isRestricted) {
  //       await Permission.photos.request();
  //     }
  //     var videos = await Permission.videos.status;
  //     if (videos.isDenied || videos.isRestricted) {
  //       await Permission.videos.request();
  //     }
  //   } else {
  //     if (await Permission.photos.isDenied) {
  //       await Permission.photos.request();
  //     }
  //   }
  // }

  Future<dynamic> pickFiles() async {
    // await requestPermissions();
    // if (await Permission.storage.isGranted ||
    //     await Permission.photos.isGranted) {
    //   FilePickerResult? result = await FilePicker.platform.pickFiles(
    //     allowMultiple: true,
    //     type: FileType.custom,
    //     allowedExtensions: ['jpg', 'png', 'mp4', 'mov'],
    //   );
    //
    //   if (result != null) {
    //     setState(() {
    //       pickedFiles = result.paths.whereType<String>().toList();
    //     });
    //   }
    // } else {
    //   showPermissionDialog();
    // }
    //
    // print("pickedFiles==============$pickedFiles");
  }

  void submitPost() {
    final text = _textController.text.trim();

    if (pickedFiles == []) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please add text or media")),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Post uploaded!")),
    );

    setState(() {
      pickedFiles = [];
    });
  }

  void showPermissionDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Permission Required"),
        content: Text("Please allow storage/photos permission to pick files."),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: Text("Settings"),
            onPressed: () async {
              // if (await Permission.speech.isPermanentlyDenied) {
              //   openAppSettings();
              // }
            },
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> myPostWay = [
    {"title": "Image", "icon": Icons.image, "key": "image"},
    {"title": "Live", "icon": Icons.live_tv_rounded, "key": "live"},
    {"title": "Video", "icon": Icons.videocam_rounded, "key": "video"},
  ];
  int postType = 1;

  bool isAccessAllowed = false;

  @override
  void initState() {
    super.initState();
    isAccessAllowed = false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(color: AppColors.surface),
        child: Column(
          children: [
            sellContent(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.016,
            ),
            footerContent()
          ],
        ),
      ),
    );
  }

  Expanded sellContent() {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(
            top: 16.0, bottom: 48, right: 16.0, left: 16.0),
        decoration: const BoxDecoration(
            color: AppColors.border,
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        child: Column(
          children: [
            Container(
              height: 10,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.032,
            ),
            InkWell(
              onTap: () {
                Modular.to.pop(context);
              },
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  height: 30,
                  width: 30,
                  padding: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryBlack.withValues(alpha: 0.1),
                        spreadRadius: 0.2,
                        blurRadius: 0.2,
                        offset: const Offset(1, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.close,
                    color: AppColors.primary,
                    size: 25,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            !isAccessAllowed
                ? Column(
                    children: [
                      Text(
                        "Create a Short",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.headingBold(
                            color: AppColors.blueGrey),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.016,
                      ),
                      Text(
                        "Allow access to your camera and microphone",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.captionNormal(
                            color: AppColors.blueGrey),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.024,
                      ),
                      InkWell(
                        onTap: () {
                          chooseAccess();
                        },
                        child: Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                                color: AppColors.surface,
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        AppColors.primaryBlack.withOpacity(0.2),
                                    spreadRadius: 0.2,
                                    blurRadius: 0.4,
                                    offset: const Offset(1, 2),
                                  ),
                                ],
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(25.0))),
                            child: Text(
                              "Allow access",
                              textAlign: TextAlign.center,
                              style: AppTextStyles.captionBold(
                                  color: AppColors.blueGrey),
                            )),
                      ),
                    ],
                  )
                : Container(),
            const Spacer(),
            InkWell(
              onTap: () {
                uploadThePost();
              },
              child: Container(
                height: 80,
                width: 80,
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Container(
                    height: 60,
                    width: 60,
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget footerContent() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      padding: const EdgeInsets.only(bottom: 16.0),
      child: ListView.builder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: myPostWay.length,
          itemBuilder: (context, int i) {
            return InkWell(
              onTap: () {
                setState(() {
                  postType = i;
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      margin: EdgeInsets.only(left: i == 0 ? 0 : 16),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: postType == i
                              ? AppColors.primary
                              : AppColors.transparent,
                          boxShadow: postType == i
                              ? [
                                  BoxShadow(
                                    color: AppColors.backgroundDark
                                        .withOpacity(0.2),
                                    spreadRadius: 0.2,
                                    blurRadius: 2,
                                    offset: const Offset(1, 2),
                                  ),
                                ]
                              : [],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0))),
                      child: Text(
                        myPostWay[i]['title'],
                        style: AppTextStyles.captionBold(
                            color: postType == i
                                ? AppColors.textOnPrimary
                                : AppColors.blueGrey),
                      )),
                ],
              ),
            );
          }),
    );
  }

  chooseAccess() async {
    AppCommonUtils().pickFileWithPermission();
    // setState(() {
    //   isAccessAllowed = true;
    // });
  }

  uploadThePost() {
    // if (isAccessAllowed) {
    //   Modular.to.popAndPushNamed("/dashboardModule/sellConfirm",
    //       arguments: {"data": pickedFiles});
    // } else {
    //   showSnackBar(errorMessage: "Please choose your files");
    // }
    Modular.to.popAndPushNamed("/dashboardModule/sellConfirm",
        arguments: {"files": pickedFiles});
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
      {required String errorMessage}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        backgroundColor: AppColors.primary,
      ),
    );
  }
}
