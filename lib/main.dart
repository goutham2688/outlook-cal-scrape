import 'package:flutter/material.dart';
import 'cubit/cal_list_cubit.dart';
import 'repository/api_repository.dart';
import 'repository/local_repository.dart';
import 'repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Repository repo = Repository(
        localRepository: LocalRepository(), apiRepository: ApiRepository());
    return MaterialApp(
      title: 'Flutter Demo',
      home: BlocProvider(
        create: (context) => CalListCubit(repo),
        child: const MyHomePage(),
      ),
    );
  }
}
