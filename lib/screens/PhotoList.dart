import 'dart:ui' as ui;

import 'package:apicall_provider/photoProvider.dart';
import 'package:apicall_provider/screens/PhotoDetail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhotoListView extends StatefulWidget {
  @override
  _PhotoListViewState createState() => _PhotoListViewState();
}

class _PhotoListViewState extends State<PhotoListView> {
  final ScrollController _controller = ScrollController();

  fetchData() {
    Provider.of<PhotoProvider>(context, listen: false).callPhotoApi();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData();
    });
    super.initState();
    _controller.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      fetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
                height: h,
                color: Colors.transparent,
                child: Image.asset(
                  'assets/bg.jpg',
                  fit: BoxFit.cover,
                )),
            Container(
              height: MediaQuery.of(context).size.height,
              child: BackdropFilter(
                child: Container(
                  height: h,
                  color: Colors.grey.shade200.withOpacity(0.5),
                ),
                filter: ui.ImageFilter.blur(sigmaX: 18.0, sigmaY: 18.0),
              ),
            ),
            OrientationBuilder(
              builder: (context, orientation) {
                return Consumer<PhotoProvider>(
                  builder: (context, data, __) {
                    if (data != null || data.photos != null || data.photos.length != 0) {
                      if (orientation == Orientation.portrait) {
                        return body(data);
                      } else {
                        return Row(
                          children: [
                            Expanded(flex: 5, child: body(data)),
                            Expanded(
                                flex: 5,
                                child: Center(
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Text('Photos provided by Pexels'),
                                        Text(
                                          'Developed by Rishabh Sharma',
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                        ),
                                      ],
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                    ),
                                  ),
                                ))
                          ],
                        );
                      }
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                );
              },
            ),
          ],
        ));
  }

  Widget body(data) {
    double h = MediaQuery.of(context).size.height;

    return Container(
      color: Colors.transparent,
      child: ListView.builder(
          controller: _controller,
          itemCount: data.photos.length,
          itemBuilder: (context, index) {
            if (index == data.photos.length - 1) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) =>
                            PhotoDetails(tag: data.photos[index].id.toString(), url: data.photos[index].src.large2x.toString())));
              },
              child: Container(
                height: h / 2,
                margin: EdgeInsets.all(h / 18),
                child: Hero(
                  transitionOnUserGestures: true,
                  tag: data.photos[index].id.toString(),
                  child: Image.network(
                    data.photos[index].src.medium.toString(),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
