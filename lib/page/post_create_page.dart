import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:ifafu/http/api.dart';
import 'package:ifafu/http/model.dart';
import 'package:ifafu/util/dialog.dart';
import 'package:ifafu/util/extensions.dart';
import 'package:ifafu/util/sp.dart';
import 'package:ifafu/util/toast.dart';
import 'package:ifafu/widget/image_picker.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class PostCreatePage extends StatefulWidget {
  const PostCreatePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PostCreatePageState();
}

class _PostCreatePageState extends State<PostCreatePage> {
  final List<String?> contactTypes = ['QQ', '微信', '手机', null];

  final List<String> areas = ['金山校区', '旗山校区', '安溪校区'];

  final TextEditingController contactController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  String? area;
  String? contactType;
  final _images = <AssetEntity>[];

  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    var contactType = SPUtil.getString('CONTACT_TYPE');
    if (contactType != null) {
      contactController.text = SPUtil.getString('CONTACT_$contactType') ?? '';
    }
    this.contactType = contactType;
    area = SPUtil.getString('AREA');
    setState(() {});
  }

  @override
  void dispose() {
    // 资源释放和清理操作
    contactController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'post_create',
      child: Scaffold(
        appBar: AppBar(
          title: const Text('发布内容'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 联系类型选择
                const Text('联系方式'),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: SegmentedButton<String?>(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.all(0),
                      ),
                    ),
                    segments: contactTypes.map((e) {
                      return ButtonSegment<String?>(
                        value: e,
                        label: Text(e ?? '不显示'),
                      );
                    }).toList(),
                    selected: <String?>{contactType},
                    onSelectionChanged: (newSelection) {
                      contactType = newSelection.first;
                      if (contactType != null) {
                        contactController.text = SPUtil.getString('CONTACT_$contactType') ?? '';
                      } else {
                        contactController.text = '';
                      }
                      setState(() {});
                    },
                  ),
                ),
                // 联系方式输入
                if (contactType != null) ...[
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: contactController,
                    textInputAction: TextInputAction.next,
                    keyboardType: contactType == 'QQ' || contactType == '手机'
                        ? TextInputType.number
                        : TextInputType.text,
                    decoration: InputDecoration(
                      labelText: contactType!,
                      hintText: '请输入$contactType',
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                // 内容输入
                TextFormField(
                  controller: contentController,
                  decoration: const InputDecoration(
                    labelText: '帖子内容',
                    hintText: '请输入帖子内容',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                ),
                // 图片上传
                const SizedBox(height: 16),
                _buildImageLayout(),
                // 校区选择
                GestureDetector(
                  onTap: _showAreaDialog,
                  child: Row(
                    children: [
                      const Icon(Icons.location_on_outlined),
                      const SizedBox(width: 8, height: 80),
                      const Text(
                        '校区',
                        style: TextStyle(fontSize: 16),
                      ),
                      const Spacer(),
                      Text(
                        area ?? '选择校区',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Icon(Icons.arrow_right),
                    ],
                  ),
                ),
                // 提交按钮
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _submitting ? null : submit,
                    child: _submitting
                        ? const CircularProgressIndicator()
                        : const Text('发布'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageLayout() {
    return LayoutBuilder(builder: (context, constraints) {
      final double size;
      const int lineCount = 3;
      size = (constraints.maxWidth - (lineCount - 1) * 4) / 3;
      final widgets = <Widget>[];
      var row = <Widget>[];
      var first = true;
      for (var image in _images) {
        if (row.length == lineCount * 2 - 1) {
          row.add(const SizedBox(height: 4));
          widgets.add(Row(children: row));
          row = <Widget>[];
          first = true;
        }
        if (first) {
          first = false;
        } else {
          row.add(const SizedBox(width: 4));
        }
        row.add(FutureBuilder<File?>(
            future: image.file,
            builder: (context, snapshot) {
              File? file = snapshot.data;
              if (file == null) {
                return SizedBox(
                  height: size,
                  width: size,
                );
              } else {
                return Stack(
                  children: [
                    Image.file(
                      file,
                      height: size,
                      width: size,
                      filterQuality: FilterQuality.medium,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _images.remove(image);
                          });
                        },
                        child: Container(
                          color: Colors.black12,
                          padding: const EdgeInsets.all(2.0),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            }));
      }
      if (_images.length < 6) {
        if (row.length == lineCount * 2 - 1) {
          row.add(const SizedBox(height: 4));
          widgets.add(Row(children: row));
          row = <Widget>[];
        } else {
          row.add(const SizedBox(width: 4));
        }
        row.add(GestureDetector(
          onTap: _pickImage,
          child: Container(
            height: size,
            width: size,
            decoration: const BoxDecoration(
              color: Color(0xFFF3F4F8),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.camera_alt,
                  color: Color(0xFF989EB4),
                  size: 40,
                ),
                SizedBox(height: 4),
                Text(
                  '照片/视频',
                  style: TextStyle(
                    color: Color(0xFF989EB4),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ));
      }
      widgets.add(const SizedBox(height: 4));
      widgets.add(Row(children: row));
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgets,
      );
    });
  }

  void _pickImage() async {
    var images = await ImagePicker.pickMulti(
      context,
      selectedAssets: _images,
    );
    if (images == null) {
      return;
    }
    setState(() {
      _images.clear();
      _images.addAll(images);
    });
  }

  Future<void> _showAreaDialog() async {
    final result = await showSimpleDialog(context, areas, title: '选择校区');
    if (result != null) {
      area = result;
      setState(() {});
    }
  }

  void submit() async {
    if (contentController.text.isBlank) {
      ToastUtil.show('请输入帖子内容');
      return;
    }
    if (contactType != null && contactController.text.isBlank) {
      ToastUtil.show('请输入联系方式。若不显示联系方式，联系方式请选择『不显示』');
      return;
    }
    if (contactType == 'QQ') {
      if (!RegExp(r'^\d{5,11}$').hasMatch(contactController.text)) {
        ToastUtil.show('QQ号格式不正确。若不显示联系方式，联系方式请选择『不显示』');
        return;
      }
    } else if (contactType == '微信') {
      if (!RegExp(r'^[a-zA-Z\d_-]{5,}$').hasMatch(contactController.text)) {
        ToastUtil.show('微信号格式不正确。若不显示联系方式，联系方式请选择『不显示』');
        return;
      }
    } else if (contactType == '手机') {
      if (!RegExp(r'^1\d{10}$').hasMatch(contactController.text)) {
        ToastUtil.show('手机号格式不正确。若不显示联系方式，联系方式请选择『不显示』');
        return;
      }
    }
    if (area == null) {
      ToastUtil.show('请选择校区');
      return;
    }
    _submitting = true;
    setState(() {});
    try {
      final imageUrls = <String>[];
      for (var image in _images) {
        final file = await image.file;
        if (file != null) {
          final result =
              await Api.instance.uploadPostImage(MultipartFile.fromFileSync(
            file.path,
            filename: file.path.split('/').last,
            contentType: image.mimeType != null
                ? MediaType.parse(image.mimeType!)
                : null,
          ));
          imageUrls.add(result);
        }
      }
      Post post = await Api.instance.createPost(
        PostCreate(
          content: contentController.text,
          contactType: contactType,
          contact: contactController.text,
          area: area!,
          images: imageUrls,
        ),
      );
      _submitting = false;
      ToastUtil.show('发布成功');
      if (contactType != null) {
        SPUtil.setString('CONTACT_TYPE', contactType!);
        SPUtil.setString('CONTACT_$contactType', contactController.text);
      }
      _pop(post);
    } catch (e) {
      _submitting = false;
      setState(() {});
      ToastUtil.show('发布失败');
    }
  }

  _pop(Post result) {
    Navigator.pop(context, result);
  }
}
