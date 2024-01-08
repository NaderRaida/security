import 'package:app/constants/colors.dart';
import 'package:app/constants/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomImage extends StatelessWidget {
  final String image;
  final double? imageWidth;
  final double? imageHeight;
  final BoxFit? fit;
  final FilterQuality? quality;
  final bool fromOnBoarding;
  final Color? color;

  CustomImage({
    required this.image,
    this.imageWidth,
    this.imageHeight,
    this.fit,
    this.quality,
    this.color,
    this.fromOnBoarding = false,
  });

  @override
  Widget build(BuildContext context) {
    return image.split(".").last.toLowerCase() == SVG ?
    SvgPicture.asset(
      image,
      fit: fit ?? BoxFit.contain,
      width: imageWidth,
      height: imageHeight,
      color: color,
    ) :
    image.split(".").last.toLowerCase() == PNG ?
    Image.asset(
      image,
      width: imageWidth,
      height: imageHeight,
      fit: fit,
      filterQuality: quality ?? FilterQuality.low,
    ) :
    CachedNetworkImage(
      imageUrl: image,
      width: imageWidth,
      height: imageHeight,
      fit: fit,
      fadeOutDuration: Duration(seconds: 0),
      filterQuality: quality ?? FilterQuality.low,
      placeholder: (context, url) => SizedBox(

      ),
      errorWidget: (context, url, error) => Container(color:  fromOnBoarding ? Colors.transparent :gray,),
    );
  }
}
