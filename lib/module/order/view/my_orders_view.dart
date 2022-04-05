import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../widget/app_bar/default_app_bar.dart';
import '../../../widget/default_body.dart';
import '../../auth/auth_observer/auth_builder.dart';

import '../controller/const.dart';
import '../cubit/type_of_order_screen_cubit/cubit.dart';
import '../model/orders_param.dart';
import '../widget/orders_view_tabs.dart';
import 'type_of_orders_view.dart';

class MyOrdersView extends StatefulWidget {
  static const routeName = '/my_orders_view';

  const MyOrdersView();

  @override
  _MyOrdersViewState createState() => _MyOrdersViewState();
}

class _MyOrdersViewState extends State<MyOrdersView>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: orderTypeTabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return AuthListener(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: DefaultAppBar(title: Text('Orders'.tr)),
        body: DefaultBody(
          child: Column(
            children: [
              const SizedBox(height: 10.0),
              OrdersViewTabs(
                selectedModel: orderTypeTabs[_tabController.index],
                onSelectTab: (model, index) {
                  setState(() => _tabController.index = index);
                },
              ),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: orderTypeTabs.map((e) {
                    return BlocProvider<TypeOfOrdersViewCubit>(
                      create: (context) {
                        return TypeOfOrdersViewCubit(OrdersListParam(
                          orderTypeParameter: e.orderTypeParameter,
                        ));
                      },
                      child: TypeOfOrdersScreen(orderTypeTab: e),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
