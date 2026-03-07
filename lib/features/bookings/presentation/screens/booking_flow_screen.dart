import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mecano_app/core/extensions/context_extensions.dart';
import 'package:mecano_app/core/utils/currency_formatter.dart';
import 'package:mecano_app/features/bookings/data/repositories/booking_repository.dart';
import 'package:mecano_app/features/bookings/domain/models/booking.dart';
import 'package:mecano_app/features/vehicles/domain/models/vehicle.dart';
import 'package:mecano_app/features/vehicles/presentation/providers/vehicle_providers.dart';
import 'package:mecano_app/shared/providers/supabase_provider.dart';
import 'package:mecano_app/shared/widgets/app_error.dart';
import 'package:mecano_app/shared/widgets/app_loading.dart';
import 'package:mecano_app/theme/app_colors.dart';
import 'package:mecano_app/theme/app_spacing.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uuid/uuid.dart';

class BookingFlowScreen extends ConsumerStatefulWidget {
  const BookingFlowScreen({required this.garageId, super.key});

  final String garageId;

  @override
  ConsumerState<BookingFlowScreen> createState() => _BookingFlowScreenState();
}

class _BookingFlowScreenState extends ConsumerState<BookingFlowScreen> {
  int _currentStep = 0;

  // Step 1: Service category
  String? _selectedCategoryId;
  String? _selectedCategoryName;

  // Step 2: Vehicle
  String? _selectedVehicleId;
  Vehicle? _selectedVehicle;

  // Step 3: Date & time
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDate;
  String? _selectedTime;

  // Step 4: Notes & estimated cost
  final _notesController = TextEditingController();
  double? _estimatedCost;

  bool _isSubmitting = false;

  // Available time slots
  final List<String> _timeSlots = [
    '08:00',
    '08:30',
    '09:00',
    '09:30',
    '10:00',
    '10:30',
    '11:00',
    '11:30',
    '13:00',
    '13:30',
    '14:00',
    '14:30',
    '15:00',
    '15:30',
    '16:00',
    '16:30',
    '17:00',
  ];

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  bool _canContinue() {
    switch (_currentStep) {
      case 0:
        return _selectedCategoryId != null;
      case 1:
        return _selectedVehicleId != null;
      case 2:
        return _selectedDate != null && _selectedTime != null;
      case 3:
        return true;
      default:
        return false;
    }
  }

  void _onStepContinue() {
    if (!_canContinue()) return;

    if (_currentStep < 3) {
      setState(() => _currentStep++);
    } else {
      _submitBooking();
    }
  }

  void _onStepCancel() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    } else {
      context.pop();
    }
  }

  Future<void> _submitBooking() async {
    if (_isSubmitting) return;

    setState(() => _isSubmitting = true);

    final userId = ref.read(supabaseClientProvider).auth.currentUser?.id;
    if (userId == null) {
      if (mounted) {
        context.showSnackBar('User not authenticated', isError: true);
        setState(() => _isSubmitting = false);
      }
      return;
    }

    final now = DateTime.now();
    final booking = Booking(
      id: const Uuid().v4(),
      userId: userId,
      garageId: widget.garageId,
      vehicleId: _selectedVehicleId!,
      serviceCategoryId: _selectedCategoryId,
      status: 'pending',
      appointmentDate: _selectedDate!,
      appointmentTime: _selectedTime!,
      notes: _notesController.text.trim().isNotEmpty
          ? _notesController.text.trim()
          : null,
      estimatedCost: _estimatedCost,
      createdAt: now,
      updatedAt: now,
    );

    final repo = ref.read(bookingRepositoryProvider);
    final result = await repo.createBooking(booking);

    if (!mounted) return;

    result.fold(
      (error) {
        context.showSnackBar(error.message, isError: true);
        setState(() => _isSubmitting = false);
      },
      (created) {
        context.go('/bookings/${created.id}/confirmation');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userId = ref.watch(supabaseClientProvider).auth.currentUser?.id;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Appointment'),
      ),
      body: userId == null
          ? const AppError(message: 'Please log in to book an appointment')
          : Stepper(
              currentStep: _currentStep,
              onStepContinue: _canContinue() ? _onStepContinue : null,
              onStepCancel: _onStepCancel,
              controlsBuilder: (context, details) {
                return Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.md),
                  child: Row(
                    children: [
                      if (_currentStep == 3)
                        FilledButton.icon(
                          onPressed: _isSubmitting
                              ? null
                              : (_canContinue() ? _onStepContinue : null),
                          icon: _isSubmitting
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.check),
                          label: Text(
                              _isSubmitting ? 'Booking...' : 'Confirm Booking'),
                        )
                      else
                        FilledButton(
                          onPressed:
                              _canContinue() ? details.onStepContinue : null,
                          child: const Text('Continue'),
                        ),
                      AppSpacing.horizontalSm,
                      TextButton(
                        onPressed: details.onStepCancel,
                        child: Text(
                            _currentStep == 0 ? 'Cancel' : 'Back'),
                      ),
                    ],
                  ),
                );
              },
              steps: [
                Step(
                  title: const Text('Select Service'),
                  content: _buildServiceStep(),
                  isActive: _currentStep >= 0,
                  state: _currentStep > 0
                      ? StepState.complete
                      : StepState.indexed,
                ),
                Step(
                  title: const Text('Select Vehicle'),
                  content: _buildVehicleStep(userId),
                  isActive: _currentStep >= 1,
                  state: _currentStep > 1
                      ? StepState.complete
                      : StepState.indexed,
                ),
                Step(
                  title: const Text('Date & Time'),
                  content: _buildDateTimeStep(),
                  isActive: _currentStep >= 2,
                  state: _currentStep > 2
                      ? StepState.complete
                      : StepState.indexed,
                ),
                Step(
                  title: const Text('Review & Confirm'),
                  content: _buildReviewStep(),
                  isActive: _currentStep >= 3,
                  state: StepState.indexed,
                ),
              ],
            ),
    );
  }

  // ---------------------------------------------------------------------------
  // Step 1: Select service category
  // ---------------------------------------------------------------------------

  Widget _buildServiceStep() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _fetchGarageServices(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 120,
            child: AppLoading(message: 'Loading services...'),
          );
        }

        if (snapshot.hasError) {
          return AppError(
            message: 'Failed to load services',
            onRetry: () => setState(() {}),
          );
        }

        final services = snapshot.data ?? [];

        if (services.isEmpty) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
            child: Text('No services available for this garage.'),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: services.map((service) {
            final categoryId = service['id'] as String;
            final nameEn = service['name_en'] as String? ?? 'Unknown';
            final iconName = service['icon_name'] as String? ?? 'build';
            final priceMin = service['price_min'] as num?;
            final priceMax = service['price_max'] as num?;
            final isSelected = _selectedCategoryId == categoryId;

            String priceRange = '';
            if (priceMin != null && priceMax != null) {
              priceRange =
                  '${CurrencyFormatter.formatTND(priceMin.toDouble())} - ${CurrencyFormatter.formatTND(priceMax.toDouble())}';
            } else if (priceMin != null) {
              priceRange =
                  'From ${CurrencyFormatter.formatTND(priceMin.toDouble())}';
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Card(
                elevation: isSelected ? 2 : 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: isSelected
                        ? AppColors.primary
                        : context.colorScheme.outline.withValues(alpha: 0.3),
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: ListTile(
                  leading: Icon(
                    _getServiceIcon(iconName),
                    color: isSelected ? AppColors.primary : null,
                  ),
                  title: Text(
                    nameEn,
                    style: context.textTheme.titleSmall?.copyWith(
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  subtitle:
                      priceRange.isNotEmpty ? Text(priceRange) : null,
                  trailing: isSelected
                      ? const Icon(Icons.check_circle, color: AppColors.primary)
                      : null,
                  onTap: () {
                    setState(() {
                      _selectedCategoryId = categoryId;
                      _selectedCategoryName = nameEn;
                      // Update estimated cost based on price range
                      if (priceMin != null) {
                        _estimatedCost = priceMin.toDouble();
                      }
                    });
                  },
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Future<List<Map<String, dynamic>>> _fetchGarageServices() async {
    final client = ref.read(supabaseClientProvider);
    final response = await client
        .from('garage_services')
        .select('*, service_categories(*)')
        .eq('garage_id', widget.garageId);

    return (response as List).map((item) {
      final category =
          item['service_categories'] as Map<String, dynamic>? ?? {};
      return {
        'id': category['id'] ?? item['service_category_id'],
        'name_en': category['name_en'] ?? 'Unknown',
        'name_fr': category['name_fr'] ?? '',
        'icon_name': category['icon_name'] ?? 'build',
        'price_min': item['price_min'],
        'price_max': item['price_max'],
        'estimated_duration': item['estimated_duration'],
      };
    }).toList();
  }

  IconData _getServiceIcon(String iconName) {
    switch (iconName) {
      case 'oil_barrel':
        return Icons.opacity;
      case 'tire':
        return Icons.tire_repair;
      case 'brake':
        return Icons.disc_full;
      case 'engine':
        return Icons.settings;
      case 'battery':
        return Icons.battery_charging_full;
      case 'ac':
        return Icons.ac_unit;
      case 'electrical':
        return Icons.electrical_services;
      case 'body':
        return Icons.car_repair;
      case 'inspection':
        return Icons.fact_check;
      default:
        return Icons.build;
    }
  }

  // ---------------------------------------------------------------------------
  // Step 2: Select vehicle
  // ---------------------------------------------------------------------------

  Widget _buildVehicleStep(String userId) {
    final vehiclesAsync = ref.watch(vehiclesProvider(userId));

    return vehiclesAsync.when(
      loading: () => const SizedBox(
        height: 120,
        child: AppLoading(message: 'Loading vehicles...'),
      ),
      error: (error, _) => AppError(
        message: 'Failed to load vehicles',
        onRetry: () => ref.invalidate(vehiclesProvider(userId)),
      ),
      data: (vehicles) {
        if (vehicles.isEmpty) {
          return Column(
            children: [
              const Text('You have no vehicles yet.'),
              AppSpacing.verticalMd,
              OutlinedButton.icon(
                onPressed: () => context.push('/garage/add'),
                icon: const Icon(Icons.add),
                label: const Text('Add Vehicle'),
              ),
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: vehicles.map((vehicle) {
            final isSelected = _selectedVehicleId == vehicle.id;

            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Card(
                elevation: isSelected ? 2 : 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: isSelected
                        ? AppColors.primary
                        : context.colorScheme.outline.withValues(alpha: 0.3),
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: isSelected
                        ? AppColors.primary
                        : context.colorScheme.surfaceContainerHighest,
                    child: Icon(
                      Icons.directions_car,
                      color: isSelected ? Colors.white : null,
                    ),
                  ),
                  title: Text(
                    '${vehicle.make} ${vehicle.model}',
                    style: context.textTheme.titleSmall?.copyWith(
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  subtitle: Text(
                    '${vehicle.year} - ${vehicle.plateNumber ?? 'No plate'}',
                  ),
                  trailing: isSelected
                      ? const Icon(Icons.check_circle, color: AppColors.primary)
                      : vehicle.isPrimary
                          ? Chip(
                              label: Text(
                                'Primary',
                                style: context.textTheme.labelSmall,
                              ),
                              visualDensity: VisualDensity.compact,
                            )
                          : null,
                  onTap: () {
                    setState(() {
                      _selectedVehicleId = vehicle.id;
                      _selectedVehicle = vehicle;
                    });
                  },
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Step 3: Date & time selection
  // ---------------------------------------------------------------------------

  Widget _buildDateTimeStep() {
    final now = DateTime.now();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Calendar
        TableCalendar<dynamic>(
          firstDay: now,
          lastDay: now.add(const Duration(days: 90)),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDate = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
          calendarFormat: CalendarFormat.month,
          enabledDayPredicate: (day) {
            // Disable weekends (Sunday)
            return day.weekday != DateTime.sunday;
          },
          calendarStyle: CalendarStyle(
            selectedDecoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            todayDecoration: BoxDecoration(
              color: AppColors.primaryLight.withValues(alpha: 0.3),
              shape: BoxShape.circle,
            ),
          ),
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
          ),
        ),
        AppSpacing.verticalMd,

        // Time slots
        if (_selectedDate != null) ...[
          Text(
            'Select Time',
            style: context.textTheme.titleSmall,
          ),
          AppSpacing.verticalSm,
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: _timeSlots.map((time) {
              final isSelected = _selectedTime == time;
              return ChoiceChip(
                label: Text(time),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    _selectedTime = selected ? time : null;
                  });
                },
                selectedColor: AppColors.primary.withValues(alpha: 0.2),
                labelStyle: TextStyle(
                  color: isSelected ? AppColors.primary : null,
                  fontWeight:
                      isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Step 4: Review & confirm
  // ---------------------------------------------------------------------------

  Widget _buildReviewStep() {
    final dateFormat = DateFormat('EEEE, MMMM d, yyyy');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Summary card
        Card(
          child: Padding(
            padding: AppSpacing.paddingMd,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Booking Summary',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(),
                AppSpacing.verticalSm,

                // Service
                _buildSummaryRow(
                  Icons.build,
                  'Service',
                  _selectedCategoryName ?? 'Not selected',
                ),
                AppSpacing.verticalSm,

                // Vehicle
                _buildSummaryRow(
                  Icons.directions_car,
                  'Vehicle',
                  _selectedVehicle != null
                      ? '${_selectedVehicle!.make} ${_selectedVehicle!.model} (${_selectedVehicle!.year})'
                      : 'Not selected',
                ),
                AppSpacing.verticalSm,

                // Date
                _buildSummaryRow(
                  Icons.calendar_today,
                  'Date',
                  _selectedDate != null
                      ? dateFormat.format(_selectedDate!)
                      : 'Not selected',
                ),
                AppSpacing.verticalSm,

                // Time
                _buildSummaryRow(
                  Icons.access_time,
                  'Time',
                  _selectedTime ?? 'Not selected',
                ),
                AppSpacing.verticalSm,

                // Estimated cost
                if (_estimatedCost != null) ...[
                  _buildSummaryRow(
                    Icons.attach_money,
                    'Estimated Cost',
                    CurrencyFormatter.formatTND(_estimatedCost!),
                  ),
                  AppSpacing.verticalSm,
                ],
              ],
            ),
          ),
        ),
        AppSpacing.verticalMd,

        // Notes
        TextField(
          controller: _notesController,
          decoration: const InputDecoration(
            labelText: 'Additional Notes (optional)',
            hintText: 'Any special requests or details...',
            border: OutlineInputBorder(),
            alignLabelWithHint: true,
          ),
          maxLines: 3,
          textCapitalization: TextCapitalization.sentences,
        ),
      ],
    );
  }

  Widget _buildSummaryRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.textSecondary),
        AppSpacing.horizontalSm,
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: context.textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
