
import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';

class CustomToolBar {
  static ToolBar buildToolBar(BuildContext context, String title) {
    return ToolBar(
      title: Text(title),
      titleWidth: 150.0,
      leading: MacosTooltip(
        message: 'Toggle Sidebar',
        useMousePosition: false,
        child: MacosIconButton(
          icon: MacosIcon(
            CupertinoIcons.sidebar_left,
            color: MacosTheme.brightnessOf(context).resolve(
              const Color.fromRGBO(0, 0, 0, 0.5),
              const Color.fromRGBO(255, 255, 255, 0.5),
            ),
            size: 20.0,
          ),
          boxConstraints: const BoxConstraints(
            minHeight: 20,
            minWidth: 20,
            maxWidth: 48,
            maxHeight: 38,
          ),
          onPressed: () => MacosWindowScope.of(context).toggleSidebar(),
        ),
      ),
    );
  }
}
