import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reconnect/widgets/Google.dart';
import 'pages/Login.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Reconnect',
            theme: ThemeData(
                backgroundColor: const Color.fromARGB(255, 43, 165, 139)),
            home: AnimatedSplashScreen(
              //takes the 1st screen to be displayed, adding splash here
              backgroundColor: const Color.fromARGB(255, 2, 2, 2),
              splash: Center(
                child: Container(
                  child: const Image(
                    image: AssetImage('assets/Reconnect.jpg'),
                  ),
                ),
              ),
              splashTransition: SplashTransition.scaleTransition,

              nextScreen: LoginScreens(),
            )),
      );
}


// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   Future<FirebaseApp> _initializeFirebase() async {
//     FirebaseApp firebaseApp = await Firebase.initializeApp();
//     return firebaseApp;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: FutureBuilder(
//       future: _initializeFirebase(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           return LoginScreens();
//         }
//         return const Center(child: CircularProgressIndicator());
//       },
//     ));
//   }
// }
