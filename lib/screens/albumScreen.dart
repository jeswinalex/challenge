import 'package:codingchallenge/models/albumModel.dart';
import 'package:codingchallenge/models/photoModels.dart';
import 'package:codingchallenge/screens/photoScreen.dart';
import 'package:image_viewer/image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AlbumPage extends StatefulWidget {
  const AlbumPage({super.key});

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  List<Album>? albums;
  // List<Photos>? photos;
  bool? isLoading;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey,
        centerTitle: true,
        title: Text(
          'Album Screen',
        ),
      ),
      body: FutureBuilder<List<Photo>>(
        future: fetchPhotos(http.Client()),
        builder: (context, snapshot) {
          List<Photo>? snap = snapshot.data;
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: snap!.length,
              itemBuilder: (context, index) {
                return Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(PhotoScreen());
                      },
                      child: Image.network(
                        snap[index].thumbnailUrl,
                        errorBuilder: (context, error, stackTrace) {
                          return Text('Erroor');
                        },
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                          onPressed: () {
                            Get.bottomSheet(
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.yellowAccent,
                                  borderRadius: BorderRadius.circular(
                                    20,
                                  ),
                                ),
                                height: height / 2,
                                child: Image.network(
                                  snap[index].url,
                                  fit: BoxFit.contain,
                                  height: 200,
                                ),
                              ),
                            );
                          },
                          child: Text('Preview')),
                    )
                  ],
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
