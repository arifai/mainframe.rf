import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:$name_snake_case$_mobile/api/api_client.dart';
import 'package:$name_snake_case$_mobile/blocs/$name_snake_case$/$name_snake_case$_bloc.dart';
import 'package:$name_snake_case$_mobile/blocs/$name_snake_case$/$name_snake_case$_event.dart';
import 'package:$name_snake_case$_mobile/blocs/$name_snake_case$/$name_snake_case$_state.dart';
import 'package:$name_snake_case$_mobile/blocs/simple_bloc_delegate.dart';
import 'package:$name_snake_case$_mobile/blocs/tab/tab_bloc.dart';
import 'package:$name_snake_case$_mobile/screens/home.dart';
import 'package:$name_snake_case$_mobile/screens/login/login.dart';
import 'package:$name_snake_case$_mobile/screens/splash/splash_page.dart';
import 'package:$name_snake_case$_mobile/$param.service_name_snake_case$_repository/$param.service_name_snake_case$_repository.dart';
import 'blocs/notif/notif.dart';

void main() async {
  Bloc.observer = SimpleBlocObserver();
  await DotEnv.load(fileName: ".env");
  
  final $param.service_name_pascal_case$Repository $param.service_name_camel_case$Repository = $param.service_name_pascal_case$Repository();

  ApiClient.$param.service_name_camel_case$Repository = $param.service_name_camel_case$Repository;

  runApp(BlocProvider(
    create: (ctx) {
      return $name_pascal_case$Bloc($param.service_name_camel_case$Repository: $param.service_name_camel_case$Repository)
        ..add(StartupEvent());
    },
    child: $name_pascal_case$App($param.service_name_camel_case$Repository: $param.service_name_camel_case$Repository),
  ));
}

class $name_pascal_case$App extends StatelessWidget {
  final $param.service_name_pascal_case$Repository $param.service_name_camel_case$Repository;

  $name_pascal_case$App({Key key, @required this.$param.service_name_camel_case$Repository}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final $name_snake_case$Bloc = BlocProvider.of<$name_pascal_case$Bloc>(context);

    return MaterialApp(title: '$name$', theme: $name_pascal_case$Theme.theme, routes: {
      "/": (context) {
        return BlocListener<$name_pascal_case$Bloc, $name_pascal_case$State>(
          listener: (BuildContext context, $name_pascal_case$State state) {
            print("main state: $state");
            if (state is AuthenticationUnauthenticated) {
              Navigator.of(context).pushReplacementNamed('/login');
            } else if (state is AuthenticationAuthenticated) {
              Navigator.of(context).pushReplacementNamed('/inner');
            }
          },
          child: SplashPage(),
        );
      },
      "/inner": (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<$name_pascal_case$Bloc>(
              create: (context) => $name_pascal_case$Bloc($param.service_name_camel_case$Repository: $param.service_name_camel_case$Repository),
            ),
            BlocProvider<TabBloc>(
              create: (context) => TabBloc(),
            ),
            BlocProvider<NotifBloc>(
              create: (context) => NotifBloc($name_snake_case$Bloc: $name_snake_case$Bloc),
            ),
            // BlocProvider<TaskManagerBloc>(builder: (context) => TaskManagerBloc(),),
          ],
          child: HomeScreen(
            title: "$name$ Home",
            $name_snake_case$Bloc: $name_snake_case$Bloc
          ),
        );
      },
      "/login": (context) {
        return BlocListener<$name_pascal_case$Bloc, $name_pascal_case$State>(
          listener: (BuildContext context, $name_pascal_case$State state) {
            if (state is AuthenticationAuthenticated) {
              Navigator.of(context).pushReplacementNamed('/inner');
            }
          },
          child: LoginPage(
            $param.service_name_camel_case$Repository: $param.service_name_camel_case$Repository,
          ),
        );
      }
    });
  }
}


class $name_pascal_case$Theme {
  static get theme {
    final originalTextTheme = ThemeData.light().textTheme;
    final originalBody1 = originalTextTheme.body1;

    return ThemeData.light().copyWith(
        primaryColor: Colors.grey[100],
        accentColor: Colors.cyan[300],
        buttonColor: Colors.grey[800],
        textSelectionColor: Colors.cyan[100],
        backgroundColor: Colors.grey[900],
        toggleableActiveColor: Colors.cyan[300],
        textTheme: originalTextTheme.copyWith(
            body1:
                originalBody1.copyWith(decorationColor: Colors.transparent)));
  }
}
