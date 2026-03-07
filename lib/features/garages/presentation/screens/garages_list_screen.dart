import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mecano_app/core/extensions/context_extensions.dart';
import 'package:mecano_app/features/garages/domain/models/garage.dart';
import 'package:mecano_app/features/garages/presentation/providers/garage_providers.dart';
import 'package:mecano_app/shared/widgets/app_error.dart';
import 'package:mecano_app/shared/widgets/app_loading.dart';
import 'package:mecano_app/shared/widgets/empty_state.dart';
import 'package:mecano_app/theme/app_spacing.dart';

class GaragesListScreen extends ConsumerStatefulWidget {
  const GaragesListScreen({super.key});

  @override
  ConsumerState<GaragesListScreen> createState() => _GaragesListScreenState();
}

class _GaragesListScreenState extends ConsumerState<GaragesListScreen> {
  bool _isSearchVisible = false;
  String _searchQuery = '';
  String? _selectedCity;
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final garagesAsync = ref.watch(
      garagesProvider(_selectedCity, _searchQuery),
    );
    final citiesAsync = ref.watch(garageCitiesProvider);

    return Scaffold(
      appBar: AppBar(
        title: _isSearchVisible
            ? _SearchField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() => _searchQuery = value);
                },
              )
            : const Text('Services'),
        actions: [
          IconButton(
            icon: Icon(_isSearchVisible ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _isSearchVisible = !_isSearchVisible;
                if (!_isSearchVisible) {
                  _searchController.clear();
                  _searchQuery = '';
                }
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // City filter chips
          citiesAsync.when(
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
            data: (cities) {
              if (cities.isEmpty) return const SizedBox.shrink();
              return SizedBox(
                height: 56,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: AppSpacing.paddingHorizontalMd,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: AppSpacing.sm),
                      child: FilterChip(
                        label: const Text('All'),
                        selected: _selectedCity == null,
                        onSelected: (_) {
                          setState(() => _selectedCity = null);
                        },
                      ),
                    ),
                    ...cities.map(
                      (city) => Padding(
                        padding:
                            const EdgeInsets.only(right: AppSpacing.sm),
                        child: FilterChip(
                          label: Text(city),
                          selected: _selectedCity == city,
                          onSelected: (_) {
                            setState(() {
                              _selectedCity =
                                  _selectedCity == city ? null : city;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          // Garages list
          Expanded(
            child: garagesAsync.when(
              loading: () => const AppLoading(),
              error: (error, _) => AppError(
                message: error.toString(),
                onRetry: () => ref.invalidate(
                  garagesProvider(_selectedCity, _searchQuery),
                ),
              ),
              data: (garages) {
                if (garages.isEmpty) {
                  return EmptyState(
                    icon: Icons.car_repair,
                    title: 'No garages found',
                    description: _searchQuery.isNotEmpty
                        ? 'Try a different search term'
                        : 'No garages available in this area',
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(
                      garagesProvider(_selectedCity, _searchQuery),
                    );
                  },
                  child: ListView.separated(
                    padding: AppSpacing.paddingMd,
                    itemCount: garages.length,
                    separatorBuilder: (_, __) => AppSpacing.verticalSm,
                    itemBuilder: (context, index) {
                      final garage = garages[index];
                      return _GarageCard(
                        garage: garage,
                        onTap: () =>
                            context.push('/services/${garage.id}'),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: 'Search garages...',
        border: InputBorder.none,
      ),
      onChanged: onChanged,
    );
  }
}

class _GarageCard extends StatelessWidget {
  const _GarageCard({
    required this.garage,
    required this.onTap,
  });

  final Garage garage;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Photo
            SizedBox(
              height: 160,
              width: double.infinity,
              child: garage.photoUrls.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: garage.photoUrls.first,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(
                        color: context.colorScheme.surfaceContainerHighest,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      errorWidget: (_, __, ___) =>
                          _PlaceholderImage(context: context),
                    )
                  : _PlaceholderImage(context: context),
            ),

            // Info
            Padding(
              padding: AppSpacing.paddingMd,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name + verified badge
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          garage.name,
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (garage.isVerified)
                        Padding(
                          padding:
                              const EdgeInsets.only(left: AppSpacing.xs),
                          child: Icon(
                            Icons.verified,
                            size: 20,
                            color: context.colorScheme.primary,
                          ),
                        ),
                    ],
                  ),
                  AppSpacing.verticalXs,

                  // City
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        garage.city,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  AppSpacing.verticalXs,

                  // Rating + review count
                  Row(
                    children: [
                      ...List.generate(5, (index) {
                        final starValue = index + 1;
                        if (garage.averageRating >= starValue) {
                          return Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.amber.shade700,
                          );
                        } else if (garage.averageRating >= starValue - 0.5) {
                          return Icon(
                            Icons.star_half,
                            size: 16,
                            color: Colors.amber.shade700,
                          );
                        }
                        return Icon(
                          Icons.star_border,
                          size: 16,
                          color: Colors.amber.shade700,
                        );
                      }),
                      AppSpacing.horizontalXs,
                      Text(
                        garage.averageRating.toStringAsFixed(1),
                        style: context.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      AppSpacing.horizontalXs,
                      Text(
                        '(${garage.totalReviews})',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
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

class _PlaceholderImage extends StatelessWidget {
  const _PlaceholderImage({required this.context});

  final BuildContext context;

  @override
  Widget build(BuildContext _) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Center(
        child: Icon(
          Icons.car_repair,
          size: 48,
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
    );
  }
}
