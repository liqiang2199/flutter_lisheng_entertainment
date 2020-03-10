
import 'dart:io';

import 'package:dio/dio.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_lisheng_entertainment/Util/ColorUtil.dart';
import 'package:flutter_lisheng_entertainment/base/BaseController.dart';
import 'package:flutter_lisheng_entertainment/model/json/up_load_file/UpLoadFileResultBeen.dart';
import 'package:flutter_lisheng_entertainment/net/UrlUtil.dart';
import 'package:flutter_lisheng_entertainment/view/common/CommonView.dart';
import 'package:flutter_lisheng_entertainment/view/common/loading.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

abstract class BaseChoicePhotoController<T extends StatefulWidget> extends BaseController<T>  {


  //记录选择的照片
  File _image;

  //拍照
  Future _getImageFromCamera() async {
    var image =
    await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 400);
    if (image != null) {
      File croppedFile = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          )
      );
      setState(() {
        _image = croppedFile;
        uploadImg(_image);
      });
    }

  }

  //相册选择
  Future _getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File croppedFile = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Color(ColorUtil.butColor),
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          )
      );
      setState(() {
        _image = croppedFile;
        uploadImg(_image);


      });
    }

  }


  // 上传图片
  void uploadImg(imgfile) async{
    _showLoadingDialog();
    String path = imgfile.path;
    var name = path.substring(path.lastIndexOf("/") + 1, path.length);
//    UserService.instance.upload(imgfile);
    FormData formData = new FormData.fromMap({
//      "file": new UploadFileInfo(new File(path), name)
      "file": await MultipartFile.fromFile(path,filename: name),
//      "file": path
    });

//    Map<String, dynamic> headers = new Map();
//    headers["Content-Type"] = "multipart/form-data";
//    headers["Content-Type"] = "application/json";
//    headers["Content-Type"] = "application/x-www-form-urlencoded";
    Options options = RequestOptions(
//        headers: headers,
      method: "POST",
      responseType: ResponseType.json,
      baseUrl: UrlUtil.BaseUrl,
      contentType: "multipart/form-data",
    );

    Response response;
    Dio dio =new Dio();
    dio.interceptors.add(LogInterceptor(responseBody: true)); //开启请求日志
    response =await dio.post(
        '${UrlUtil.commonUpload}',
        data: formData,
        options: options,
      onSendProgress: (received, total) {
        if (total != -1) {
          print((received / total * 100).toStringAsFixed(0) + "%");
        }
      },
    );
    Navigator.pop(context);
    if(response.statusCode == 200){
      print("上传服务器 = ${response.data}");
      var upLoadFileResultBeen = UpLoadFileResultBeen.fromJson(response.data);
      if (upLoadFileResultBeen.code == 1) {
        upLoadFileSuccessful(upLoadFileResultBeen.data.url);
      } else {
        showToast("上传失败");
      }
    }else{
      showToast("上传失败");
    }
  }

  /// 加载弹窗 提示 弹窗
  _showLoadingDialog() {
    if (context == null) {
      return;
    }
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new LoadingDialog(loadTip: "上传中...",);
        });
  }

  /// 底部相册选择弹窗
  Future openModalBottomSheet() async {
    final option = await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 175.0,
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    '拍照',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Color(ColorUtil.textColor_333333),
                    ),
                  ),
                  onTap: () {
                    _getImageFromCamera();
                    Navigator.pop(context, '拍照');
                  },
                ),
                CommonView().commonLine(context),
                ListTile(
                  title: Text(
                    '从相册选择',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Color(ColorUtil.textColor_333333),
                    ),
                  ),
                  onTap: () {
                    _getImageFromGallery();
                    Navigator.pop(context, '从相册选择');
                  },
                ),
                CommonView().commonLine(context),
                ListTile(
                  title: Text(
                    '取消',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Color(ColorUtil.textColor_333333),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context, '取消');
                  },
                ),
              ],
            ),
          );
        }
    );

  }

  /// 上传图片 成功
  void upLoadFileSuccessful(String urlImg);
}

class UploadFileInfo {

  File file;
  String pathName;

  UploadFileInfo(this.file, this.pathName);


}