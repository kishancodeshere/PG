import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ImgPicker extends StatefulWidget {
  const ImgPicker({super.key});

  @override
  State<ImgPicker> createState() => _ImgPickerState();
}

class _ImgPickerState extends State<ImgPicker> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  Future selectImage() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future uploadImage() async {
    final path = 'images/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
      uploadTask = ref.putFile(file);
    });

    final snapshot = await uploadTask!.whenComplete(() => {});

    final imageUrl = await snapshot.ref.getDownloadURL();
    debugPrint('Image Link : $imageUrl');
    setState(() {
      uploadTask = null;
    });
  } 

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      if (pickedFile != null)
        Container(
          height: 240,
          color: Colors.blue[100],
          child: Image.file(
            File(pickedFile!.path!),
            // width: 500,
            height: 150,
            fit: BoxFit.cover,
          ),
        ),
      const SizedBox(
        height: 10,
      ),
      buildProgress(),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: selectImage,
            style: ElevatedButton.styleFrom(

      backgroundColor: Color(0xff0A1045),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),),
    ), child:
    Text("Select Image",
      style: TextStyle(
          color: Color(0xffe5e6e4), fontSize: 14, fontWeight: FontWeight.w500),
    ),
          ),
          ElevatedButton(
            onPressed: uploadImage,
            style: ElevatedButton.styleFrom(

      backgroundColor: Color(0xff0A1045),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),),
    ), child:
    Text("Upload Image",
      style: TextStyle(
          color: Color(0xffe5e6e4), fontSize: 14, fontWeight: FontWeight.w500),
    ),
          ),
        ],
      ),
    ]);
  }

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
        stream: uploadTask?.snapshotEvents,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            double progress = data.bytesTransferred / data.totalBytes;
            return SizedBox(
              height: 50,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey,
                    color: Colors.green,
                  ),
                  Center(
                    child: Text(
                      '${(100 * progress).roundToDouble()}%',
                      style: const TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            );
          } else {
            return const SizedBox(height: 50);
          }
        }),
      );
}
