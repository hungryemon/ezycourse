import 'package:cached_network_image/cached_network_image.dart';
import 'package:ezycourse/app/helpers/constants/asset_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final String? placeholderPath;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final double? borderRadius;

  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.placeholderPath,
    this.height,
    this.width,
    this.fit,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: imageUrl == ""
          ? Image.asset(
              placeholderPath ?? AssetConstants.userPlaceholder,
              fit: fit,
              height: height,
              width: width,
            )
          : imageUrl.endsWith('.svg')
              ? SvgPicture.network(
                  imageUrl,
                  height: height,
                  width: width,
                )
              : CachedNetworkImage(
                  height: height,
                  width: width,
                  imageUrl: imageUrl,
                  fit: fit,
                  placeholder: (context, url) => Image.asset(
                    placeholderPath ?? AssetConstants.userPlaceholder,
                    fit: fit,
                    height: height,
                    width: width,
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    placeholderPath ?? AssetConstants.userPlaceholder,
                    fit: fit,
                    height: height,
                    width: width,
                  ),
                ),
    );
  }
}
