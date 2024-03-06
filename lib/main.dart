import 'package:connectivity_bloc/core/service/cat_service.dart';
import 'package:connectivity_bloc/src/cubit/fetch_cats_cubit.dart';
import 'package:connectivity_bloc/src/view/cat_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  const service = CatApiService();

  runApp(
    BlocProvider(
      create: (context) => FetchCatsCubit(service),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CatApp(),
    );
  }
}
