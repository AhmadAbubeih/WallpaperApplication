import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../Utils/color_utils.dart';

class WaitingWidget extends StatelessWidget {
  const WaitingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SpinKitRing(
      color: progressColor,
      size: 50.0,
      lineWidth: 3.5,
    );
  }
}
