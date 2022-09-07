import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String theError;
  const ErrorScreen({required this.theError, super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      body: Center(
          child: Text(theError, style: Theme.of(context).textTheme.bodyText1)));
}
