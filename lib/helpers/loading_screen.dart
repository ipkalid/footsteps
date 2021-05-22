import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:footsteps/helpers/image_path.dart';
import 'package:lottie/lottie.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
            child: Container(
              color: Colors.black.withOpacity(0.05),
            ),
          ),
        ),
        Lottie.asset(
          ImagePath.loading,
          width: 256,
        )
      ],
    );
  }
}
