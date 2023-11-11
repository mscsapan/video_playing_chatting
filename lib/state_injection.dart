import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

class StateInjector {
  static final repositoryProviders = <RepositoryProvider>[
    RepositoryProvider<Client>(
      create: (context) => Client(),
    ),

    // RepositoryProvider<LocalDataSource>(
    //   create: (context) => LocalDataSourceImpl(
    //     sharedPreferences: context.read(),
    //   ),
    // ),
  ];
  static final blocProviders = <BlocProvider>[
    // BlocProvider<LoginBloc>(
    //   create: (context) => LoginBloc(
    //     authRepository: context.read(),
    //   ),
    // ),
  ];
}
