import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/presentation/viewmodels/film_viewmodel.dart';
import 'src/domain/usecases/get_films_usecase.dart';
import 'src/domain/usecases/get_film_by_id_usecase.dart';
import 'src/data/repositories/film_repository_impl.dart';
import 'src/data/datasources/film_api_datasource.dart';

import 'src/presentation/routes/app_routes.dart';
import 'src/presentation/themes/indice.dart';

void main() {
  // Inyección de dependencias
  final dataSource = FilmApiDataSource();
  final repo = FilmRepositoryImpl(dataSource);
  
  // Casos de uso
  final getFilmsUseCase = GetFilmsUseCase(repo);
  final getFilmByIdUseCase = GetFilmByIdUseCase(repo);

  runApp(MyApp(
    getFilmsUseCase: getFilmsUseCase,
    getFilmByIdUseCase: getFilmByIdUseCase,
  ));
}

class MyApp extends StatelessWidget {
  final GetFilmsUseCase getFilmsUseCase;
  final GetFilmByIdUseCase getFilmByIdUseCase;

  const MyApp({
    super.key,
    required this.getFilmsUseCase,
    required this.getFilmByIdUseCase,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FilmViewModel(
            getFilmsUseCase: getFilmsUseCase,
            getFilmByIdUseCase: getFilmByIdUseCase,
          )..cargarFilms(),
        ),
      ],
      child: MaterialApp(
        title: "Studio Ghibli Films - Consumo API",
        initialRoute: "/",
        routes: AppRoutes.routes,
        debugShowCheckedModeBanner: false,
        theme: temaGeneral,
      ),
    );
  }
}
