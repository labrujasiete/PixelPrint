import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:print_pixel/custom_toolbar.dart';

class CmToPx extends StatefulWidget {
  const CmToPx({super.key});

  @override
  State<CmToPx> createState() => _CmToPxState();
}

class _CmToPxState extends State<CmToPx> {

  late MacosTabController macosTabController;
  final TextEditingController widthController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  double? widthResult;
  double? heightResult;

  bool showHeightCheckMark = false;
  bool showWidthCheckMark = false;

  @override
  void initState() {
    super.initState();
    macosTabController = MacosTabController(length: 2);
  }

  @override
  Widget build(BuildContext context) {

    final brightness = MacosTheme.of(context).brightness;
    Color themeColor = MacosThemeData.light().primaryColor;

    if (brightness == Brightness.dark) {
      themeColor = MacosThemeData.dark().primaryColor;
    } else {
      themeColor = MacosThemeData.light().primaryColor;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return MacosScaffold(
          toolBar: CustomToolBar.buildToolBar(context, 'cm to px'),
          children: [
        
            ContentArea(
              minWidth: constraints.maxWidth,
              builder:(context, scrollController) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 42, horizontal: 21),
                  child:  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                        
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                MacosSegmentedControl(
                                  tabs: const [
                                    MacosTab(label: '300 dpi', active: true),
                                    MacosTab(label: '72 dpi'),
                                  ], 
                                  controller: macosTabController
                                ),

                              ],
                            ),

                            const SizedBox(height: 21),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                const Text('Width'),

                                const SizedBox(width: 9),

                                SizedBox(
                                  width: 100,
                                  child: MacosTextField(
                                    controller: widthController,
                                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                                    ],
                                  )
                                ),

                                const SizedBox(width: 9),

                                const Text('cm'),
                              ],
                            ),

                            const SizedBox(height: 1),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                const Text('Height'),

                                const SizedBox(width: 9),

                                SizedBox(
                                  width: 100,
                                  child: MacosTextField(
                                    controller: heightController,
                                  )
                                ),

                                const SizedBox(width: 9),

                                const Text('cm'),
                              ],
                            ),

                            const SizedBox(height: 21),

                            PushButton(
                              controlSize: ControlSize.large,
                              child: const Text('Calculate'), 
                              onPressed: () {
                                setState(() {

                                  if (widthController.text.isEmpty || widthController.text == '.') {
                                    widthResult = null;
                                  }else{
                                    widthResult = cmToPixels(double.parse(widthController.text), macosTabController.index.toDouble());
                                  }

                                  if (heightController.text.isEmpty || heightController.text == '.') {
                                    heightResult = null;
                                  }else{
                                    heightResult = cmToPixels(double.parse(heightController.text), macosTabController.index.toDouble());
                                  }

                                });
                              },
                            ),

                            const SizedBox(height: 21),
                            
                            if(widthResult != null) Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Width in PX:', style: TextStyle(fontWeight: FontWeight.w600),),
                                const SizedBox(width: 9,),
                                Text(widthResult!.toStringAsFixed(4)),
                                const SizedBox(width: 9,),
                                PushButton(
                                  controlSize: ControlSize.regular,
                                  secondary: true,
                                  onPressed: () {
                                    Clipboard.setData(ClipboardData(text: widthResult.toString()));
                                    setState(() {
                                      showWidthCheckMark = true;
                                    });
                                  },
                                  child: const Text('Copy'), 
                                ),

                                const SizedBox(width: 9,),

                                SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: showWidthCheckMark ? const Icon(CupertinoIcons.checkmark_circle_fill).animate(onComplete: (controller) {
                                    setState(() {
                                      showWidthCheckMark = false;
                                    });
                                  },).fadeOut(
                                    curve: Curves.easeInQuint,
                                    duration: const Duration(milliseconds: 500)
                                  ) : const SizedBox.shrink()
                                )


                              ],
                            ),

                            const SizedBox(height: 7),

                            if(heightResult != null) Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Height in PX:', style: TextStyle(fontWeight: FontWeight.w600),),
                                const SizedBox(width: 9,),
                                Text(heightResult!.toStringAsFixed(4)),
                                const SizedBox(width: 9,),
                                PushButton(
                                  controlSize: ControlSize.regular,
                                  secondary: true,
                                  onPressed: () {
                                    Clipboard.setData(ClipboardData(text: heightResult.toString()));
                                    setState(() {
                                      showHeightCheckMark = true;
                                    });
                                  },
                                  child: const Text('Copy'), 
                                ),

                                const SizedBox(width: 9,),

                                SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: showHeightCheckMark ? const Icon(CupertinoIcons.checkmark_circle_fill).animate(onComplete: (controller) {
                                    setState(() {
                                      showHeightCheckMark = false;
                                    });
                                  },).fadeOut(
                                    curve: Curves.easeInQuint,
                                    duration: const Duration(milliseconds: 500)
                                  ) : const SizedBox.shrink()
                                )

                              ],
                            ),

                            const SizedBox(height: 21),

                            if(widthResult != null && heightResult != null) Container(
                              alignment: Alignment.center,
                              width: 200,
                              height: 200,
                              child: AspectRatio(
                                aspectRatio: widthResult! / heightResult!,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: themeColor.withOpacity(.1),
                                    borderRadius: BorderRadius.circular(7),
                                    border: Border.all(
                                      width: 2,
                                      color: themeColor
                                    )
                                                            
                                  ),
                                ).animate().fade(),
                              ),
                            )

                        
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }
            ),
        
          ],
        );
      }
    );
  }
}


double cmToPixels(double cm, double dpiVal) {
  
  double dpi = 300; // Printing resolution in dots per inch (dpi)
  if(dpiVal == 0){
    dpi = 300;
  }else if(dpiVal == 1){
    dpi = 72;
  }
  double cmPerInch = 2.54; // Centimeters per inch

  // Convert centimeters to pixels
  return (cm / cmPerInch) * dpi;
}







