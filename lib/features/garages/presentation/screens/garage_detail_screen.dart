import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mecano_app/core/extensions/context_extensions.dart';
import 'package:mecano_app/core/utils/currency_formatter.dart';
import 'package:mecano_app/features/garages/data/repositories/garage_repository.dart';
import 'package:mecano_app/features/garages/domain/models/garage.dart';
import 'package:mecano_app/features/garages/domain/models/garage_review.dart';
import 'package:mecano_app/features/garages/domain/models/garage_service.dart';
import 'package:mecano_app/features/garages/presentation/providers/garage_providers.dart';
import 'package:mecano_app/shared/providers/supabase_provider.dart';
import 'package:mecano_app/shared/widgets/app_error.dart';
import 'package:mecano_app/shared/widgets/app_loading.dart';
import 'package:mecano_app/theme/app_spacing.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

class GarageDetailScreen extends ConsumerWidget {
  const GarageDetailScreen({required this.garageId, super.key});

  final String garageId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final garageAsync = ref.watch(garageDetailProvider(garageId));

    return garageAsync.when(
      loading: () => const Scaffold(body: AppLoading()),
      error: (error, _) => Scaffold(
        appBar: AppBar(),
        body: AppError(
          message: error.toString(),
          onRetry: () => ref.invalidate(garageDetailProvider(garageId)),
        ),
      ),
      data: (garage) => _GarageDetailView(
        garage: garage,
        garageId: garageId,
      ),
    );
  }
}

class _GarageDetailView extends ConsumerWidget {
  const _GarageDetailView({
    required this.garage,
    required this.garageId,
  });

  final Garage garage;
  final String garageId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final servicesAsync = ref.watch(garageServicesProvider(garageId));
    final reviewsAsync = ref.watch(garageReviewsProvider(garageId));

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Hero image
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: garage.photoUrls.isNotEmpty
                  ? _ImageCarousel(photoUrls: garage.photoUrls)
                  : Container(
                      color: context.colorScheme.surfaceContainerHighest,
                      child: Center(
                        child: Icon(
                          Icons.car_repair,
                          size: 80,
                          color: context.colorScheme.outline,
                        ),
                      ),
                    ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
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
                          style: context.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (garage.isVerified)
                        Chip(
                          avatar: Icon(
                            Icons.verified,
                            size: 16,
                            color: context.colorScheme.primary,
                          ),
                          label: Text(
                            'Verified',
                            style: context.textTheme.labelSmall,
                          ),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                        ),
                    ],
                  ),
                  AppSpacing.verticalXs,

                  // Rating stars + review count
                  Row(
                    children: [
                      RatingBarIndicator(
                        rating: garage.averageRating,
                        itemBuilder: (_, __) => Icon(
                          Icons.star,
                          color: Colors.amber.shade700,
                        ),
                        itemCount: 5,
                        itemSize: 20,
                      ),
                      AppSpacing.horizontalSm,
                      Text(
                        '${garage.averageRating.toStringAsFixed(1)} (${garage.totalReviews} reviews)',
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  AppSpacing.verticalMd,

                  // Address
                  _InfoRow(
                    icon: Icons.location_on_outlined,
                    text: '${garage.address}, ${garage.city}',
                  ),
                  AppSpacing.verticalSm,

                  // Phone + call button
                  if (garage.phone != null && garage.phone!.isNotEmpty)
                    _InfoRow(
                      icon: Icons.phone_outlined,
                      text: garage.phone!,
                      trailing: IconButton(
                        icon: const Icon(Icons.call),
                        onPressed: () async {
                          final uri = Uri.parse('tel:${garage.phone}');
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri);
                          }
                        },
                        style: IconButton.styleFrom(
                          foregroundColor: context.colorScheme.primary,
                        ),
                      ),
                    ),

                  AppSpacing.verticalLg,

                  // Working hours
                  if (garage.workingHours.isNotEmpty)
                    _WorkingHoursSection(workingHours: garage.workingHours),

                  AppSpacing.verticalLg,

                  // Services section
                  Text(
                    'Services Offered',
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  AppSpacing.verticalSm,
                  servicesAsync.when(
                    loading: () => const Center(
                      child: Padding(
                        padding: EdgeInsets.all(AppSpacing.md),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    error: (error, _) => Text(
                      'Failed to load services: $error',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.error,
                      ),
                    ),
                    data: (services) {
                      if (services.isEmpty) {
                        return Padding(
                          padding:
                              const EdgeInsets.symmetric(vertical: AppSpacing.md),
                          child: Text(
                            'No services listed yet',
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        );
                      }

                      return Column(
                        children: services
                            .map((s) => _ServiceTile(service: s))
                            .toList(),
                      );
                    },
                  ),

                  AppSpacing.verticalLg,

                  // Reviews section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Reviews',
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () =>
                            _showWriteReviewDialog(context, ref),
                        icon: const Icon(Icons.rate_review_outlined),
                        label: const Text('Write a Review'),
                      ),
                    ],
                  ),
                  AppSpacing.verticalSm,
                  reviewsAsync.when(
                    loading: () => const Center(
                      child: Padding(
                        padding: EdgeInsets.all(AppSpacing.md),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    error: (error, _) => Text(
                      'Failed to load reviews: $error',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.error,
                      ),
                    ),
                    data: (reviews) {
                      if (reviews.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppSpacing.md,
                          ),
                          child: Text(
                            'No reviews yet. Be the first to review!',
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        );
                      }

                      return Column(
                        children: reviews
                            .map((r) => _ReviewCard(review: r))
                            .toList(),
                      );
                    },
                  ),

                  // Bottom padding for FAB
                  AppSpacing.verticalXl,
                  AppSpacing.verticalXl,
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/services/$garageId/book'),
        icon: const Icon(Icons.calendar_month),
        label: const Text('Book Now'),
      ),
    );
  }

  void _showWriteReviewDialog(BuildContext context, WidgetRef ref) {
    var rating = 3.0;
    final commentController = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Write a Review'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RatingBar.builder(
              initialRating: rating,
              minRating: 1,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 2),
              itemBuilder: (_, __) => Icon(
                Icons.star,
                color: Colors.amber.shade700,
              ),
              onRatingUpdate: (value) => rating = value,
            ),
            AppSpacing.verticalMd,
            TextField(
              controller: commentController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Share your experience...',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              final userId = ref
                  .read(supabaseClientProvider)
                  .auth
                  .currentUser
                  ?.id;

              if (userId == null) {
                if (context.mounted) {
                  context.showSnackBar(
                    'You must be logged in to review',
                    isError: true,
                  );
                }
                return;
              }

              final now = DateTime.now();
              final review = GarageReview(
                id: const Uuid().v4(),
                garageId: garageId,
                userId: userId,
                rating: rating.toInt(),
                comment: commentController.text.isNotEmpty
                    ? commentController.text
                    : null,
                createdAt: now,
                updatedAt: now,
              );

              Navigator.pop(dialogContext);

              final result =
                  await ref.read(garageRepositoryProvider).addReview(review);

              if (!context.mounted) return;

              result.fold(
                (error) => context.showSnackBar(
                  error.message,
                  isError: true,
                ),
                (_) {
                  context.showSnackBar('Review submitted successfully');
                  ref.invalidate(garageReviewsProvider(garageId));
                  ref.invalidate(garageDetailProvider(garageId));
                },
              );
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Sub-widgets
// ---------------------------------------------------------------------------

class _ImageCarousel extends StatefulWidget {
  const _ImageCarousel({required this.photoUrls});

  final List<String> photoUrls;

  @override
  State<_ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<_ImageCarousel> {
  final _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        PageView.builder(
          controller: _pageController,
          itemCount: widget.photoUrls.length,
          onPageChanged: (index) => setState(() => _currentPage = index),
          itemBuilder: (_, index) => CachedNetworkImage(
            imageUrl: widget.photoUrls[index],
            fit: BoxFit.cover,
            placeholder: (_, __) => Container(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: const Center(child: CircularProgressIndicator()),
            ),
            errorWidget: (_, __, ___) => Container(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: const Center(
                child: Icon(Icons.broken_image, size: 48),
              ),
            ),
          ),
        ),
        if (widget.photoUrls.length > 1)
          Positioned(
            bottom: 12,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.photoUrls.length,
                (index) => Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? Colors.white
                        : Colors.white.withValues(alpha: 0.5),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.text,
    this.trailing,
  });

  final IconData icon;
  final String text;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        AppSpacing.horizontalSm,
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}

class _WorkingHoursSection extends StatefulWidget {
  const _WorkingHoursSection({required this.workingHours});

  final Map<String, dynamic> workingHours;

  @override
  State<_WorkingHoursSection> createState() => _WorkingHoursSectionState();
}

class _WorkingHoursSectionState extends State<_WorkingHoursSection> {
  bool _isExpanded = false;

  static const _dayOrder = [
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
    'sunday',
  ];

  static const _dayLabels = {
    'monday': 'Mon',
    'tuesday': 'Tue',
    'wednesday': 'Wed',
    'thursday': 'Thu',
    'friday': 'Fri',
    'saturday': 'Sat',
    'sunday': 'Sun',
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
            child: Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 20,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                AppSpacing.horizontalSm,
                Text(
                  'Working Hours',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const Spacer(),
                Icon(
                  _isExpanded
                      ? Icons.expand_less
                      : Icons.expand_more,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded) ...[
          AppSpacing.verticalSm,
          Card(
            child: Padding(
              padding: AppSpacing.paddingMd,
              child: Column(
                children: _dayOrder.map((day) {
                  final hours = widget.workingHours[day];
                  final label = _dayLabels[day] ?? day;
                  final value = hours is String
                      ? hours
                      : (hours != null ? hours.toString() : 'Closed');

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.xs,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          label,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        Text(
                          value,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                color: value == 'Closed'
                                    ? Theme.of(context).colorScheme.error
                                    : Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _ServiceTile extends StatelessWidget {
  const _ServiceTile({required this.service});

  final GarageService service;

  @override
  Widget build(BuildContext context) {
    String priceRange;
    if (service.priceMin != null && service.priceMax != null) {
      priceRange =
          '${CurrencyFormatter.formatTND(service.priceMin!)} - ${CurrencyFormatter.formatTND(service.priceMax!)}';
    } else if (service.priceMin != null) {
      priceRange = 'From ${CurrencyFormatter.formatTND(service.priceMin!)}';
    } else if (service.priceMax != null) {
      priceRange = 'Up to ${CurrencyFormatter.formatTND(service.priceMax!)}';
    } else {
      priceRange = 'Price on request';
    }

    String? duration;
    if (service.estimatedDuration != null) {
      final hours = service.estimatedDuration! ~/ 60;
      final minutes = service.estimatedDuration! % 60;
      if (hours > 0 && minutes > 0) {
        duration = '${hours}h ${minutes}min';
      } else if (hours > 0) {
        duration = '${hours}h';
      } else {
        duration = '${minutes}min';
      }
    }

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              Theme.of(context).colorScheme.primaryContainer,
          child: Icon(
            Icons.build_outlined,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        title: Text(service.serviceCategoryId),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(priceRange),
            if (duration != null)
              Text(
                'Est. $duration',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.review});

  final GarageReview review;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Padding(
        padding: AppSpacing.paddingMd,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                RatingBarIndicator(
                  rating: review.rating.toDouble(),
                  itemBuilder: (_, __) => Icon(
                    Icons.star,
                    color: Colors.amber.shade700,
                  ),
                  itemCount: 5,
                  itemSize: 16,
                ),
                const Spacer(),
                if (review.createdAt != null)
                  Text(
                    timeago.format(review.createdAt!),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color:
                              Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
              ],
            ),
            if (review.comment != null && review.comment!.isNotEmpty) ...[
              AppSpacing.verticalSm,
              Text(
                review.comment!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
