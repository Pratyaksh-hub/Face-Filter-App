import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera_deep_ar/camera_deep_ar.dart';

const id =
    'ed4e375137940a36600457b754c61bda2be10f325d6720c433da8c825242997331c04e1be6b92d7a';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CameraDeepArController cameraDeepArController;
  String _plateformVersion = 'unknown';
  String _plateformVersion1 = 'unknown';
  String _plateformVersion2 = 'unknown';
  bool isRecording = false;
  bool isCaptured = false;
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Builder(builder: (context) {
          return Stack(
            children: [
              CameraDeepAr(
                  onCameraReady: (isReady) {
                    _plateformVersion = 'Camera Status $isReady';
                    setState(() {});
                  },
                  onImageCaptured: (path) {
                    _plateformVersion1 = 'Image Captured at $path';
                    setState(() {});
                  },
                  onVideoRecorded: (path) {
                    _plateformVersion2 = 'Video is Capturing at $path';
                    setState(() {});
                  },
                  androidLicenceKey: id,
                  iosLicenceKey: id,
                  cameraDeepArCallback: (c) async {
                    cameraDeepArController = c;
                    setState(() {});
                  }),
              SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(children: [
                        const Icon(
                          Icons.signal_wifi_4_bar,
                          color: Colors.green,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            ' $_plateformVersion\n',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 50, left: 50, right: 50, bottom: 80),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.deepPurple.shade900,
                            minimumSize: const Size(50, 50),
                          ),
                          onPressed: () {
                            if (null == cameraDeepArController) return;

                            isCaptured = true;

                            cameraDeepArController.snapPhoto();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('$_plateformVersion1\n'),
                              ),
                            );
                          },
                          child: const Icon(Icons.camera_enhance_outlined),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      if (isRecording)
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              minimumSize: const Size(50, 50),
                            ),
                            onPressed: () {
                              if (null == cameraDeepArController) return;
                              cameraDeepArController.stopVideoRecording();
                              isRecording = false;
                              setState(() {});
                            },
                            child: const Icon(Icons.videocam_off),
                          ),
                        )
                      else
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.deepPurple.shade900,
                              minimumSize: const Size(50, 50),
                            ),
                            onPressed: () {
                              if (null == cameraDeepArController) return;
                              cameraDeepArController.startVideoRecording();
                              isRecording = true;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('$_plateformVersion2\n'),
                                ),
                              );
                              setState(() {});
                            },
                            child: const Icon(Icons.videocam),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(15),
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: List.generate(8, (page) {
                      bool active = currentPage == page;
                      return GestureDetector(
                        onTap: () {
                          currentPage = page;
                          cameraDeepArController.changeMask(page);
                          setState(() {});
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(12),
                          width: active ? 60 : 40,
                          height: active ? 60 : 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: active
                                  ? Colors.deepPurple.shade900
                                  : Colors.white,
                              shape: BoxShape.circle),
                          child: Text(
                            "$page",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: active ? 12 : 10,
                                color: active ? Colors.white : Colors.black),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
