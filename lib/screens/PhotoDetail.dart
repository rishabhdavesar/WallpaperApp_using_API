import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:photo_view/photo_view.dart';

class PhotoDetails extends StatefulWidget {
  final String url;

  final String tag;

  const PhotoDetails({Key key, this.url, this.tag}) : super(key: key);

  @override
  _PhotoDetailsState createState() => _PhotoDetailsState();
}

class _PhotoDetailsState extends State<PhotoDetails> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
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
          Hero(
            transitionOnUserGestures: true,
            tag: widget.tag,
            child: Container(
                color: Colors.transparent,
                height: h,
                width: w,
                child: PhotoView(
                    initialScale: 1.0,
                    tightMode: true,
                    imageProvider: NetworkImage(
                      widget.url,
                    ))),
          )
        ],
      ),
    );
  }
}
