import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../data/response/status.dart';
import '../../models/book_response.dart';
import '../../res/constraint/constraint.dart';
import '../../view_models/author_view_model.dart';
import '../../view_models/book_view_model.dart';
import '../home_screen/home_screen.dart';

class AddEdit extends StatefulWidget {
  final int? bookId;
  final String? bookCode;
  final AttrBookResponse? editData;
  Option option;
  final String? title;
  AddEdit(this.bookId, this.bookCode, this.editData, this.option, this.title,
      {super.key});

  @override
  State<AddEdit> createState() => _AddEditState();
}

class _AddEditState extends State<AddEdit> {
  File? imageFile;
  BookViewModel bookViewModel = BookViewModel();
  AuthorViewModel authorViewModel = AuthorViewModel();
  int? imageId;
  AttrBookResponse? data = AttrBookResponse(
      imageId: null,
      originallyPublished: '',
      code: '',
      description: '',
      price: 0,
      title: '',
      starReview: null,
      authorId: null,
      authorName: '');

  final _titleFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey();

  var _expanded = false;
  int? _authorId;
  String? _authorName;

  Map<String, dynamic>? _initValues = {
    'imageId': null,
    'title': '',
    'description': '',
    'price': 0,
    'imageUrl': '',
    'starReview': null,
  };

  @override
  void initState() {
    authorViewModel.fetchAllAuthor();
    super.initState();
  }

  var _isInit = true;
  @override
  void didChangeDependencies() {
    try {
      if (_isInit) {
        if (widget.bookId != null) {
          _authorId = widget.editData?.authorId;
          _authorName = widget.editData?.authorName;
          _initValues = {
            'imageId': widget.editData?.imageId,
            'title': widget.editData?.title,
            'description': widget.editData?.description,
            'price': widget.editData?.price,
            'authorId': widget.editData?.authorId,
            'starReview': widget.editData?.starReview
          };
        }
      }
      _isInit = false;
    } catch (e) {
      print(e.toString());
    }
    super.didChangeDependencies();
  }

  _getImageFromGalleryOrCamera(String type) async {
    XFile? pickedFile = await ImagePicker().pickImage(
        source: type == 'camera' ? ImageSource.camera : ImageSource.gallery,
        maxHeight: 1280,
        maxWidth: 960);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      bookViewModel.uploadImage(imageFile);
    }
  }

  Future<void> _saveForm() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    bookViewModel.toggleLoadingStatus();
    _formKey.currentState!.save();
    final String datePost =
        DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());
    data = AttrBookResponse(
        code: widget.bookCode ?? 'IB-${widget.bookId}',
        originallyPublished: datePost,
        title: data?.title,
        price: data?.price,
        description: data?.description,
        starReview: data?.starReview == null
            ? _initValues!['starReview']
            : data?.starReview,
        authorId: _authorId);
    print('auhtor :${data?.authorId}');
    print('title :${data?.title}');
    print('code :${data?.code}');
    print(' star :${data?.starReview}');
    print('des :${data?.description}');
    //print(' image Id: $imageId');
    if (widget.option == Option.ADDBOOK) {
      print('post');
      print(' image Id: $imageId');
      await bookViewModel.postBook(data, imageId);
    } else {
      print(' image Id $imageId');
      print(' edit data ${widget.editData?.imageId}');
      if (imageId == null && _initValues?['imageId'] != null) {
        imageId = widget.editData?.imageId;
      }
      // imageId ??= int.parse(_initValues!['imageId']);
      print('put');
      print('imageId $imageId');
      await bookViewModel.putBook(data, widget.bookId, imageId);
    }

    bookViewModel.toggleLoadingStatus();
    // ignore: use_build_context_synchronously
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => const HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final double coverHeight = MediaQuery.of(context).size.height * 0.15;
    final double imageHeight = 180;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black, size: 33),
        backgroundColor: backgroundColor,
        title: Text('${widget.title}', style: headingStyle),
        centerTitle: true,
        elevation: 0,
      ),
      body: ChangeNotifierProvider<BookViewModel>(
        create: (BuildContext context) => bookViewModel,
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
                      height: coverHeight,
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
                                  icon: const Icon(Icons.add_a_photo_outlined)),
                              IconButton(
                                  onPressed: () {
                                    _getImageFromGalleryOrCamera('gallery');
                                  },
                                  icon: const Icon(Icons.photo_library)),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 15.0),
                            child: Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    TextFormField(
                                      initialValue: _initValues?['title'],
                                      decoration: const InputDecoration(
                                        fillColor: Colors.white,
                                        labelText: 'Title...',
                                        labelStyle:
                                            TextStyle(color: Colors.black),
                                        border: borderOutLineInputBorder,
                                        focusedBorder:
                                            focusedBorderOutLineInputBorder,
                                      ),
                                      cursorColor: Colors.black12,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.text,
                                      onFieldSubmitted: (_) {
                                        FocusScope.of(context)
                                            .requestFocus(_titleFocusNode);
                                      },
                                      onSaved: (value) {
                                        data = AttrBookResponse(
                                            title: value,
                                            code: '',
                                            starReview: data?.starReview,
                                            price: data?.price,
                                            description: data?.description,
                                            originallyPublished:
                                                data?.originallyPublished,
                                            authorId: data?.authorId);
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Input title.';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 15.0),
                                    TextFormField(
                                      initialValue: _initValues?['description'],
                                      decoration: const InputDecoration(
                                          labelText: 'Description...',
                                          labelStyle:
                                              TextStyle(color: Colors.black),
                                          border: borderOutLineInputBorder,
                                          focusedBorder:
                                              focusedBorderOutLineInputBorder),
                                      cursorColor: Colors.black12,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.text,
                                      minLines: 3,
                                      maxLines: 5,
                                      onFieldSubmitted: (_) {
                                        FocusScope.of(context)
                                            .requestFocus(_descriptionFocusNode);
                                      },
                                      onSaved: (value) {
                                        data = AttrBookResponse(
                                            code: data?.code,
                                            title: data?.title,
                                            description: value,
                                            price: data?.price,
                                            starReview: data?.starReview,
                                            originallyPublished: data?.originallyPublished,
                                            authorId: data?.authorId);
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please input description.';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 15.0),
                                    TextFormField(
                                      initialValue: _initValues?['price'] == null
                                          ? ''
                                          : _initValues?['price'].toString(),
                                      decoration: const InputDecoration(
                                          fillColor: Colors.grey,
                                          labelText: 'Price...',
                                          labelStyle:
                                              TextStyle(color: Colors.black),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(20))),
                                          focusColor: Colors.grey,
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(20)),
                                              borderSide: BorderSide(color: Colors.black,))),
                                      textInputAction: TextInputAction.done,
                                      keyboardType: TextInputType.number,
                                      onFieldSubmitted: (_) {
                                        FocusScope.of(context)
                                            .requestFocus(_priceFocusNode);
                                      },
                                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                      onSaved: (value) {
                                        data = AttrBookResponse(
                                            title: data?.title,
                                            code: data?.code,
                                            price: int.parse(value!),
                                            originallyPublished:
                                                data?.originallyPublished,
                                            starReview: data?.starReview,
                                            description: data?.description,
                                            authorId: data?.authorId);
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please input price.';
                                        }
                                        if (double.parse(value) <= 0) {
                                          return 'Please input number greater than 0 .';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                )),
                          ),
                          const SizedBox(height: 10.0),
                          const Text('Star Review'),
                          RatingBar.builder(
                            initialRating:
                                widget.editData?.starReview?.toDouble() ?? 3,
                            minRating: 1,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 25,
                            itemPadding: const EdgeInsets.all(5.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                              data = AttrBookResponse(
                                starReview: rating.round(),
                                description: data?.description,
                                code: data?.code,
                                title: data?.title,
                                originallyPublished: data?.originallyPublished,
                                price: data?.price,
                              );
                            },
                          ),
                          ChangeNotifierProvider<AuthorViewModel>(
                            create: (BuildContext context) => authorViewModel,
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 15.0, right: 15.0, top: 5, bottom: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.grey)),
                              child: Column(
                                children: [
                                  Consumer<AuthorViewModel>(
                                      builder: (context, authorViewModel, _) {
                                    switch (authorViewModel.authorList.status) {
                                      case Status.LOADING:
                                        return const Center(
                                            child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: CircularProgressIndicator(
                                            color: Colors.black12,
                                          ),
                                        ));
                                      case Status.ERROR:
                                        return Text(
                                            '${authorViewModel.authorList.message}');
                                      case Status.COMPLETE:
                                        return ListTile(
                                          title: authorViewModel.authorList.data?.data == null
                                              ? Text('${authorViewModel.authorList.message}')
                                              : Text(_authorId == null
                                                  ? 'Select Author'
                                                  : '$_authorName'),
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
                                        return Text('${bookViewModel.bookList.message}');
                                    }
                                  }),
                                  if (_expanded)
                                    SizedBox(
                                        height: 100,
                                        child: ListView.builder(
                                          itemCount: authorViewModel.authorList.data?.data == null
                                              ? 0
                                              : authorViewModel.authorList.data?.data?.length,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              leading: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                    '${authorViewModel.authorList.data?.data?[index].id}'),
                                              ),
                                              title: Text(
                                                  '${authorViewModel.authorList.data?.data?[index].attributes?.name}'),
                                              onTap: () {
                                                setState(() {
                                                  _authorId = authorViewModel.authorList.data?.data?[index].id;
                                                  _authorName = authorViewModel.authorList.data?.data?[index].attributes?.name;
                                                  _expanded = !_expanded;
                                                });
                                              },
                                            );
                                          },
                                        )),
                                ],
                              ),
                            ),
                          ),
                          Consumer<BookViewModel>(
                            builder: (context, bookViewModel, _) {
                              print('save ${bookViewModel.bookResponse.status}');
                              print('save ${bookViewModel.bookResponse.message}');
                              return Container(
                                padding: const EdgeInsets.only(top: 5, left: 15.0, right: 15.0, bottom: 15.0),
                                width: 250,
                                height: 70,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: backgroundColor,
                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                                  onPressed: () {
                                    _saveForm();
                                  },
                                  child: bookViewModel.isLoading == false
                                      ? const Text('SAVE', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                                        )
                                      : const Center(child: CircularProgressIndicator(color: Colors.white,)),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      top: coverHeight - imageHeight / 2,
                      child: Container(
                          width: 150,
                          height: 180,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child: Consumer<BookViewModel>(
                            builder: (context, value, _) {
                              print('${value.imageResponse.status}');
                              print('${value.imageResponse.message}');
                              imageId = value.imageResponse.data?.id;
                              print(' image Id: $imageId');
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
                          )),
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
