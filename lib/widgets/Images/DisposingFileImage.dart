import 'package:flutter/material.dart';

class DisposingFileImage extends StatefulWidget {
  final FileImage image;
  const DisposingFileImage({super.key, required this.image});

  @override
  State<DisposingFileImage> createState() => _DisposingFileImageState();
}

class _DisposingFileImageState extends State<DisposingFileImage> {
  @override
  void dispose() {
    // TODO: implement dispose
    ImageCache().evict(widget.image);
    ImageCache().clear();
    ImageCache().clearLiveImages();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Image(image: widget.image);
}
