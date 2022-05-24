import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class avatarBottom extends StatelessWidget {
  const avatarBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imgDefault =
        'https://nofiredrills.com/wp-content/uploads/2016/10/myavatar.png';
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          decoration: (BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Colors.black45,
                  offset: Offset(0, 20),
                )
              ])),
          child: ClipOval(
            child: Image.network(
              imgDefault,
              width: 120,
              height: 120,
            ),
          ),
        ),
        Positioned(
          bottom: 5,
          right: 2,
          child: CupertinoButton(
              padding: EdgeInsets.zero,
              borderRadius: BorderRadius.circular(30),
              child: Container(
                child: Icon(Icons.add, color: Colors.white),
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  color: Colors.pinkAccent,
                  shape: BoxShape.circle,
                ),
              ),
              onPressed: () {}),
        ),
      ],
    );
  }
}
