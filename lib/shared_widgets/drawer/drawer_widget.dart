import 'package:app_routes/app_routes.dart';
import 'package:delivery/common/config/api.dart';
import 'package:delivery/common/const/app_data.dart';
import 'package:delivery/module/auth/cubit/auth/cubit.dart';
import 'package:delivery/module/auth/view/registration.dart';
import 'package:delivery/module/branch/view/branches_view.dart';
import 'package:delivery/module/category/view/categories_view.dart';
import 'package:delivery/module/chat/view/chat.dart';
import 'package:delivery/module/document/view/contact_us.dart';
import 'package:delivery/module/document/view/document_view.dart';
import 'package:delivery/module/faq/view/faq_view.dart';
import 'package:delivery/module/notification/view/notifications.dart';
import 'package:delivery/module/order/view/my_orders_view.dart';
import 'package:delivery/module/product/view/products.dart';
import 'package:delivery/module/profile/cubit/account/cubit.dart';
import 'package:delivery/module/profile/cubit/account/cubit_extension.dart';
import 'package:delivery/module/profile/cubit/account/states.dart';
import 'package:delivery/module/profile/view/profile_view.dart';
import 'package:delivery/module/statistics/view/driver_statistics.dart';
import 'package:delivery/shared_widgets/drawer/drawer_item_widget.dart';
import 'package:delivery/shared_widgets/language/languages_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget();

  static const _divider = Divider(color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountCubit, AccountStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = AccountCubit?.get(context);
        final userData = cubit?.user?.data;
        final isSigned = cubit.signed;

        return Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Theme.of(context).primaryColor.withOpacity(0.9),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            child: Drawer(
              child: Container(
                constraints: const BoxConstraints.expand(),
                decoration: BoxDecoration(gradient: AppData.customGradient),
                child: Column(
                  children: [
                    // ECommerceBanner(),
                    const SizedBox(height: 80.0),
                    if (isSigned) ...[
                      ListTile(
                        onTap: () {
                          AppRoutes?.push(context, const ProfileView());
                        },
                        leading: Container(
                          height: 55.0,
                          width: 55.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                API.imageUrl(userData?.avatar),
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          userData?.name ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18.0),
                        ),
                        subtitle: Text(
                          userData?.email ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.8)),
                        ),
                      ),
                      _divider,
                    ],

                    //drawer items
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          DrawerItemWidget('HOME'.tr, 'assets/images/home.png',
                              () {
                            Get.back();
                          }),
                          DrawerItemWidget(
                              'STATISTICS'.tr, 'assets/images/order.png', () {
                            Get.to(() => const StatisticsView());
                          }),
                          DrawerItemWidget(
                              'MY ORDERS'.tr, 'assets/images/order.png', () {
                            Get.to(() => const MyOrdersView());
                          }),
                          _divider,
                          DrawerItemWidget(
                              'PROFILE'.tr, 'assets/images/profile.png', () {
                            Get.to(() => const ProfileView());
                          }),
                          DrawerItemWidget('NOTIFICATIONS'.tr,
                              'assets/images/notification.png', () {
                            Get.to(() => const NotificationsView());
                          }),
                          DrawerItemWidget('CHAT'.tr, 'assets/images/chat.png',
                              () {
                            Get.to(() => const ChatView());
                          }),
                          DrawerItemWidget(
                              'LANGUAGES'.tr, 'assets/images/language.png', () {
                            Get.to(() => const LanguageWidget());
                          }),
                          _divider,
                          DrawerItemWidget(
                              'HELP & SUPPORT'.tr, 'assets/images/help.png',
                              () {
                            Get.to(() => const FaqView());
                          }),
                          DrawerItemWidget(
                              'CONTACT US'.tr, 'assets/images/contact.png', () {
                            Get.to(() => ContactUsView());
                          }),
                          DrawerItemWidget(
                              'ABOUT US'.tr, 'assets/images/about.png', () {
                            Get.to(() => const DocumentView(
                                  title: 'About Us',
                                  endPoint: 'about_us',
                                ));
                          }),
                          DrawerItemWidget(
                              'DELIVERY INFO'.tr, 'assets/images/delivery.png',
                              () {
                            Get.to(() => const DocumentView(
                                  title: 'Delivery Info',
                                  endPoint: 'delivery_info',
                                ));
                          }),
                          DrawerItemWidget(
                              'PRIVACY POLICY'.tr, 'assets/images/policy.png',
                              () {
                            Get.to(() => const DocumentView(
                                  title: 'Privacy Policy',
                                  endPoint: 'privacy_policy',
                                ));
                          }),
                          DrawerItemWidget('TERMS AND CONDITION'.tr,
                              'assets/images/terms.png', () {
                            Get.to(() => const DocumentView(
                                  title: 'Terms And Conditions',
                                  endPoint: 'terms_conditions',
                                ));
                          }),
                          DrawerItemWidget(
                              'REFUND POLICY'.tr, 'assets/images/refund.png',
                              () {
                            Get.to(() => const DocumentView(
                                  title: 'Refund Policy',
                                  endPoint: ' refund_policy',
                                ));
                          }),
                          _divider,
                          if (cubit.signed)
                            DrawerItemWidget(
                                'Sign Out'.tr, 'assets/images/logout.png',
                                () async {
                              await AuthCubit.get(context)?.signOut();
                              Get.back();
                            })
                          else
                            DrawerItemWidget(
                                'Login'.tr, 'assets/images/login.png',
                                () async {
                              AppRoutes.push(
                                context,
                                const RegistrationView(),
                              );
                            })
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
