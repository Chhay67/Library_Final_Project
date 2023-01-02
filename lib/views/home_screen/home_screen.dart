import 'dart:math';
import 'package:flutter/material.dart';
import 'package:library_final_project/views/add_edit_book_screen/add_edit_book_screen.dart';
import '../../data/network/network_service.dart';
import '../../models/book_response.dart';
import '../../views/detail_screen/detail_screen.dart';
import '../../res/constraint/constraint.dart';
import '../../view_models/author_view_model.dart';
import '../add_edit_author_screen/add_edit_author_screen.dart';
import '../drawer/drawer_bar.dart';
import '/models/book.dart';
import '/view_models/book_view_model.dart';
import 'package:provider/provider.dart';
import '../../data/response/status.dart';
import 'home_widget/book_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BookViewModel bookViewModel = BookViewModel();
  AuthorViewModel authorViewModel = AuthorViewModel();
  AttrBookResponse editData = AttrBookResponse();

  List<BookData>? books = [];
  List<BookData>? displayBook = [];
  List<BookData>? result = [];

  bool isNoData = true;
  int? bookId;
  String? bookCode;

  Future<void> refreshScreen() async {
    await bookViewModel.fetchAllBooks();
    isNoData = true;
  }

  @override
  void initState() {
    bookViewModel.fetchAllBooks();
    authorViewModel.fetchAllAuthor();
    super.initState();
  }

  void searchByTitle(String value) {
    displayBook = books;
    result = displayBook
        ?.where((element) => element.attributes!.title!.toLowerCase().contains(value.toLowerCase())).toList();
    setState(() {
      displayBook = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    var networkStatus = Provider.of<NetworkStatus>(context);
    return Scaffold(
      backgroundColor: backgroundColor,
     drawer:const DrawerBar(),
     drawerScrimColor: Colors.black,
      appBar: AppBar(
        iconTheme:const IconThemeData(color: Colors.black,size: 33),
        title: const Text('HOME', style: headingStyle),
        centerTitle: true,
        backgroundColor: backgroundColor,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) =>
                      AlertDialog(
                        title:const Text('Which one you want to add Book or Author?'),
                        actionsAlignment: MainAxisAlignment.center,
                        alignment: Alignment.center,
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AddEditBookScreen(Random().nextInt(10000), null, null, Option.ADDBOOK, 'ADD BOOK')));

                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: backgroundColor
                              ),
                              child: const Text('BOOK',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold))),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context)=>   AddEditAuthorScreen('ADD AUTHOR',Option.ADDAUTHOR)));

                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: backgroundColor
                              ),
                              child: const Text('AUTHOR',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold))),
                          ElevatedButton(
                              onPressed: (){
                                Navigator.of(context).pop(false);
                              },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).errorColor
                            ), child: const Text('Cancel'),
                          )
                        ],
                      ),
                );
              },
              icon: Image.asset('assets/img/addbook.png', fit: BoxFit.fill)
          ),
          IconButton(
            onPressed: () {
              if (bookCode == null) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(

                  content: Text('Click on book first to edit', textAlign: TextAlign.center,),
                  duration: Duration(seconds: 2)));
              } else {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddEditBookScreen(bookId, bookCode, editData,Option.EDITBOOK, 'EDIT BOOK')));
              }
            },
            icon: const Icon(Icons.edit_rounded)),
        ],
      ),
      body: SafeArea(
        child: ChangeNotifierProvider<BookViewModel>(
          create: (BuildContext context) => bookViewModel,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.12,
                color: backgroundColor,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 21.0, right: 21.0),
                      child: TextField(
                        style: const TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none),
                          hintText: 'what would you like to read?',
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                        ),
                        onChanged: (value) {
                          searchByTitle(value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              networkStatus == NetworkStatus.offline
                  ? Expanded(
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(13.0),
                          decoration: boxDecoration,
                          child:const Center(
                           child: Text('no internet connection.'),
                      )))
                  : Expanded(
                      child: RefreshIndicator(
                        onRefresh: refreshScreen,
                        color: Colors.black,
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(13.0),
                            decoration: boxDecoration,
                            child: Consumer<BookViewModel>(
                              builder: (context, bookViewModel, _) {
                                switch (bookViewModel.bookList.status) {
                                  case Status.LOADING:
                                    return const Center(
                                        child: CircularProgressIndicator(color: Colors.black,));
                                  case Status.ERROR:
                                    return ListView(
                                      children: [
                                        const SizedBox(height:200),
                                        Padding(
                                          padding: const EdgeInsets.all(13.0),
                                          child: Text('${bookViewModel.bookList.message}'),
                                        ),
                                        const Center(child: Text('scroll up to refresh',))
                                      ],
                                    );
                                  case Status.COMPLETE:
                                    if (isNoData == true) {
                                      books = bookViewModel.bookList.data!.data;
                                      displayBook = books;
                                      isNoData = false;
                                    }
                                    return displayBook!.isEmpty
                                        ? Center(
                                            child: Text(
                                              books!.isEmpty ? 'No Data' : 'Search not found!!',
                                              style: const TextStyle(fontSize: 16),
                                            ),
                                          )
                                        : ListView.separated(
                                            itemCount: displayBook!.length,
                                            itemBuilder: (context, index) {
                                              var book = displayBook![index];
                                              return Dismissible(
                                                key: ValueKey(book),
                                                background: Container(
                                                  color: Theme.of(context).errorColor,
                                                  alignment: Alignment.centerRight,
                                                  padding: const EdgeInsets.only(right: 20),
                                                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                                                  child: const Icon(
                                                    color: Colors.white,
                                                    Icons.delete,
                                                    size: 40,
                                                  )
                                                ),
                                                direction: DismissDirection.endToStart,
                                                confirmDismiss: (direction) {
                                                  return showDialog(
                                                    context: context,
                                                    builder: (ctx) =>
                                                        AlertDialog(title: const Text('Are you sure?'),
                                                      content: const Text('Do you want to delete the book?'),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.of(context).pop(false);
                                                            },
                                                            child: const Text('No')),
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.of(context).pop(true);
                                                              refreshScreen();
                                                            },
                                                            child: const Text('Yes'))
                                                      ],
                                                    ),
                                                  );
                                                },
                                                onDismissed: (direction) {
                                                  bookViewModel.deleteBook(book.id);
                                                  displayBook?.removeAt(index);
                                                  refreshScreen();
                                                },
                                                child: GestureDetector(
                                                    onTap: () {
                                                      bookId = book.id;
                                                      bookCode = book.attributes?.code.toString();
                                                      editData = AttrBookResponse(
                                                          code: book.attributes?.code,
                                                          title: book.attributes?.title,
                                                          description: book.attributes?.description,
                                                          price: book.attributes?.price,
                                                          starReview: book.attributes?.starReview,
                                                          authorId: book.attributes?.author?.data?.id,
                                                          authorName:book.attributes?.author?.data?.attributes?.name,
                                                          imageId:book.attributes?.thumnail?.data?.id );
                                                      Navigator.of(context).push(MaterialPageRoute(
                                                          builder: (context) {
                                                        return DetailScreen(
                                                          title: book.attributes?.title,
                                                          author: book.attributes?.author?.data?.attributes?.name,
                                                          code: book.attributes?.code,
                                                          des: book.attributes?.description,
                                                          price: book.attributes?.price,
                                                          star: book.attributes?.starReview,
                                                          published: book.attributes?.originallyPublished,
                                                          imageUrl: book.attributes?.thumnail?.data?.attributes?.url,
                                                        );
                                                      }));
                                                    },
                                                    child: BookItem(book: book.attributes,)),
                                              );
                                            },
                                            separatorBuilder: (context, index) => const Divider(thickness: 2,),
                                          );
                                  default:
                                    return Text('${bookViewModel.bookList.message}');
                                }
                              },
                            )),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}



