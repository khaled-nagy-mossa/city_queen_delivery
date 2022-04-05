import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../common/conversation_cubit_imports.dart';

class ConversationCubit extends Cubit<ConversationStates>
    implements UsageCriteria {
  final Conversation conversation;
  final ChatUser user;
  List<QueryDocumentSnapshot> queries;

  ConversationCubit({@required this.conversation, @required this.user})
      : assert(conversation != null),
        assert(user != null),
        super(const InitialState());

  factory ConversationCubit.get(BuildContext context) {
    return BlocProvider.of<ConversationCubit>(context);
  }

  Future<bool> sendMessage(String value) async {
    assert(value != null || value.isNotEmpty);

    try {
      await Future<void>.delayed(Duration.zero);
      emit(const SendingMessageState());

      final result = await ChatService.sendMessage(
        user: user,
        roomData: conversation.roomData,
        msg: value,
      );

      if (result == null) {
        emit(MessageSentState(value: value));
        return true;
      } else {
        throw result.toString();
      }
    } catch (e) {
      emit(IneffectiveErrorState(error: e.toString()));
      return false;
    }
  }

  Future<void> fetchMore() async {
    try {
      if (state is FetchingMoreState) return;
      if (queries.length >= conversation.count) return;

      await Future<void>.delayed(Duration.zero);
      emit(const FetchingMoreState());

      final messages = await MessageRepo.getMoreMessages(
        roomData: conversation.roomData,
        lastDocumentSnapshot: queries.first,
        currentMsgLength: queries.length,
      );

      queries = [...messages.reversed, ...queries];

      emit(const FetchedMoreState());
    } catch (e) {
      emit(IneffectiveErrorState(error: "can't load more messages : $e"));
      return false;
    }
  }

  List<Message> get messages {
    final msgList = <Message>[];
    try {
      for (final q in queries) {
        final msg = Message.fromMap(q.data());
        if (msg.usable) msgList.add(msg);
      }
      return msgList;
    } catch (e) {
      log('Exception in ConversationCubit.messages : $e'.tr);
      return msgList;
    }
  }

  ///Call in stream builder to re initial list view
  void initialQuery(List<QueryDocumentSnapshot> q) {
    if (queries == null || queries.isEmpty) {
      queries = q;
    } else {
      ///cause this method called many times when user send message
      if (q?.last?.id != queries?.last?.id) queries?.add(q.last);
    }
  }

  int get messagesLength {
    return messages?.length ?? 0;
  }

  @override
  bool get unusable {
    try {
      return !usable;
    } catch (e) {
      log('Exception in ChatCubit.unUsable : $e'.tr);
      return true;
    }
  }

  @override
  bool get usable {
    try {
      return conversation != null && conversation.usable;
    } catch (e) {
      log('Exception in ChatCubit.unUsable : $e'.tr);
      return false;
    }
  }
}
