// ignore_for_file: unnecessary_null_comparison, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton(
      {Key? key,
      //required demek bu objeyi çağırdığınız yerlerde bu değişkene bir değer atamanız gerekmekte old. söyler.
      required this.buttonText,
      this.buttonColor = Colors.black, //default değerler atadık
      this.textColor= Colors.white,
      this.radius= 16,
      this.height= 50,
      this.buttonIcon,
      required this.onPressed})
      // ignore: unnecessary_null_comparison
      : assert(buttonText !=null), //assertlerin amacı debug modda hata vermesini sağlamak
        assert(onPressed != null),
      
        super(key: key);

  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final double radius;
  final double height;
  final Widget? buttonIcon; //!bu butonu çağırdığımız yerde bu değeri vermek zorunda olmamamk için ? koyduk. ve Spreads , collection-if collection-for yapıları ile null gelme ihtimalini kontrol ettik
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      child: SizedBox(
        height: height,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            // minimumSize: Size(30, height),
            foregroundColor: Colors.black,
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              //Spreads , collection-if collection-for bu özelliklerle kodlarımızı daha kısa yazabiliriz.
              //Spreads kullandık dedikki yukatda children listesi var buttonIcon eğer null değilse bu listeye ekle(...[ )
              if (buttonIcon != null) ...[
                buttonIcon!,
                Text(
                  buttonText,
                  style: GoogleFonts.poppins(
                      color: textColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
                Opacity(
                  opacity: 0,
                  child: buttonIcon,
                ),
              ],
              if (buttonIcon == null) ...[
                Container(),
                Text(
                  buttonText,
                  style: GoogleFonts.poppins(
                      color: textColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
                Container(),
              ]
            ],
          ),
        ),
      ),
    );
  }
}


//ESKİ YÖNTEM

/*  buttonIcon != null ? buttonIcon : Container() ,
              Text(
                buttonText,
                style: GoogleFonts.poppins(
                    color: textColor, fontSize: 15, fontWeight: FontWeight.w500),
              ),
              buttonIcon != null ? Opacity(
                opacity: 0,
                child: buttonIcon,
              ) : Container(), */

              
