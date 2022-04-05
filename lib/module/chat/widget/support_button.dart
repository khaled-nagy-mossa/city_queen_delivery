import 'package:app_routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../common/config/api.dart';
import '../cubit/chat/cubit.dart';
import '../model/chat_user.dart';
import '../view/conversation.dart';

class SupportButton extends StatelessWidget {
  const SupportButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = ChatCubit.get(context);
    return FloatingActionButton.extended(
      label: Text('SUPPORT'.tr, style: const TextStyle(color: Colors.white)),
      icon: const Icon(Icons.support_agent_sharp, color: Colors.white),
      onPressed: () async {
        final conversation = await cubit.startChatWith(
          ChatUser(id: '1', name: 'Support', avatar: API.imageUrl(null)),
        );
        if (conversation != null && conversation.usable) {
          await AppRoutes.push(
            context,
            ConversationView(conversation: conversation),
          );
        }
      },
    );
  }
}
