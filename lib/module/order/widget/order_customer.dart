import 'package:app_launcher/app_launcher.dart';
import 'package:app_routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../common/assets/assets.dart';
import '../../../common/config/api.dart';
import '../../../common/const/app_data.dart';
import '../../../model/order/order_customer.dart';
import '../../../widget/custom_shadow.dart';
import '../../chat/cubit/chat/cubit.dart';
import '../../chat/model/chat_user.dart';
import '../../chat/view/conversation.dart';

class OrderCustomerListTile extends StatelessWidget {
  final OrderCustomer customer;
  final bool showContactData;

  const OrderCustomerListTile(
      {@required this.customer, this.showContactData = false, Key key})
      : assert(customer != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomShadow(
      child: Card(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ListTile(
          leading: Container(
            constraints: const BoxConstraints(maxHeight: 55.0, maxWidth: 55.0),
            decoration: BoxDecoration(
              gradient: AppData.customGradient,
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(API.imageUrl(customer.image)),
              ),
            ),
          ),
          title: Text(
            customer.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(customer.email),
          trailing: IntrinsicHeight(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _contactItem(
                  onTap: () {
                    AppLauncher.launchToPhone(customer?.phone ?? '');
                  },
                  svgPath: Assets.images.telephone,
                ),
                _contactItem(
                  onTap: () async {
                    final cubit = ChatCubit.get(context);
                    final conversation = await cubit.startChatWith(
                      ChatUser(
                        id: customer.id.toString(),
                        name: customer.name,
                        avatar: API.imageUrl(customer.image),
                      ),
                    );
                    if (conversation != null && conversation.usable) {
                      await Get.to(
                          () => ConversationView(conversation: conversation));
                    }
                  },
                  svgPath: Assets.images.chat,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _contactItem({
    @required VoidCallback onTap,
    @required String svgPath,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        height: 35.0,
        width: 35.0,
        decoration: BoxDecoration(
          gradient: AppData.customGradient,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: SvgPicture.asset(svgPath, color: Colors.white, width: 22.0),
      ),
    );
  }
}
