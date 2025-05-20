import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmptyIcon extends StatelessWidget {
  const EmptyIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: SvgPicture.asset('lib/assets/icons/empty.svg'));
  }
}
