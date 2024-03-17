import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallary/helpers/image/image_grid.dart';
import 'package:gallary/helpers/message_box.dart';
import 'package:gallary/routs/app_routs.dart';
import 'package:gallary/services/cloud/cloud.dart';
import 'package:photo_gallery/photo_gallery.dart';

import '../widgets/widgets.dart';

class GroupView extends StatelessWidget {
  final GroupData groupData;
  const GroupView({super.key, required this.groupData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade400,
      appBar: GroupInfoAppBar(
        stream:
            context.select((CloudBloc bloc) => bloc.getGroupData(groupData.id)),
        groupId: groupData.id,
        onPress: () {
          Navigator.of(context).pushNamed(
            AppRouts.groupDetailsPage,
            arguments: groupData,
          );
        },
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: StreamBuilder<Iterable<GroupChatMessage>>(
              stream: context
                  .select((CloudBloc bloc) => bloc.getGroupChats(groupData.id)),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    reverse: true,
                    children: snapshot.data!.map<Widget>((item) {
                      switch (item.type) {
                        case infoType:
                          return _infoCardChatBubble(item);
                        case messageType:
                          String? userId = context
                              .select((CloudBloc bloc) => bloc.currentUserId);

                          return MessageChatBubble(
                              chatMessage: item, userId: userId);
                        case imageType:
                          return ImageChatBubble(chatMessage: item);
                        default:
                          return Container();
                      }
                    }).toList(),
                  );
                } else {
                  return Container();
                }
              }),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocBuilder<CloudBloc, CloudState>(
            buildWhen: (previous, current) => current is CloudStateInitial,
            builder: (context, state) {
              if (state is CloudStateInitial &&
                  (state.selectedImages?.isNotEmpty ?? false)) {
                double height = _getContainerHeight(
                    state.selectedImages!.length,
                    MediaQuery.sizeOf(context).height);

                return Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  height: height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    image: (state.selectedImages!.length == 1)
                        ? DecorationImage(
                            fit: BoxFit.cover,
                            image: PhotoProvider(
                                mediumId: state.selectedImages!.first.id))
                        : null,
                    boxShadow: [
                      BoxShadow(color: Colors.lightBlue.shade50),
                    ],
                    color: Colors.white54,
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                              '(${state.selectedImages!.length}) Select Images'),
                          IconButton(
                              onPressed: () {
                                context.read<CloudBloc>().add(
                                      const CloudEventShareImage(clear: true),
                                    );
                                context.read<CloudBloc>().add(
                                      const CloudEventInitial(hasImages: true),
                                    );
                              },
                              style: IconButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.blueGrey),
                              icon: const Icon(Icons.clear))
                        ],
                      ),
                      if (state.selectedImages!.length > 1)
                        Expanded(
                          child: ImageGrid(
                              images: state.selectedImages!, showBorder: false),
                        ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          StreamBuilder<Iterable<ImageData>>(
              stream: context.select((CloudBloc bloc) => bloc.allImages),
              builder: (context, snapshot) {
                return SendImageTextField(
                  onSendMessage: (value) {
                    context.read<CloudBloc>().add(CloudEventSendMessage(
                        groupId: groupData.id, message: value));
                  },
                  onSelectGallary: () async {
                    final Iterable<ImageData> images = snapshot.data ?? [];
                    Navigator.of(context).pushNamed(
                      AppRouts.selectionView,
                      arguments: {
                        'Images': images,
                        'Image': null,
                        'onSelect': () {
                          context.read<CloudBloc>().add(
                                const CloudEventInitial(hasImages: true),
                              );
                          Navigator.pop(context);
                        }
                      },
                    );
                  },
                );
              }),
        ],
      ),
    );
  }

  Widget _infoCardChatBubble(GroupChatMessage item) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
      alignment: Alignment.center,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
          child: Text(item.data),
        ),
      ),
    );
  }

  double _getContainerHeight(int length, double height) {
    switch (length) {
      case 1:
        return height * .4;
      case 2:
      case 3:
        return 200;
      default:
        return 300;
    }
  }
}

class ImageChatBubble extends StatelessWidget {
  const ImageChatBubble({super.key, required this.chatMessage});
  final GroupChatMessage chatMessage;

  @override
  Widget build(BuildContext context) {
    final images = formatImageShape(chatMessage.data);
    return Container(
      margin: const EdgeInsets.only(top: 25.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.lightBlue.shade50),
        ],
        color: Colors.white54,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          FutureBuilder<MembersData>(
              future: chatMessage.senderInfo,
              builder: (context, snapshot) {
                return ListTile(
                  leading: InkWell(
                    onTap: () {},
                    child: CircleAvatar(
                      foregroundImage: (snapshot.data?.imageURL == null)
                          ? null
                          : NetworkImage(snapshot.data!.imageURL!),
                      child: const Icon(Icons.person),
                    ),
                  ),
                  title: Text(
                    snapshot.data?.name ?? '',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(snapshot.data?.info ?? ''),
                  trailing: Text(formateDate(chatMessage.date)),
                );
              }),
          if (chatMessage.message?.isNotEmpty ?? false)
            Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(8.0).copyWith(top: 0.0),
              decoration: BoxDecoration(
                  color: Colors.lightBlueAccent.shade100.withAlpha(100),
                  borderRadius: BorderRadius.circular(8.0)),
              child: RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  text: chatMessage.message,
                  style: const TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
            ),
          (images.firstOrNull?.length == 1)
              ? FutureBuilder<dynamic>(
                  future: images.firstOrNull?.firstOrNull,
                  builder: (context, snapshot) => ThumbnailGridImage(
                      image: snapshot.data, size: 350, chatId: chatMessage.id))
              : ImageGridLayout(images: images, chatId: chatMessage.id),
          const SizedBox(height: 5.0)
        ],
      ),
    );
  }

  String formateDate(DateTime? dateTime) {
    if (dateTime == null) {
      return '';
    } else {
      return dateTime
          .toIso8601String()
          .splitMapJoin(
            'T',
            onMatch: (p0) => '\n',
          )
          .split(':')
          .sublist(0, 2)
          .join(':');
    }
  }

  List<List<Future<dynamic>>> formatImageShape(dynamic images) {
    final tempImages = [];
    tempImages.addAll(images);
    List<List<Future<dynamic>>> formatedImages = [];
    while (tempImages.isNotEmpty) {
      switch (tempImages.length) {
        case 1:
          var first = tempImages.removeAt(0);
          formatedImages.add([first]);
          break;
        case 2:
          var first = tempImages.removeAt(0);
          var second = tempImages.removeAt(0);
          formatedImages.add([first, second]);
          break;
        default:
          var first = tempImages.removeAt(0);
          var second = tempImages.removeAt(0);
          var third = tempImages.removeAt(0);
          formatedImages.add([first, second, third]);
      }
    }
    return formatedImages;
  }
}

class ImageGridLayout extends StatelessWidget {
  const ImageGridLayout({super.key, required this.images, this.chatId});

  final List<List<Future>> images;
  final String? chatId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: images
          .map((batch) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: batch
                    .map((image) => FutureBuilder<dynamic>(
                        future: image,
                        builder: (context, snapshot) => ThumbnailGridImage(
                            image: snapshot.data, chatId: chatId)))
                    .toList(),
              ))
          .toList(),
    );
  }
}

class ThumbnailGridImage extends StatelessWidget {
  const ThumbnailGridImage(
      {super.key, required this.image, this.size = 110, this.chatId});

  final ImageData? image;
  final String? chatId;
  final double size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (image?.mediumType == MediumType.image) {
          image?.tag = 'Group${image?.id}$chatId';
          Navigator.of(context).pushNamed(
            AppRouts.viewImagePage,
            arguments: image,
          );
        } else if (image?.mediumType == MediumType.video) {
          MessageBox.showMessage(context, image?.mimeType ?? '');
          // open video file
        }
      },
      child: (image?.imageURL != null)
          ? Hero(
              tag: 'Group${image?.id}$chatId',
              child: Container(
                height: size,
                width: size,
                margin: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    image: (image?.imageURL != null)
                        ? DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(image!.imageURL!))
                        : null,
                    borderRadius: BorderRadius.circular(12.0)),
              ),
            )
          : Container(
              height: size,
              width: size,
              margin: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(12.0)),
            ),
    );
  }
}

class SendImageTextField extends StatefulWidget {
  const SendImageTextField(
      {super.key,
      required this.onSelectGallary,
      required this.onSendMessage,
      this.controller});

  final VoidCallback onSelectGallary;
  final void Function(String? value) onSendMessage;
  final TextEditingController? controller;

  @override
  State<SendImageTextField> createState() => _SendImageTextFieldState();
}

class _SendImageTextFieldState extends State<SendImageTextField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    if (widget.controller == null) {
      _controller = TextEditingController();
    } else {
      _controller = widget.controller!;
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.8,
          child: TextField(
            controller: _controller,
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            maxLines: null,
            decoration: InputDecoration(
              hintText: 'Message',
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // camera icon button
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.camera_alt_rounded,
                      size: 27,
                      color: Colors.blueGrey.shade700,
                    ),
                  ),

                  // image selector icon button
                  IconButton(
                    onPressed: widget.onSelectGallary,
                    icon: Icon(
                      Icons.image_rounded,
                      size: 27,
                      color: Colors.blueGrey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // send button
        FloatingActionButton(
          onPressed: () {
            var message = _controller.text;
            setState(() {
              _controller.text = '';
            });
            widget.onSendMessage(message);
          },
          backgroundColor: Colors.lightBlueAccent.shade200,
          shape: const CircleBorder(),
          child: const Icon(Icons.send),
        )
      ],
    );
  }
}

class MessageChatBubble extends StatelessWidget {
  const MessageChatBubble(
      {super.key, required this.chatMessage, required this.userId});

  final GroupChatMessage chatMessage;
  final String? userId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MembersData>(
        future: chatMessage.senderInfo,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final chatMember = snapshot.data;
            bool sendByMe = chatMember?.id == userId;
            return Align(
              alignment:
                  (sendByMe) ? Alignment.centerRight : Alignment.centerLeft,
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        right: (sendByMe) ? 8.0 : 50.0,
                        left: (sendByMe) ? 50.0 : 8.0,
                        top: 6.0),
                    padding: const EdgeInsets.only(right: 4.0),
                    decoration: BoxDecoration(
                        color: (sendByMe)
                            ? Colors.lightBlueAccent
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.only(
                            topRight: (sendByMe)
                                ? Radius.zero
                                : const Radius.circular(12.0),
                            bottomLeft: const Radius.circular(12.0),
                            bottomRight: const Radius.circular(12.0))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              chatMember?.name ?? '',
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.transparent,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 27.0),
                            Text(
                              formateDate(chatMessage.date),
                              style: const TextStyle(
                                  fontSize: 10, color: Colors.transparent),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: RichText(
                            textAlign: TextAlign.justify,
                            text: TextSpan(
                              text: chatMessage.message,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5.0)
                      ],
                    ),
                  ),
                  Positioned(
                    top: 6,
                    right: (sendByMe) ? 12 : 58,
                    child: Text(
                      formateDate(chatMessage.date),
                      style:
                          const TextStyle(fontSize: 10, color: Colors.blueGrey),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: (sendByMe) ? 42.0 : 2.0),
                        child: InkWell(
                          onTap: () {},
                          child: CircleAvatar(
                            radius: 8,
                            foregroundImage: (chatMember?.imageURL == null)
                                ? null
                                : NetworkImage(chatMember!.imageURL!),
                            child: const Icon(Icons.person, size: 14),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6.0, left: 2.0),
                        child: Text(
                          chatMember?.name ?? '',
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        formateDate(chatMessage.date),
                        style: const TextStyle(
                            fontSize: 10, color: Colors.transparent),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return Container(
            height: 50,
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0), color: Colors.grey),
          );
        });
  }

  String formateDate(DateTime? dateTime) {
    if (dateTime == null) {
      return '';
    } else {
      return dateTime
          .toIso8601String()
          .splitMapJoin(
            'T',
            onMatch: (p0) => '\t\t',
          )
          .split(':')
          .sublist(0, 2)
          .join(':');
    }
  }
}
