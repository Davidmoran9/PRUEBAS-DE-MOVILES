import 'package:flutter/material.dart';
import '../../domain/entities/film_entity.dart';
import '../themes/indice.dart';

class FilmDetailPage extends StatelessWidget {
  final FilmEntity film;

  const FilmDetailPage({super.key, required this.film});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(film.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header con ícono grande
            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: ColoresApp.gradienteMagico,
                  ),
                  borderRadius: BorderRadius.circular(60),
                  boxShadow: [
                    BoxShadow(
                      color: ColoresApp.primario.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.movie,
                  size: 70,
                  color: ColoresApp.textoClaro,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Título original
            if (film.originalTitle.isNotEmpty)
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: ColoresApp.gradienteAtardecer,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: ColoresApp.secundario.withOpacity(0.3),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    film.originalTitle,
                    style: TipografiaApp.directorFilm.copyWith(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            const SizedBox(height: 24),

            // Información básica en tarjetas
            Row(
              children: [
                Expanded(
                  child: _buildInfoCard(
                    'Año',
                    film.releaseDate,
                    Icons.calendar_today,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildInfoCard(
                    'Duración',
                    '${film.runningTime} min',
                    Icons.access_time,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildInfoCard(
                    'Score',
                    '★ ${film.rtScore}',
                    Icons.star,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Director y Productor
            _buildDetailSection(
              'Director',
              film.director,
              Icons.person,
            ),
            const SizedBox(height: 16),

            _buildDetailSection(
              'Productor',
              film.producer,
              Icons.business,
            ),
            const SizedBox(height: 24),

            // Descripción
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.description,
                          color: ColoresApp.primario,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Sinopsis',
                          style: TipografiaApp.tituloFilm.copyWith(fontSize: 20),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      film.description,
                      style: TipografiaApp.descripcionFilm.copyWith(
                        fontSize: 14,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Información adicional
            if (film.originalTitleRomanised.isNotEmpty)
              _buildDetailSection(
                'Título Romanizado',
                film.originalTitleRomanised,
                Icons.translate,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String label, String value, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              icon,
              color: ColoresApp.primario,
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TipografiaApp.descripcionFilm,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TipografiaApp.directorFilm.copyWith(
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, String content, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: ColoresApp.gradienteBosque,
                ),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: ColoresApp.botonPrincipal.withOpacity(0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: ColoresApp.primario,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TipografiaApp.descripcionFilm.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    content,
                    style: TipografiaApp.tituloFilm.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}