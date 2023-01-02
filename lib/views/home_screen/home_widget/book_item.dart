import 'package:flutter/material.dart';
import '../../../models/book.dart';

class BookItem extends StatelessWidget {
  const BookItem({
    Key? key,
    required this.book,
  }) : super(key: key);

  final Attributes? book;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10.0),
        height: 150,
        //color: Colors.cyanAccent,
        child: Row(
          children: [
            Container(
              height: 140,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: book?.thumnail?.data?.attributes?.url != null
                  ? ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      '${book?.thumnail?.data?.attributes?.url}',
                      fit: BoxFit.fill,
                      loadingBuilder: (context, child, progress) {
                        return progress == null
                            ? child
                            : const Center(
                                child: CircularProgressIndicator());
                      },
                    ),
                  )
                  : ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      'assets/img/image-placeholder.png',
                      fit: BoxFit.fill,
                    ),
                  ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${book?.author?.data?.attributes?.name}',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w300),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      '${book?.title}',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17,),
                    )
                  ],
                ),
              ),
            ),
            const Center(
              child: Icon(
                Icons.arrow_forward_ios,
              ),
            )
          ],
        ));
  }
}
