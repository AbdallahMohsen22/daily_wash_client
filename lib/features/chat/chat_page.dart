import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/features/chat/widget/chat_app_bar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<types.Message> _messages = [];
  final _user = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
  );

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleAttachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: Container(
          color: ColorResources.white,
          height: 144,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleImageSelection();
                },
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    'Photo',
                    style: bottomSheetTextStyle(),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleFileSelection();
                },
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    'File',
                    style: bottomSheetTextStyle(),
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    'Cancel',
                    style: bottomSheetTextStyle(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleFileSelection() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.any,
      );
      if (result != null && result.files.single.path != null) {
        final message = types.FileMessage(
          author: _user,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: const Uuid().v4(),
          mimeType: lookupMimeType(result.files.single.path!),
          name: result.files.single.name,
          size: result.files.single.size,
          uri: result.files.single.path!,
        );

        _addMessage(message);
      }
    } catch (e) {
      throw ("FilePicker Error: $e");
    }
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: const Uuid().v4(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      _addMessage(message);
    }
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final index =
              _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (_messages[index] as types.FileMessage).copyWith(
            isLoading: true,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final index =
              _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (_messages[index] as types.FileMessage).copyWith(
            isLoading: null,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });
        }
      }

      //await OpenFilex.open(localPath);
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (_messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    setState(() {
      _messages[index] = updatedMessage;
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    _addMessage(textMessage);
  }

  void _loadMessages() async {
    try {
      final response =
          await rootBundle.loadString('assets/messages/messages.json');

      if (response.isNotEmpty) {
        final List<dynamic> jsonList = jsonDecode(response);

        // ignore: unnecessary_null_comparison
        if (jsonList != null) {
          final messages = jsonList
              .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
              .toList();

          setState(() {
            _messages = messages;
          });
        } else {
          throw ('Failed to decode JSON. jsonList is null.');
        }
      } else {
        throw ('Empty or null response from asset file.');
      }
    } catch (error) {
      print('Error loading messages: $error');
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const ChatAppBar(),
        body: Chat(
          messages: _messages,
          onAttachmentPressed: _handleAttachmentPressed,
          onMessageTap: _handleMessageTap,
          onPreviewDataFetched: _handlePreviewDataFetched,
          onSendPressed: _handleSendPressed,
          showUserAvatars: true,
          showUserNames: true,
          user: _user,
        ),
      );
}

TextStyle bottomSheetTextStyle() {
  return FontManager.getBoldStyle(
    fontSize: AppSize.sp16,
    color: ColorResources.black,
  );
}
