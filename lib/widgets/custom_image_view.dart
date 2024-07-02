// ignore_for_file: must_be_immutable

import 'dart:ffi';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/utils/image_constant.dart';
import '../theme/theme_helper.dart';

class CustomImageView extends StatelessWidget {
  ///[imagePath] is required parameter for showing image
  String? imagePath;
  String? personName;
  double? textSize = 18.0;
  double? height;
  double? width;
  bool? isUser;
  Color? color;
  BoxFit? fit;
  final String placeHolder;
  Alignment? alignment;
  VoidCallback? onTap;
  EdgeInsetsGeometry? margin;
  BorderRadius? radius;
  BoxBorder? border;

  ///a [CustomImageView] it can be used for showing any type of images
  /// it will shows the placeholder image if image is not found on network image
  CustomImageView({
    this.imagePath,
    this.personName,
    this.isUser,
    this.textSize,
    this.height,
    this.width,
    this.color,
    this.fit,
    this.alignment,
    this.onTap,
    this.radius,
    this.margin,
    this.border,
    this.placeHolder = 'assets/images/img_image.png',
  });
  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment!,
            child: _buildWidget(),
          )
        : _buildWidget();
  }

  Widget _buildWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: _buildCircleImage(),
      ),
    );
  }

  ///build the image with border radius
  _buildCircleImage() {
    if (radius != null) {
      return ClipRRect(
        borderRadius: radius ?? BorderRadius.zero,
        child: _buildImageWithBorder(),
      );
    } else {
      return _buildImageWithBorder();
    }
  }

  ///build the image with border and border radius style
  _buildImageWithBorder() {
    if (border != null) {
      return Container(
        decoration: BoxDecoration(
          border: border,
          borderRadius: radius,
        ),
        child: _buildImageView(),
      );
    } else {
      return _buildImageView();
    }
  }

  Widget _buildImageView() {
    if (null != imagePath && imagePath != "null" && imagePath != "") {
      switch (imagePath?.imageType) {
        case ImageType.svg:
          return Container(
            height: height,
            width: width,
            child: SvgPicture.asset(
              imagePath ?? ImageConstant.imgImage,
              height: height,
              width: width,
              fit: fit ?? BoxFit.contain,
              colorFilter: color != null
                  ? ColorFilter.mode(
                      this.color ?? Colors.transparent, BlendMode.srcIn)
                  : null,
            ),
          );
        case ImageType.file:
          return Image.file(
            File(imagePath ?? ""),
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
            color: color,
          );
        case ImageType.network:
          return ClipRRect(
            child: CachedNetworkImage(
              height: height,
              width: width,
              fit: fit,
              imageUrl: imagePath ?? ImageConstant.imgImage,
              color: color,
              placeholder: (context, url) => Container(
                height: 30,
                width: 30,
                child: LinearProgressIndicator(
                  color: Colors.grey.shade200,
                  backgroundColor: Colors.grey.shade100,
                ),
              ),
              errorWidget: (context, url, error) => Image.asset(
                placeHolder,
                height: height,
                width: width,
                fit: fit ?? BoxFit.cover,
              ),
            ),
          );
        case ImageType.png:
        default:
          return Image.asset(
            imagePath ?? ImageConstant.imgImage,
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
            color: color,
          );
      }
    } else {
      if (personName != null && personName != "" && personName != "null") {
        return Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                personName?.substring(0, 2).toUpperCase() ?? "",
                style: TextStyle(
                  color: appTheme.amber300,
                  fontSize: textSize,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w800,
                ),
              ),
            ));
      } else {
        if (isUser ?? false) {
          return Image.asset(
            ImageConstant.imgImage,
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
            color: color,
          );
        } else {
          return Image.asset(
            ImageConstant.imgImage,
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
            color: color,
          );
        }
      }
    }
  }
}

extension ImageTypeExtension on String {
  ImageType get imageType {
    if (this.startsWith('http') || this.startsWith('https')) {
      return ImageType.network;
    } else if (this.endsWith('.svg')) {
      return ImageType.svg;
    } else if (this.startsWith('file://')) {
      return ImageType.file;
    } else if (this.startsWith('file://')) {
      return ImageType.file;
    } else {
      return ImageType.png;
    }
  }
}

enum ImageType { svg, png, network, file, unknown }
