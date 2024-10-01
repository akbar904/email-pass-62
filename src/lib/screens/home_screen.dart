
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.flutter_cubit_app/widgets/logout_button.dart';
import 'package:com.example.flutter_cubit_app/cubits/home_cubit.dart';
import 'package:com.example.flutter_cubit_app/cubits/home_state.dart';

class HomeScreen extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return BlocProvider(
			create: (context) => HomeCubit(),
			child: Scaffold(
				appBar: AppBar(
					title: Text('Home Screen'),
				),
				body: Center(
					child: LogoutButton(),
				),
			),
		);
	}
}
