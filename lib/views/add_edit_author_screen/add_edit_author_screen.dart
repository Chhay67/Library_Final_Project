import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../data/response/status.dart';
import '../../models/author.dart';
import '../../res/constraint/constraint.dart';
import '../../view_models/author_view_model.dart';
import '../home_screen/home_screen.dart';

// ignore: must_be_immutable
class AddEditAuthorScreen extends StatefulWidget {
  final String title;
  Option option;
  AddEditAuthorScreen(this.title,this.option ,{super.key});

  @override
  State<AddEditAuthorScreen> createState() => _AddEditAuthorScreenState();
}

class _AddEditAuthorScreenState extends State<AddEditAuthorScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  File? imageFile;
  AuthorViewModel authorViewModel = AuthorViewModel();
  int? imageId;
  int? isHadImage;
  final _nameFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _shotBioController = TextEditingController();

  var _isEditing = false;
  var _isDeleting = false;
  var _expanded = false;
  int? _authorId;
  String? _authorName;

  Attributes data = Attributes(
    name: '',
    createdAt: '',
    shortBiography: '',
    updatedAt: '',
  );

  @override
  void initState() {
    authorViewModel.fetchAllAuthor();
    super.initState();
  }
  @override
  void dispose() {
    _nameController.dispose();
    _shotBioController.dispose();
    super.dispose();
  }
  _getImageFromGalleryOrCamera(String type) async {
    XFile? pickedFile = await ImagePicker().pickImage(
        source: type == 'camera' ? ImageSource.camera : ImageSource.gallery,
        maxHeight: 1280,
        maxWidth: 960);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      authorViewModel.uploadImage(imageFile);
    }
  }

  Future<void> _saveForm()async{
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    authorViewModel.toggleLoadingStatus();
    _formKey.currentState!.save();
    data = Attributes(
        name: data.name,
        updatedAt: data.updatedAt,
        createdAt: data.createdAt,
        shortBiography: data.shortBiography
    );
    if(_isEditing == false)
    {
      print('post');
      print('image id$imageId');
      await authorViewModel.postAuthor(data, imageId);
    }else {
      if(_isDeleting == false ) {
        print('put');
        if (imageId == null && isHadImage != null) {
          imageId = isHadImage;
        }
        print('image id $imageId');
        await authorViewModel.putAuthor(data, _authorId, imageId);
      }else{
        print('delete');
        print('$_authorId');
        await authorViewModel.deleteAuthor(_authorId);
        _isDeleting = false;
      }
    }

    authorViewModel.toggleLoadingStatus();
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>const HomeScreen()));
  }
  @override
  Widget build(BuildContext context) {
    final double coverHeight = MediaQuery.of(context).size.height * 0.15;
    final double imageHeight = 180;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme:const IconThemeData(color:Colors.black,size: 33),
        backgroundColor: backgroundColor,
        title: Text(widget.title, style: headingStyle),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(onPressed: (){
            setState(() {
              _isEditing = true;
              _isDeleting = false;
            });
          }, icon: const Icon(Icons.edit_rounded)),
          IconButton(onPressed: (){
            setState(() {
              _isDeleting = true;
              _isEditing = true;
            });
          }, icon:const Icon(Icons.delete))
        ],
      ),
      body: ChangeNotifierProvider<AuthorViewModel>(
        create: (BuildContext context) =>authorViewModel,
        child: SafeArea(
          child: ListView(
            children: [
              Container(
                color: backgroundColor,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.zero,
                      height:coverHeight,
                      width: MediaQuery.of(context).size.width,
                      color: backgroundColor,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: boxDecoration,
                      margin: EdgeInsets.only(top: coverHeight),
                      child: Column(
                        children: [
                          SizedBox(height: imageHeight / 1.8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    _getImageFromGalleryOrCamera('camera');
                                  },
                                  icon:
                                  const Icon(Icons.add_a_photo_outlined)),
                              IconButton(
                                  onPressed: () {
                                    _getImageFromGalleryOrCamera('gallery');
                                  },
                                  icon: const Icon(Icons.photo_library)),
                            ],
                          ),
                          if(_isEditing == true || _isDeleting == true)
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 15.0, right: 15.0, top: 5, bottom: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.grey)),
                              child: Column(
                                children: [
                                  Consumer<AuthorViewModel>(builder:(context,authorViewModel,_) {
                                    print('${authorViewModel.authorResponse.status}');
                                    print('${authorViewModel.authorResponse.message}');
                                    switch(authorViewModel.authorList.status){
                                      case Status.LOADING:
                                        return const Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: CircularProgressIndicator(color: Colors.black12,),
                                            ));
                                      case Status.ERROR:
                                        return Text('${authorViewModel.authorList.message}');
                                      case Status.COMPLETE:
                                        return ListTile(
                                          title:authorViewModel.authorList.data?.data == null
                                              ?Text('${authorViewModel.authorList.message}')
                                              : Text(_authorId == null ? 'Select Author...' : '$_authorName'),
                                          trailing: IconButton(
                                            icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                                            onPressed: () {
                                              setState(() {
                                                _expanded = !_expanded;
                                              });
                                            },
                                          ),
                                        );
                                      default:
                                        return Text('${authorViewModel.authorList.message}');
                                    }
                                  }),
                                  if (_expanded)
                                    SizedBox(
                                        height: 100,
                                        child: ListView.builder(
                                          itemCount:authorViewModel.authorList.data?.data == null ? 0 : authorViewModel.authorList.data?.data?.length,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              leading: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                    '${authorViewModel.authorList.data?.data?[index].id}'),
                                              ),
                                              title: Text(
                                                  '${authorViewModel.authorList.data?.data?[index].attributes?.name}'),
                                              onTap: () {
                                                setState(() {
                                                  _authorId = authorViewModel.authorList.data?.data?[index].id;
                                                  _authorName = authorViewModel.authorList.data?.data?[index].attributes?.name;
                                                  isHadImage =  authorViewModel.authorList.data?.data?[index].attributes?.photo?.data?.id;
                                                  print('ss $imageId');
                                                  _nameController = TextEditingController(text: _authorName);
                                                  _shotBioController = TextEditingController( text: authorViewModel.authorList.data?.data?[index].attributes?.shortBiography);
                                                  _expanded = !_expanded;
                                                });
                                              },
                                            );
                                          },
                                        )),
                                ],
                              ),
                            ),

                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: _nameController,
                                    decoration: const InputDecoration(
                                      fillColor: Colors.white,
                                      labelText: 'Name...',
                                      labelStyle: TextStyle(color: Colors.black),
                                      border: borderOutLineInputBorder,
                                      focusedBorder: focusedBorderOutLineInputBorder,
                                    ),
                                    cursorColor: Colors.black12,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.text,
                                    onFieldSubmitted: (_){
                                      FocusScope.of(context)
                                          .requestFocus(_nameFocusNode);
                                    },
                                    onSaved: (value){
                                      data = Attributes(
                                          name: value,
                                          updatedAt: data.updatedAt,
                                          createdAt: data.createdAt,
                                          shortBiography: data.shortBiography
                                      );
                                    },
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return 'Please input name.';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 15.0),
                                  TextFormField(
                                    controller: _shotBioController,
                                    decoration: const InputDecoration(
                                        labelText: 'Short biography...',
                                        labelStyle: TextStyle(color: Colors.black),
                                        border: borderOutLineInputBorder,
                                        focusedBorder:
                                        focusedBorderOutLineInputBorder),
                                    cursorColor: Colors.black12,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.text,
                                    minLines: 3,
                                    maxLines: 5,
                                    onFieldSubmitted: (_){
                                      FocusScope.of(context)
                                          .requestFocus(_descriptionFocusNode);
                                    },
                                    onSaved: (value){
                                      data = Attributes(
                                          name: data.name,
                                          createdAt: data.createdAt,
                                          updatedAt: data.updatedAt,
                                          shortBiography: value
                                      );
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please input description.';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 15.0),
                                  Container(
                                    padding: const EdgeInsets.only(top: 5, left: 15.0, right: 15.0, bottom: 15.0),
                                    width: 250, height: 70,
                                    child: Consumer<AuthorViewModel>(
                                        builder: (context,authorViewModel,_){
                                          print('${authorViewModel.authorResponse.status}');
                                          print('${authorViewModel.authorResponse.message}');
                                          return ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: _isDeleting == true ?Theme.of(context).errorColor : backgroundColor,
                                                shape: const RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(10)))),
                                            onPressed: () {
                                              _saveForm();
                                            },
                                            child: authorViewModel.isLoading == false
                                                ?  Text(_isDeleting == true ?'DELETE' : 'SAVE', style:const TextStyle(fontSize: 16, fontWeight: FontWeight.w900))
                                                :  const Center(child: CircularProgressIndicator(color: Colors.white,)),

                                          );
                                        }
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top:  coverHeight - imageHeight / 2,
                      child: Container(
                        width: 150,
                        height: 180,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child:  Consumer<AuthorViewModel>(
                          builder: (context,value,_){
                            imageId = value.imageResponse.data?.id;
                            print('image id$imageId');
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
                              child: Image.asset(
                                'assets/img/image-placeholder.png',
                                fit: BoxFit.fill,
                                width: 150,
                                height: 198,
                              ),
                            );
                          },
                        )
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
