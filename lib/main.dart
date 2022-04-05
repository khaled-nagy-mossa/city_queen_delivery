import 'package:delivery/common/firebase/fcm.dart';
import 'package:delivery/common/firebase/local_notification.dart';
import 'package:delivery/util/app_localization.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main_imports.dart';

String locale;

Future<void> main() async {
  AppService.turnOnEnhancedProtection(turnOn: false);

  Bloc.observer = AppBlocObserver();

  WidgetsFlutterBinding.ensureInitialized();

  await FirebaseCoreHelper.initial();

  await AppService.setupSystemChrome();

  FCM.setupBackgroundMessages();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  locale = sharedPreferences.getString("LANG") ?? 'en';

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp();
  @override
  _MyAppState createState() => _MyAppState();
}

GlobalKey<NavigatorState> _navigatorKey;

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _navigatorKey = GlobalKey<NavigatorState>();

    //use future and duration zero to use context --> don't use didChangeDependencies plz
    Future<void>.delayed(Duration.zero).then((value) {
      LocalNotificationService.initial(
          // _navigatorKey.currentState.overlay.context,
          );
      FCM.setupListener();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(
          create: (context) {
            final userData = AuthCubit.get(context)?.user?.data;
            return ChatCubit(
              chatUser: ChatUser(
                name: userData?.name,
                id: userData?.id?.toString(),
                avatar: API.imageUrl(userData?.avatar),
              ),
            );
          },
        ),
        BlocProvider<AccountCubit>(
          create: (context) => AccountCubit(authCubit: AuthCubit.get(context)),
        ),
      ],
      child: GetMaterialApp(
        navigatorKey: _navigatorKey,
        title: AppData.appName,
        translations: Messages(),
        locale: Locale(locale),
        debugShowCheckedModeBanner: false,
        home: const StartApplicationView(),
        builder: (context, widget) {
          return Builder(builder: (context) {
            if (Platform.isAndroid || Platform.isIOS) {
              return InternetConnectionListener(widget: widget);
            } else {
              return widget;
            }
          });
        },
        theme: AppTheme.light(),
      ),
    );
  }
}

class StartApplicationView extends StatelessWidget {
  const StartApplicationView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckInternetScreen(
      child: AccountBlocConsumer(
        child: AuthBlocConsumer(
          navigatorKey: _navigatorKey,
          child: const HomeView(),
        ),
      ),
    );
  }
}
