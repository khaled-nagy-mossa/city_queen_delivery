import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../widget/default_body.dart';
import '../common/chat_view_imports.dart';

class ChatView extends StatelessWidget {
  static const routeName = '/chat_view';

  const ChatView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: DefaultAppBar(title: Text('CHAT'.tr)),
          body: DefaultBody(
            child: Stack(
              children: [
                _body(context),
                if (state is LoadingState) const LoadingWidget(),
              ],
            ),
          ),
          floatingActionButton: const SupportButton(),
        );
      },
    );
  }

  Widget _body(BuildContext context) {
    final cubit = ChatCubit.get(context);
    if (cubit.unusable) {
      return Center(child: Text('NO_USERS_FOUND'.tr));
    }
    return StreamBuilder<QuerySnapshot>(
      stream: ChatRepo.conversationsOfUser(uid: cubit.chatUser.id),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const LoadingWidget();
        } else if (snapshot.hasError) {
          return ExceptionWidget(
            onRefresh: () async {},
            exceptionMsg: snapshot.error.toString(),
          );
        } else {
          final length = snapshot?.data?.docs?.length ?? 0;

          if (length == 0) return const EmptyConversationsWidget();

          return ListView.separated(
            itemCount: length,
            itemBuilder: (context, index) {
              final conversation = Conversation.fromMap(
                snapshot?.data?.docs[index]?.data(),
              );
              if (conversation == null || conversation.unusable) {
                return const SizedBox();
              }

              return ConversationListTile(
                onTap: () {
                  AppRoutes.push(
                    context,
                    ConversationView(conversation: conversation),
                  );
                },
                conversation: conversation,
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
          );
        }
      },
    );
  }
}
