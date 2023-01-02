
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:library_final_project/view_models/image_view_model.dart';
import 'package:provider/provider.dart';


class PickImage extends StatefulWidget {
  final Function imageId;
  final String? imageUrl;
  PickImage(this.imageId,this.imageUrl);

  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  ImageViewModel imageViewModel = ImageViewModel();

  File? imageFile;
  int? _imageId;

  _getImageFromGalleryOrCamera(String type) async {
    XFile? pickedFile = await ImagePicker().pickImage(
        source: type == 'camera' ? ImageSource.camera : ImageSource.gallery,
        maxHeight: 500,
        maxWidth: 500);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      imageViewModel.toggleUploadStatus();
      await imageViewModel.uploadImage(imageFile);
      imageViewModel.toggleUploadStatus();
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ImageViewModel>(
      create: (BuildContext context) => imageViewModel,
      child: Column(
        children: [
          Container(
              width: 150,
              height: 180,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20)),
              child: Consumer<ImageViewModel>(
                builder: (context, value, _) {
                  print('image ${value.imageResponse.status}');
                  print('image ${value.imageResponse.message}');
                  _imageId = value.imageResponse.data?.id;
                  widget.imageId(_imageId);
                  print(' image Id: $_imageId');
                  if(imageViewModel.isUploadImage)
                    return Container(
                      width: 150,
                      height: 198,
                      decoration: BoxDecoration(
                        borderRadius:BorderRadius.circular(20.0) ,
                        color: Colors.black12,
                      ),
                      child: Center(child: CircularProgressIndicator(color: Colors.black,),),
                    );
                  return imageFile != null
                      ? ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.file(
                        imageFile!,
                        width: 150,
                        height: 198,
                        fit: BoxFit.cover,
                      ))
                      : ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child:widget.imageUrl != null
                            ? Image.network('${widget.imageUrl}',
                            fit: BoxFit.fill,
                            width: 150,
                            height: 198,)
                            :  Image.asset(
                              'assets/img/image-placeholder.png',
                              fit: BoxFit.fill,
                              width: 150,
                              height: 198,
                            ),
                    );
                },
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    _getImageFromGalleryOrCamera('camera');
                  },
                  icon: const Icon(Icons.add_a_photo_outlined)),
              IconButton(
                  onPressed: () {
                    _getImageFromGalleryOrCamera('gallery');
                  },
                  icon: const Icon(Icons.photo_library)),
            ],
          ),
        ],
      ),
    );
  }


}
