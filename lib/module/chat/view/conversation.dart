import '../../../widget/default_body.dart';
import '../common/conversation_view_imports.dart';

class ConversationView extends StatelessWidget {
  static const routeName = '/conversation_view';

  final Conversation conversation;

  ConversationView({@required this.conversation, Key key})
      : assert(conversation != null),
        super(key: key);

  ChatUser _user(BuildContext context) {
    final userData = AuthCubit?.get(context)?.user?.data;

    return ChatService.getAnotherUser(
      users: conversation?.users,
      user: ChatUser(
        id: userData?.id.toString(),
        name: userData?.name,
        avatar: API.imageUrl(userData.avatar),
      ),
    );
  }

  final _scrollController = ScrollController();

  void _setupScrollController(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        ConversationCubit.get(context).fetchMore();
      }
    });
  }

  final _msgP = const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ConversationCubit>(
      create: (context) => ConversationCubit(
        conversation: conversation,
        user: ChatCubit.get(context).chatUser,
      ),
      child: Builder(
        builder: (context) {
          _setupScrollController(context);

          final cubit = ConversationCubit.get(context);

          return BlocConsumer<ConversationCubit, ConversationStates>(
            listener: (context, state) {
              if (state is IneffectiveErrorState) {
                AppSnackBar.error(context, state.error);
              }
            },
            builder: (context, state) {
              return Scaffold(
                resizeToAvoidBottomInset: true,
                appBar: DefaultAppBar(title: Text(_user(context).name)),
                body: DefaultBody(
                  child: Column(
                    children: [
                      Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: MessageRepo.conversationMessages(
                            roomData: cubit.conversation.roomData,
                          ),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const LoadingWidget();
                            } else if (snapshot.hasError) {
                              return ExceptionWidget(
                                onRefresh: () async {},
                                exceptionMsg: snapshot.error.toString(),
                              );
                            } else {
                              cubit.initialQuery(snapshot?.data?.docs ?? []);

                              if (cubit.messagesLength == 0) {
                                return const EmptyConversationMessagesWidget();
                              }

                              return ListView.separated(
                                controller: _scrollController,
                                reverse: true,
                                itemCount: cubit.messagesLength,
                                padding: _msgP,
                                itemBuilder: (context, index) {
                                  index = (cubit.messagesLength - 1) - index;
                                  return MessageWidget(
                                    message: cubit.messages[index],
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(height: 10.0);
                                },
                              );
                            }
                          },
                        ),
                      ),
                      ConversationField(
                        loadingButton: state is SendingMessageState,
                        onSend: (value) async {
                          value = value.trim();
                          if (value != null && value.isNotEmpty) {
                            return cubit.sendMessage(value);
                          } else {
                            return false;
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
