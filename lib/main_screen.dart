import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:print_pixel/about.dart';
import 'package:print_pixel/cmtopx.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int currentIndex = 0; 
  final List<Widget> pages = [
    const CmToPx(),
    const About()
  ];

  @override
  Widget build(BuildContext context) {
    return MacosWindow(
      sidebar: Sidebar(
        top: const Text('PixelPrint', style: TextStyle(fontWeight: FontWeight.w600)),
        bottom: Tooltip(
          message: 'Tap to copy',
          child: GestureDetector(
            onTap: () => Clipboard.setData(const ClipboardData(text: 'labrujasiete@gmail.com')),
            child: const Row(
              children: [
                Icon(CupertinoIcons.mail),
                SizedBox(width: 9),
                Text('labrujasiete@gmail.com')
              ],
            ),
          ),
        ),
        builder: (context, scrollController) {
          return SidebarItems(
            scrollController: scrollController,
            itemSize: SidebarItemSize.large,
            currentIndex: currentIndex, 
            onChanged: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            items: const <SidebarItem>[
    
              SidebarItem(
                leading: MacosIcon(CupertinoIcons.divide_circle),
                label: Text('cm to px')
              ),
    
              SidebarItem(
                leading: MacosIcon(CupertinoIcons.question_circle),
                label: Text('About')
              ),
    
            ], 
          );
        }, 
        minWidth: 250,
        // startWidth: 200,
        // maxWidth: 350
      ), 
      child: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
    );
  }
}