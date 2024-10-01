import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:print_pixel/custom_toolbar.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {

    final brightness = MacosTheme.of(context).brightness;
    Color textColor = const Color.fromARGB(255, 0, 0, 0);

    if (brightness == Brightness.dark) {
      textColor = const Color.fromARGB(255, 255, 255, 255);
    } else {
      textColor = const Color.fromARGB(255, 0, 0, 0);
    }


    return LayoutBuilder(
      builder: (context, constraints) {
        return MacosScaffold(
          toolBar: CustomToolBar.buildToolBar(context, 'About PixelPrint'),
          children: [
        
            ContentArea(
              minWidth: constraints.maxWidth,
              builder:(context, scrollController) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 42, horizontal: 21),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                          
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(color: textColor),
                            children: const <TextSpan>[

                              TextSpan(
                                text: 'PixelPrint',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              TextSpan(
                                text: ' is a simple and precise tool designed for designers, developers, and print professionals to convert physical dimensions, such as centimeters, into pixels for digital design and print preparation. Whether you’re working on web layouts, mobile interfaces, or preparing high-resolution designs for print, PixelConvert ensures your dimensions are accurate and ready to scale. With a user-friendly interface, you can quickly input measurements and get pixel-perfect conversions based on industry-standard DPI settings, helping you create and print with confidence and precision.',
                              ),

               
                            ],
                          ),
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


//** PixelConvert is a simple and precise tool designed for designers, developers, and print professionals to convert physical dimensions, such as centimeters, into pixels for digital design and print preparation. Whether you’re working on web layouts, mobile interfaces, or preparing high-resolution designs for print, PixelConvert ensures your dimensions are accurate and ready to scale. With a user-friendly interface, you can quickly input measurements and get pixel-perfect conversions based on industry-standard DPI settings, helping you create and print with confidence and precision.
