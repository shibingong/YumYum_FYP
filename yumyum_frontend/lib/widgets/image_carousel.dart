import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageCarouselWidget extends StatefulWidget {
  final List<Image> images;
  final double _height;
  final bool _autoPlay;
  ImageCarouselWidget(this.images,
      {double height = 200.0, bool autoPlay = false})
      : _height = height,
        _autoPlay = autoPlay;

  @override
  _ImageCarouselWidgetState createState() => _ImageCarouselWidgetState();
}

class _ImageCarouselWidgetState extends State<ImageCarouselWidget> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(width: double.infinity, height: 200),
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          CarouselSlider(
            options: CarouselOptions(
                autoPlay: widget._autoPlay,
                height: widget._height,
                viewportFraction: 1.0,
                onPageChanged: (currentPage, _) {
                  setState(() {
                    _currentPage = currentPage;
                  });
                }),
            items: widget.images
                .map((image) => Container(width: double.infinity, child: image))
                .toList(),
          ),
          Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(8.0)),
              child: Text('${_currentPage + 1}/${widget.images.length}'))
        ],
      ),
    );
  }
}
