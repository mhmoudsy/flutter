import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fproject/layout/shop_app/cubit/cubit.dart';
import 'package:fproject/layout/shop_app/cubit/states.dart';
import 'package:fproject/modules/shop_app/favorites/favorites_screen.dart';
import 'package:fproject/modules/shop_app/search/search_screen.dart';
import 'package:fproject/modules/shop_app/settings/settings_screen.dart';
import 'package:fproject/shared/components/components.dart';
import 'package:fproject/shared/components/constants.dart';

class ShopLayout extends StatelessWidget {
  ShopLayout({Key? key}) : super(key: key);
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: cubit.userData != null,
          builder: (context) => Scaffold(
            key: scaffoldKey,
            drawer: Drawer(
              child: Column(
                children: [
                  DrawerHeader(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 35.0,
                          child: Image(
                            image: NetworkImage(cubit.userData!.data!.image!),
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              cubit.userData!.data!.name!,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                            Text(
                              cubit.userData!.data!.email!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Expanded(
                          child: IconButton(
                            onPressed: () {
                              print(cubit.userData!.data!.name);
                            },
                            icon: Icon(Icons.edit),
                          ),
                        ),
                        SizedBox(width: 15.0,)
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text('Settings'),
                    horizontalTitleGap: 0,
                    onTap: () {
                      navigateTo(context, SettingsScreen());
                      scaffoldKey.currentState!.closeDrawer();
                    },
                    leading: Icon(Icons.settings),
                  ),
                  ListTile(
                    title: Text('Favorites'),
                    horizontalTitleGap: 0,
                    onTap: () {
                      navigateTo(context, FavoritesScreen());
                      scaffoldKey.currentState!.closeDrawer();
                    },
                    leading: Icon(Icons.favorite),
                  ),
                  Spacer(),
                  ListTile(
                    title: Text('Logout'),
                    horizontalTitleGap: 0,
                    onTap: () {
                      signOut(context);
                    },
                    leading: Icon(Icons.logout),
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              title: Text('Salla'),
              actions: [
                IconButton(
                    onPressed: () {
                      navigateTo(context, SearchScreen());
                    },
                    icon: Icon(
                      Icons.search,
                    )),
              ],
            ),
            body: cubit.shopScreens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.apps),
                  label: 'Categories',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favorites',
                ),
                // BottomNavigationBarItem(
                //   icon: Icon(Icons.settings),
                //   label: 'Settings',
                // ),
              ],
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNavBar(index);
              },
            ),
          ),
          fallback: (context) =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
        );
      },
    );
  }
}
