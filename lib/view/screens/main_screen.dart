import 'package:blox/data/domain/datasource/user_data_source.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: UserBlox(
            builder: (context, data) {
              return SizedBox(
                width: 300,
                height: 600,
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(data[index].name),
                      subtitle: Text(data[index].username),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
