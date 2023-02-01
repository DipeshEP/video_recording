import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
class VideoPlay extends StatefulWidget {
  const VideoPlay({Key? key}) : super(key: key);

  @override
  State<VideoPlay> createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlay> {
  var size,height,width;
  File? Video;
  VideoPlayerController? videocontroller;

  Future<void> pickvideofromgallery() async {
    final videopicked =
    await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (videopicked != null) {
      Video = File(videopicked.path);
      videocontroller=VideoPlayerController.file(Video!)
        ..initialize().then((_) {
          setState(() {

          });
          videocontroller!.play();
          videocontroller!.setLooping(true);
      });
    }
  }
   Future<void>pickvideofromcamera()async{
    final videopicked =await ImagePicker().pickVideo(source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
      maxDuration: const Duration(seconds: 60));
    if(videopicked!=null){
     Video =File(videopicked.path);
     videocontroller=VideoPlayerController.file(Video!)
       ..initialize().then((_){
         setState(() {

         });
         videocontroller!.play();
         videocontroller!.setLooping(true);
       });
    }

   }
   @override
  void dispose(){
    videocontroller!.dispose();
    super.dispose();
   }
    @override
    Widget build(BuildContext context) {
    //height=MediaQuery.of(context).size.height;
      size=MediaQuery.of(context).size;
      height=size.height;
      width=size.width;
      return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text("Video Picker"),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Video == null?
                        Padding(
                          padding: const EdgeInsets.only(top: 0,bottom: 120),
                          child: const SizedBox(
                            height: 500,
                            width: 500,
                            child: Placeholder(),
                          ),
                        )
                        :ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight:400,maxWidth: 300),
                        child: GestureDetector(
                          onTap: (){
                            setState(() {});
                            videocontroller!.value.isPlaying
                            ? videocontroller!.pause()
                                :videocontroller!.play();
                          },
                          child: AspectRatio(
                              aspectRatio:videocontroller!.value.aspectRatio,
                              child: Stack(
                                children: [
                                  VideoPlayer(videocontroller!),
                                  Center(
                                    child: videocontroller!.value.isPlaying
                                    ? SizedBox()
                                    :SizedBox.square(
                                      dimension: 100,
                                      child: Image.asset('assets/images/playicon.png'),
                                    ),
                                  )
                                ],
                              ),),
                        ),
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30,),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 50,
                            width: 80,
                            child: ElevatedButton.icon(
                                onPressed: ()=>pickvideofromgallery(),
                                style: ButtonStyle(
                                  minimumSize: const MaterialStatePropertyAll(Size(220, 50)),
                                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                                  backgroundColor: MaterialStatePropertyAll(Colors.white)

                                ),
                                icon: SizedBox.square(
                                  dimension:35 ,
                                  child: Image.asset('assets/images/video.png'),
                                ),

                                label: Text(""),
                               ),
                          ),
                          SizedBox(
                            height: 50,
                            width: 100,
                            child: ElevatedButton.icon(

                              onPressed: ()=>pickvideofromcamera(),
                              style: ButtonStyle(
                                  minimumSize: const MaterialStatePropertyAll(Size(220, 50)),
                                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                                  backgroundColor: MaterialStatePropertyAll(Colors.white)

                              ),
                              icon: SizedBox.square(
                                dimension:35 ,
                                child: Image.asset('assets/images/camera.png'),
                              ),

                              label: Text(""),
                            ),
                          ),
                        ],
                      ),
                    )

                  ],
              ),
            ),
          ));
    }
  }
