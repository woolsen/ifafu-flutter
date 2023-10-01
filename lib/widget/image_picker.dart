import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class ImagePicker {
  static const _duration = Duration(milliseconds: 200);

  static Future<List<AssetEntity>?> pickMulti(
    BuildContext context, {
    List<AssetEntity>? selectedAssets,
    int maxAssets = 6,
    RequestType requestType = RequestType.image,
  }) async {
    final List<AssetEntity>? entities = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        selectedAssets: selectedAssets,
        maxAssets: maxAssets,
        requestType: requestType,
      ),
    );
    Future.delayed(_duration).then((value) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    });
    return entities;
  }

  static Future<File?> pick(BuildContext context) async {
    final List<AssetEntity>? entities = await pickMulti(context, maxAssets: 1);
    if (entities == null || entities.isEmpty) {
      return null;
    } else {
      return await entities[0].file;
    }
  }

  static Future<File?> pickWithCrop(
    BuildContext context, {
    CropAspectRatio? aspectRatio,
    ImageCompressFormat? compressFormat,
  }) async {
    final image = await pick(context);
    if (image == null) {
      return null;
    }
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatio: aspectRatio,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: '裁剪照片',
          toolbarColor: Colors.white,
          hideBottomControls: true,
          toolbarWidgetColor: Colors.black,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          minimumAspectRatio: 1.0,
          title: '裁剪照片',
          aspectRatioLockEnabled: true,
        ),
      ],
    );
    return croppedFile == null ? null : File(croppedFile.path);
  }
}
