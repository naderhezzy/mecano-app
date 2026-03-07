import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mecano_app/core/extensions/context_extensions.dart';
import 'package:mecano_app/features/maintenance/data/repositories/maintenance_repository.dart';
import 'package:mecano_app/features/maintenance/domain/models/maintenance_record.dart';
import 'package:mecano_app/theme/app_spacing.dart';
import 'package:uuid/uuid.dart';

const _serviceTypes = <String, IconData>{
  'Oil Change': Icons.oil_barrel_outlined,
  'Brakes': Icons.do_not_touch_outlined,
  'Tires': Icons.tire_repair_outlined,
  'Engine': Icons.engineering_outlined,
  'Transmission': Icons.settings_outlined,
  'Electrical': Icons.electrical_services_outlined,
  'A/C': Icons.ac_unit_outlined,
  'Body Work': Icons.car_repair_outlined,
  'Inspection': Icons.checklist_outlined,
  'Battery': Icons.battery_charging_full_outlined,
  'Suspension': Icons.swap_vert_outlined,
  'Exhaust': Icons.air_outlined,
  'Other': Icons.build_outlined,
};

class AddMaintenanceScreen extends ConsumerStatefulWidget {
  const AddMaintenanceScreen({required this.vehicleId, super.key});

  final String vehicleId;

  @override
  ConsumerState<AddMaintenanceScreen> createState() =>
      _AddMaintenanceScreenState();
}

class _AddMaintenanceScreenState extends ConsumerState<AddMaintenanceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _costController = TextEditingController();
  final _mileageController = TextEditingController();
  final _nextMileageController = TextEditingController();
  final _notesController = TextEditingController();

  String _selectedServiceType = 'Oil Change';
  DateTime _serviceDate = DateTime.now();
  DateTime? _nextServiceDate;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _titleController.text = _selectedServiceType;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _costController.dispose();
    _mileageController.dispose();
    _nextMileageController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickServiceDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _serviceDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _serviceDate = picked);
    }
  }

  Future<void> _pickNextServiceDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _nextServiceDate ?? DateTime.now().add(
        const Duration(days: 180),
      ),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );
    if (picked != null) {
      setState(() => _nextServiceDate = picked);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final record = MaintenanceRecord(
      id: const Uuid().v4(),
      vehicleId: widget.vehicleId,
      serviceType: _selectedServiceType,
      title: _titleController.text.trim(),
      mileageAtService: _mileageController.text.isNotEmpty
          ? int.tryParse(_mileageController.text.trim())
          : null,
      cost: _costController.text.isNotEmpty
          ? double.tryParse(_costController.text.trim())
          : null,
      serviceDate: _serviceDate,
      nextServiceDate: _nextServiceDate,
      nextServiceMileage: _nextMileageController.text.isNotEmpty
          ? int.tryParse(_nextMileageController.text.trim())
          : null,
      notes: _notesController.text.trim().isNotEmpty
          ? _notesController.text.trim()
          : null,
    );

    final result =
        await ref.read(maintenanceRepositoryProvider).addMaintenanceRecord(
              record,
            );

    if (!mounted) return;

    setState(() => _isLoading = false);

    result.fold(
      (error) => context.showSnackBar(error.message, isError: true),
      (_) {
        context.showSnackBar('Maintenance record added');
        context.pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat.yMMMd();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Maintenance'),
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.paddingMd,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Service Type Dropdown
              DropdownButtonFormField<String>(
                value: _selectedServiceType,
                decoration: const InputDecoration(
                  labelText: 'Service Type',
                  prefixIcon: Icon(Icons.category_outlined),
                ),
                items: _serviceTypes.keys.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Row(
                      children: [
                        Icon(
                          _serviceTypes[type],
                          size: 20,
                          color: context.colorScheme.primary,
                        ),
                        AppSpacing.horizontalSm,
                        Text(type),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedServiceType = value;
                      // Auto-fill title if it matches the previous service type
                      if (_titleController.text.isEmpty ||
                          _serviceTypes.keys
                              .contains(_titleController.text)) {
                        _titleController.text = value;
                      }
                    });
                  }
                },
                validator: (value) =>
                    value == null ? 'Please select a service type' : null,
              ),
              AppSpacing.verticalMd,

              // Title
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  hintText: 'Enter maintenance title',
                  prefixIcon: Icon(Icons.title_outlined),
                ),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              AppSpacing.verticalMd,

              // Service Date
              InkWell(
                onTap: _pickServiceDate,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Service Date',
                    prefixIcon: Icon(Icons.calendar_today_outlined),
                  ),
                  child: Text(dateFormat.format(_serviceDate)),
                ),
              ),
              AppSpacing.verticalMd,

              // Cost in TND
              TextFormField(
                controller: _costController,
                decoration: const InputDecoration(
                  labelText: 'Cost (TND)',
                  hintText: 'Enter cost',
                  prefixIcon: Icon(Icons.payments_outlined),
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,3}')),
                ],
                textInputAction: TextInputAction.next,
              ),
              AppSpacing.verticalMd,

              // Mileage at Service
              TextFormField(
                controller: _mileageController,
                decoration: const InputDecoration(
                  labelText: 'Mileage at Service (km)',
                  hintText: 'Enter current mileage',
                  prefixIcon: Icon(Icons.speed_outlined),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textInputAction: TextInputAction.next,
              ),
              AppSpacing.verticalMd,

              // Next Service Date (optional)
              InkWell(
                onTap: _pickNextServiceDate,
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Next Service Date (optional)',
                    prefixIcon: const Icon(Icons.event_outlined),
                    suffixIcon: _nextServiceDate != null
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () =>
                                setState(() => _nextServiceDate = null),
                          )
                        : null,
                  ),
                  child: Text(
                    _nextServiceDate != null
                        ? dateFormat.format(_nextServiceDate!)
                        : 'Tap to select',
                    style: _nextServiceDate == null
                        ? context.textTheme.bodyLarge?.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                          )
                        : null,
                  ),
                ),
              ),
              AppSpacing.verticalMd,

              // Next Service Mileage (optional)
              TextFormField(
                controller: _nextMileageController,
                decoration: const InputDecoration(
                  labelText: 'Next Service Mileage (optional)',
                  hintText: 'Enter next service mileage',
                  prefixIcon: Icon(Icons.update_outlined),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textInputAction: TextInputAction.next,
              ),
              AppSpacing.verticalMd,

              // Notes (optional)
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: 'Notes (optional)',
                  hintText: 'Add any additional notes...',
                  prefixIcon: Icon(Icons.notes_outlined),
                  alignLabelWithHint: true,
                ),
                maxLines: 4,
                textInputAction: TextInputAction.done,
              ),
              AppSpacing.verticalXl,

              // Save Button
              SizedBox(
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: _isLoading ? null : _save,
                  icon: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.save_outlined),
                  label: Text(_isLoading ? 'Saving...' : 'Save Record'),
                ),
              ),
              AppSpacing.verticalLg,
            ],
          ),
        ),
      ),
    );
  }
}
