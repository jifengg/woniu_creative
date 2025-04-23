import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:woniu_creative/api/uploader.dart';
import 'package:woniu_creative/utils/logger_utils.dart';

class UploadWidget extends StatefulWidget {
  const UploadWidget({
    super.key,
    this.width = 160.0,
    this.previewUrl,
    this.fileName,
  });

  final double width;

  final String? previewUrl;

  final String? fileName;

  @override
  State<UploadWidget> createState() => _UploadWidgetState();
}

class _UploadWidgetState extends State<UploadWidget> {
  String? previewUrl;

  bool isUploading = false;

  bool isFailed = false;
  String? errorMessage;

  StreamController<double>? progressController;

  String? fileName;

  Timer? timer;

  PlatformFile? selectedFile;

  @override
  void initState() {
    super.initState();
    previewUrl = widget.previewUrl;
    fileName = widget.fileName;
  }

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: SizedBox(
        width: widget.width,
        height: widget.width,
        child:
            isFailed
                ? _buildFailed(context)
                : (isUploading
                    ? _buildUploading(context)
                    : (previewUrl == null
                        ? _buildNormal(context)
                        : _buildPreview(context))),
      ),
    );
  }

  Widget _buildPreview(BuildContext context) {
    return Stack(
      children: [
        Center(child: Image.network(previewUrl!)),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Tooltip(
                message: fileName ?? '',
                child: Text(
                  fileName ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
        Positioned(
          right: 0,
          child: IconButton(
            onPressed: () {
              handleDelete();
            },
            tooltip: '删除',
            icon: Icon(
              Icons.delete_outline,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNormal(BuildContext context) {
    return InkWell(
      onTap: handleAddFile,
      child: Icon(
        Icons.add,
        size: widget.width,
        color: Theme.of(context).colorScheme.outline,
      ),
    );
  }

  Widget _buildUploading(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: StreamBuilder(
            stream: progressController!.stream,
            builder: (context, snapshot) {
              return Stack(
                children: [
                  CircularProgressIndicator(
                    value: snapshot.data ?? 0,
                    strokeWidth: 8,
                    backgroundColor: Theme.of(context).colorScheme.outline,
                    constraints: BoxConstraints.expand(),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          fileName ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '上传中(${((snapshot.data ?? 0) * 100.0).toStringAsFixed(2)}%)...',
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        Positioned(
          right: 0,
          child: IconButton(
            onPressed: handleCancel,
            tooltip: '取消',
            icon: Icon(
              Icons.cancel,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFailed(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  Text(
                    errorMessage ?? '上传失败',
                    overflow: TextOverflow.clip,
                    // maxLines: 2,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(onPressed: handleRetry, child: Text('重试')),
            TextButton(onPressed: handleCancel, child: Text('取消')),
          ],
        ),
      ],
    );
  }

  handleAddFile() async {
    var fprs = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (fprs == null) return;
    var file = fprs.files.first;
    info(file.path);
    selectedFile = file;
    await handleUpload();
  }

  handleRetry() async {
    await handleUpload();
  }

  handleUpload() async {
    var file = selectedFile!;
    setState(() {
      // previewUrl = 'https://img1.baidu.com/it/u=2786614520,3496145671&fm=253';
      isUploading = true;
      fileName = file.name;
      isFailed = false;
      errorMessage = null;
    });
    progressController = StreamController();

    // //模拟
    // var progress = 0.0;
    // timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
    //   if (mounted) {
    //     progress += 0.08123;
    //     progressController!.add(progress);
    //     if (progress >= 1) {
    //       timer.cancel();
    //       setState(() {
    //         isUploading = false;
    //         previewUrl =
    //             'https://img1.baidu.com/it/u=2786614520,3496145671&fm=253';
    //       });
    //     }
    //   }
    // });

    //真实上传
    var localfile = File(file.path!);
    try {
      var uploadData = await uploadFile(
        localfile,
        onSendProgress: (count, total) {
          if (mounted) {
            var progress = count / total;
            progressController!.add(progress);
          }
        },
      );
      setState(() {
        isUploading = false;
        previewUrl = uploadData.previewUrl;
      });
    } catch (e) {
      setState(() {
        errorMessage = e is DioException ? e.message : e.toString();
        isFailed = true;
      });
    }
  }

  handleCancel() {
    setState(() {
      isFailed = false;
      errorMessage = null;
      isUploading = false;
      timer?.cancel();
    });
  }

  void handleDelete() {
    setState(() {
      previewUrl = null;
    });
  }
}
