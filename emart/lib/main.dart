import 'package:emart/consts/consts.dart';
import 'package:emart/views/splash_screen/splash_screen.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //we are using getx so we have to change  this material app into get material app
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo ',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
        iconTheme: const IconThemeData(
          color: darkFontGrey,
        ),
        fontFamily: regular,
      ),
      home: const SplashScreen(),
    );
  }
}
