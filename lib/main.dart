import 'package:flutter/material.dart';
import 'package:land_conversion_kodagu/View/application_form.dart';
import 'package:land_conversion_kodagu/View/signUp_view.dart';
import 'package:land_conversion_kodagu/database/application_stepper.dart';
import 'package:land_conversion_kodagu/profile/view/profile_screen.dart';
import 'package:land_conversion_kodagu/providers/application_provider.dart';
import 'package:land_conversion_kodagu/services/application_services.dart';
import 'package:land_conversion_kodagu/testing/appbar.dart';
import 'package:land_conversion_kodagu/testing/drawer.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:routemaster/routemaster.dart';

import 'testing/menu_bar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

final routes = RouteMap(
    onUnknownRoute: (route) {
      return const MaterialPage(
          child: MyHomePage(
        title: 'd',
      ));
    },
    routes: {
      '/home': (_) =>
          MaterialPage(name: "Homepage", child: MyHomePage(title: 'd')),
      '/development': (_) =>
          MaterialPage(name: "Development", child: ApplicationForm()),
      '/ecosystem': (_) =>
          MaterialPage(name: "Ecosystem", child: ProfileScreen()),
    });

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ApplicationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProjectProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Conversion',

        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Google Sans",
          primarySwatch: Colors.blueGrey,
        ),
        // routerDelegate: RoutemasterDelegate(routesBuilder: (context) => routes),
        // routeInformationParser: const RoutemasterParser(),
        // builder: (context, widget) => ResponsiveWrapper.builder(
        //   ClampingScrollWrapper.builder(context, widget!),
        //   defaultScale: true,
        //   minWidth: 400,
        //   defaultName: MOBILE,
        //   breakpoints: const [
        //     ResponsiveBreakpoint.autoScale(450, name: MOBILE),
        //     ResponsiveBreakpoint.resize(600, name: TABLET),
        //     ResponsiveBreakpoint.resize(1000, name: DESKTOP),
        //   ],
        //   background: Container(
        //     color: Colors.white,
        //   ),
        //   backgroundColor: Colors.white,
        // ),
        home: MyHomePage(title: 'Land Conversion'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    //  _createTable();
    return const Scaffold(
      // appBar: ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)
      //     ? const PreferredSize(
      //         preferredSize: Size(double.infinity, 60), child: FlutterAppbar())
      //     : const PreferredSize(
      //         preferredSize: Size(double.infinity, 66), child: MenuBar()),
      // drawer: CustomDrawer(),
      backgroundColor: Color.fromRGBO(226, 223, 217, 1),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: SignUpView(),
      ),
    );
  }

  _createTable() {
    //  _showProgress('Creating table');
    ApplicationService.createTable().then((result) {
      if ('success' == result) {
        //  _showSnackBar(context, result);
        //_showProgress(widget.title);
      }
    });
  }
}
