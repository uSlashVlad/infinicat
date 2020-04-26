import 'package:flutter/material.dart';
import 'package:infinicat/widgets/micro_widgets.dart';

class Picture extends StatelessWidget {
  Picture(this.src);

  final String src;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      src,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return (child != null) ? child : LoadingText();
        } else {
          return (loadingProgress.expectedTotalBytes != null)
              ? Center(
                  child: CircularProgressIndicator(
                    value: (loadingProgress.expectedTotalBytes != null)
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes
                        : null,
                  ),
                )
              : LoadingText();
        }
      },
    );
  }
}
