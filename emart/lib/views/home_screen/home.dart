import 'package:emart/consts/consts.dart';
import 'package:emart/views/home_screen/cart_screen.dart';
import 'package:get/get.dart';
import 'package:emart/controllers/home_controller.dart';

import '../profile/profile_screen.dart';
import 'home_screen.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //init home controler
    var controller = Get.put(HomeController());
    var navbarItem = [
      BottomNavigationBarItem(
          icon: Image.asset(icHome, width: 26), label: home),
      BottomNavigationBarItem(
          icon: Image.asset(icProfile, width: 26), label: account),
    ];
    var navBody = [
      const HomeScreen(),
      const ProfileScreen(),
    ];
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const CartScreen());
        },
        child: const Icon(Icons.shopping_bag),
      ),
      body: Column(
        children: [
          Obx(() => Expanded(
                child: navBody.elementAt(controller.currentNavIndex.value),
              )),
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentNavIndex.value,
          selectedItemColor: Colors.black,
          selectedLabelStyle: const TextStyle(fontFamily: semibold),
          type: BottomNavigationBarType.fixed,
          backgroundColor: whiteColor,
          items: navbarItem,
          onTap: (value) {
            controller.currentNavIndex.value = value;
          },
        ),
      ),
    );
  }
}
