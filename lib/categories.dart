import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select your desired categories'),
      ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        children: [
          Text(
            '2',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          Text(
            '1',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          Text(
            '3',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          Text(
            '4',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          Text(
            '5',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          Text(
            '6',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          Text(
            '7',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
