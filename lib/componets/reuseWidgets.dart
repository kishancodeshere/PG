import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pg/Screens/SignUpScreen.dart';


SizedBox reuseOutlinedButton({required String text,required BuildContext context,
required String path,required double height})
{
  return SizedBox(
    height:height,
    child: OutlinedButton(onPressed: () {
      if(text == "Sign Up as a Owner") {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>SignUpScreen(role: "Owner")));
      } else if(text == "  Sign Up as a User  ") {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>SignUpScreen(role: "User")));
      }
      else{
        Navigator.pushNamed(context, path);
      }

    }, style: ElevatedButton.styleFrom(

      backgroundColor: Color(0xff0A1045),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),),
    ), child:
    Text(text,
      style: TextStyle(
          color: Color(0xffe5e6e4), fontSize: 17, fontWeight: FontWeight.w500),
    ),

    ),
  );
}

AlertDialog reuseAlertDialog({required BuildContext context,required String message})
{
  return AlertDialog(
      title: const Text('Message'),
      content:  Text(message,style:TextStyle(color:Colors.red),),
      actions: [
        TextButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: Text("ok"))
      ]
  );
}

Padding  resueTextField({required String text,required IconData icon,
  required bool isPasswordType,required TextEditingController controller,required double size})
{
  return  Padding(
    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
    child: SizedBox(
      width:size,
      child: TextField(
        obscureText: isPasswordType,
        controller: controller,
       decoration: InputDecoration(
         prefixIcon: Icon(icon,color:Colors.black54),
         labelText: text,
         fillColor: Colors.white,
       ),
      )
    ),
  );
}
Padding  resueLoginTextField({required String text,required bool readonly,required IconData icon,required bool isPasswordType,required TextEditingController controller,required double size})
{
  return  Padding(
    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
    child: SizedBox(
        width:size,
        
        child: TextField(
          readOnly: readonly,
          obscureText: isPasswordType,
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: Icon(icon,color:Colors.black54,size: 30),
            labelText: text,
            labelStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 20),
            fillColor: Colors.white,
          ),
        )
    ),
  );
}
TextButton link({required BuildContext context,required String path,required text})
{
  return TextButton(
      onPressed: (){
        Navigator.pushReplacementNamed(context,path);
      },child: Text(text,
    style: TextStyle(fontSize: 16,color: Color(0xff0A1045),decoration: TextDecoration.underline),)
  );
}
Row reuseImage()
{
  return Row(
    children: [
      Image.asset('Images/icon1.png',height:150 , width:200 ,),
    ],
  );
}
Container reuseFacilitiesContainer ({required String hintText,required TextEditingController textarea})
{
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.all(12),
    child: Column(
      children: [
        TextField(

          controller: textarea,
          keyboardType: TextInputType.multiline,
          maxLines: 4,
          decoration: InputDecoration(
            hintText:hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            // focusedBorder: OutlineInputBorder(
            //   borderSide: BorderSide(width: 1),
            ),
          ),
      ],
    ),
  );
}

Text reuseAboutText({required String text})
{
  return Text(
    text,style: GoogleFonts.montserrat(fontWeight: FontWeight.w600,fontSize: 25,color: Color(0xff0A1045))
  );
}

Card reuseAboutCard({required IconData icon,required String text})
{
  return Card(
    margin: EdgeInsets.symmetric(vertical: 7,horizontal: 20),
    child: ListTile(
      leading: Icon(
        icon,
        color: Color(0xff0A1045),
      ),
      title: Text(
        text,
        style: GoogleFonts.montserrat(fontWeight: FontWeight.w600,fontSize: 20,color: Color(0xff0A1045))
      ),
    ),
  );
}



