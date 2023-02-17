import 'dart:io';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/notes_cubit.dart';
import 'pages/notes_page.dart';
import '../screens/signIn_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await DesktopWindow.setMaxWindowSize(const Size(400, 450));
    await DesktopWindow.setMaxWindowSize(const Size(400, 450));
    await DesktopWindow.setWindowSize(const Size(400, 450));
  }
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => NotesCubit(), child: const HistoryPage())],
      child: const MaterialApp(home: SignInScreen(), debugShowCheckedModeBanner: false),
    );
  }
}
