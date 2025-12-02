import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/film_viewmodel.dart';
import '../themes/indice.dart';
import 'film_detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<FilmViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Studio Ghibli Films"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => vm.cargarFilms(),
            tooltip: 'Recargar películas',
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFiltersSection(context, vm),
          Expanded(
            child: _buildContent(context, vm),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersSection(BuildContext context, FilmViewModel vm) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColoresApp.fondoTarjeta,
        boxShadow: [
          BoxShadow(
            color: ColoresApp.sombra,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Buscador
          TextField(
            decoration: InputDecoration(
              hintText: 'Buscar películas...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: ColoresApp.divider),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: ColoresApp.divider),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: ColoresApp.primario, width: 2),
              ),
            ),
            onChanged: vm.buscarPorTexto,
          ),
          const SizedBox(height: 12),
          
          // Filtro por director
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: vm.selectedDirector.isEmpty ? null : vm.selectedDirector,
                  hint: const Text('Filtrar por director'),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  items: vm.availableDirectors
                      .map((director) => DropdownMenuItem(
                            value: director,
                            child: Text(director, overflow: TextOverflow.ellipsis),
                          ))
                      .toList(),
                  onChanged: (value) => vm.filtrarPorDirector(value ?? ''),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: vm.limpiarFiltros,
                icon: const Icon(Icons.clear),
                label: const Text('Limpiar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColoresApp.botonSecundario,
                  foregroundColor: ColoresApp.textoPrincipal,
                ),
              ),
            ],
          ),
          
          // Contador de resultados
          if (!vm.loading)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                '${vm.films.length} película(s) encontrada(s)',
                style: TipografiaApp.descripcionFilm,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, FilmViewModel vm) {
    if (vm.loading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Cargando películas de Studio Ghibli...'),
          ],
        ),
      );
    }

    if (vm.errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: ColoresApp.error),
              const SizedBox(height: 16),
              Text(
                vm.errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: ColoresApp.error),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () => vm.cargarFilms(),
                icon: const Icon(Icons.refresh),
                label: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      );
    }

    if (vm.films.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.movie_filter, size: 64, color: ColoresApp.textoSecundario),
            SizedBox(height: 16),
            Text(
              'No hay películas que coincidan con los filtros',
              style: TextStyle(fontSize: 16, color: ColoresApp.textoSecundario),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: vm.films.length,
      itemBuilder: (context, index) {
        final film = vm.films[index];
        return _buildFilmCard(context, film, index);
      },
    );
  }

  Widget _buildFilmCard(BuildContext context, film, int index) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => FilmDetailPage(film: film),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: index % 4 == 0 ? ColoresApp.gradienteMagico :
                     index % 4 == 1 ? ColoresApp.gradienteAtardecer :
                     index % 4 == 2 ? ColoresApp.gradienteBosque :
                     ColoresApp.gradienteOro,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Ícono de película
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: ColoresApp.gradienteCielo,
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: ColoresApp.primario.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.movie,
                    size: 35,
                    color: ColoresApp.textoClaro,
                  ),
                ),
                const SizedBox(height: 12),
                
                // Título
                Text(
                  film.title,
                  style: TipografiaApp.tituloFilm,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                
                // Director
                Text(
                  film.director,
                  style: TipografiaApp.directorFilm,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                
                // Año
                Text(
                  film.releaseDate,
                  style: TipografiaApp.anioFilm,
                ),
                const Spacer(),
                
                // Score y duración
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [ColoresApp.secundario, ColoresApp.acento],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: ColoresApp.secundario.withOpacity(0.3),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        '★ ${film.rtScore}',
                        style: const TextStyle(
                          color: ColoresApp.textoClaro,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      '${film.runningTime}min',
                      style: TipografiaApp.descripcionFilm,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}