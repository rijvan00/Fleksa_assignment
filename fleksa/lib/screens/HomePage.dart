import 'package:fleksa/widget/Banner.dart';
import 'package:fleksa/widget/Item.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool button1Active = true;
  bool button2Active = false;
  bool button3Active = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FLEKSA'),
      ),
      endDrawer: const Drawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        button1Active ? Colors.amber : Colors.grey,
                      ),
                    ),
                    onPressed: () {
                      // Toggle the active state of button 1
                      setState(() {
                        button1Active = true;
                        button2Active = false;
                        button3Active = false;
                      });
                    },
                    child: Text('Delivery'),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        button2Active ? Colors.amber : Colors.grey,
                      ),
                    ),
                    onPressed: () {
                      // Toggle the active state of button 2
                      setState(() {
                        button1Active = false;
                        button2Active = true;
                        button3Active = false;
                      });
                    },
                    child: Text('Pickup'),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        button3Active ? Colors.amber : Colors.grey,
                      ),
                    ),
                    onPressed: () {
                      // Toggle the active state of button 3
                      setState(() {
                        button1Active = false;
                        button2Active = false;
                        button3Active = true;
                      });
                    },
                    child: const Text('Dine In'),
                  ),
                ],
              ),
            ),
            button1Active
                ? Column(
                    children: const [
                      BannerWidget(),
                      SizedBox(
                        height: 15,
                      ),
                      Items(),
                    ],
                  )
                : button2Active
                    ? const Items()
                    : Column(
                        children: const [
                          Text(
                            "Order Something to Dine In",
                            style: TextStyle(color: Colors.amber, fontSize: 24),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Items(),
                        ],
                      ),
          ],
        ),
      ),
    );
  }
}
