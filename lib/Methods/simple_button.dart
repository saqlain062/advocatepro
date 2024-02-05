
import 'package:flutter/material.dart';

class SimpleButton extends StatelessWidget {
  final String title;
  final VoidCallback onTop ;
  final IconData icon;
  const SimpleButton({super.key,
  required this.title,
  required this.onTop,
  required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTop,
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 10,),
          Text(title, style:const TextStyle(color: Colors.black,fontSize: 20),),
        ],
      ),
    );
  }
}