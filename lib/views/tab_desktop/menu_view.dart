import 'package:flutter/material.dart';
import 'package:menu_ui/models/tab_desktop/menu.dart';
import 'package:menu_ui/utils/app_colors.dart';
import 'package:menu_ui/utils/ui_helper.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key, this.expandFlex = 2, this.isTab = false});

  final int expandFlex;
  final bool isTab;

  @override
  Widget build(BuildContext context) {
    final menus = Menu.getMenus();

    return Expanded(
      flex: expandFlex,
      child: Container(
        color: Colors.white,
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: isTab ? 20.0 : 40.0, top: 40.0, right: isTab ? 20.0 : 40.0, bottom: 20.0),
        child: Column(
          children: [
            ListView(
              shrinkWrap: true,
              children: List.generate(
                menus.length,
                (index) => _MenuItem(
                  menu: menus[index],
                  isTab: isTab,
                ),
              ),
            ),
            const Spacer(),
            isTab
                ? IconButton(
                    icon: const Icon(Icons.exit_to_app),
                    iconSize: 30.0,
                    onPressed: () {},
                  )
                : FractionallySizedBox(
                    widthFactor: 0.5,
                    child: SizedBox(
                      height: 52.0,
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.exit_to_app),
                        label: const Text('Logout'),
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          foregroundColor: menuOrange,
                          side: const BorderSide(width: 2.0, color: menuOrange),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}

class _MenuItem extends StatefulWidget {
  const _MenuItem({required this.menu, this.isTab = false});

  final Menu menu;
  final bool isTab;

  @override
  __MenuItemState createState() => __MenuItemState();
}

class __MenuItemState extends State<_MenuItem> {
  bool isHovered = false;

  bool get isTab => widget.isTab;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: isTab ? EdgeInsets.zero : const EdgeInsets.symmetric(vertical: 5.0),
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: isTab ? 0.0 : 10.0),
      child: InkWell(
        onTap: () {},
        onHover: (value) {
          if (!isTab) {
            setState(() {
              isHovered = value;
            });
          }
        },
        child: Container(
          decoration: isHovered
              ? BoxDecoration(
                  color: Colors.deepOrange[100],
                  borderRadius: BorderRadius.circular(30.0),
                )
              : null,
          padding: isTab ? const EdgeInsets.symmetric(vertical: 10.0) : const EdgeInsets.only(left: 15.0, top: 10.0, right: 25.0, bottom: 10.0),
          child: isTab
              ? IconButton(
                  icon: Icon(widget.menu.icon, color: isHovered ? menuOrange : Colors.black),
                  iconSize: 30.0,
                  onPressed: () {},
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(widget.menu.icon, color: isHovered ? menuOrange : Colors.black, size: 30.0),
                    UIHelper.horizontalSpaceMedium(),
                    Text(
                      widget.menu.title,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: isHovered ? menuOrange : Colors.black,
                          ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
