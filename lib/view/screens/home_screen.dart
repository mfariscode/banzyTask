import 'package:benzy_task/view/screens/food_report_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FoodReport()),
              );
            },
            child: Container(
              height: 80.0,
              decoration: BoxDecoration(
                color: const Color(0xff3D155F),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      width: 48.0,
                      height: 48.0,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2), // border color
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.fastfood, color: Colors.white70, size: 30,),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    const Text('FOOD ORDER DETAILS', style: TextStyle(fontSize: 18.0, color: Color(0xffe5e5e5), fontWeight: FontWeight.w500),),
                    const Spacer(),
                    Container(
                      width: 34.0,
                      height: 48.0,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: const SizedBox(
                          height: 16.0,
                          width: 16.0,
                          child: Icon(Icons.arrow_circle_right_outlined, color: Colors.white70,)),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
