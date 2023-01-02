import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../res/constraint/constraint.dart';

class DetailScreen extends StatelessWidget {
  final String? title;
  final String? code;
  final String? author;
  final String? imageUrl;
  final int? price;
  final String? published;
  final String? des;
  final int? star;
  const DetailScreen(
      {super.key,
        required this.title,
        required this.author,
        required this.imageUrl,
        required this.des,
        required this.code,
        required this.published,
        required this.star,
        required this.price});

  @override
  Widget build(BuildContext context) {
    final double coverHeight = MediaQuery.of(context).size.height * 0.15;
    final double imageHeight = 180;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme:const IconThemeData(color: Colors.black,size: 33),
        backgroundColor: backgroundColor,
        title: const Text(
          'BOOK DETAIL',
          style: headingStyle,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
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
                        Text('$title',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '$author',
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Column(
                            children: [
                              const Text(
                                'Star review',
                                style: titleText,
                              ),
                              RatingBar.builder(
                                ignoreGestures: true,
                                initialRating:star == null? 0 : star!.toDouble(),
                                itemPadding: const EdgeInsets.only(top: 5),
                                itemSize: 20,
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star_sharp,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 130,
                                decoration: const BoxDecoration(
                                  //color: Colors.green,
                                    border: Border(
                                        right: BorderSide(
                                            color: Colors.black12, width: 2))),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Code',
                                      style: titleText,
                                    ),
                                    Text(
                                      '$code',
                                      style: titleContent,
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    //color: Colors.green,
                                      border: Border(
                                          right: BorderSide(
                                              color: Colors.black12,
                                              width: 2))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Price',
                                        style: titleText,
                                      ),
                                      Text(
                                        '$price \$',
                                        style: titleContent,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 130,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('published', style: titleText),
                                    Text(
                                      '$published',
                                      style: titleContent,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 15.0, right: 15.0),
                          child: Divider(
                            thickness: 2,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 5,bottom: 15),
                          child: Text(
                            '$des',
                            style: const TextStyle(fontSize: 16),
                          ),
                        )
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
                      child:  imageUrl != null
                          ? ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            '$imageUrl',
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, progress) {
                            return progress == null
                                ? child
                                : const Center(child:  CircularProgressIndicator(color: Colors.black,)); // progress mean waiting download image from network
                          },
                          ))
                          : ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          'assets/img/image-placeholder.png',
                          fit: BoxFit.fill,
                          width: 150,
                          height: 198,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
