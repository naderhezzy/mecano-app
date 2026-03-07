import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mecano_app/core/constants/app_constants.dart';
import 'package:mecano_app/core/extensions/context_extensions.dart';
import 'package:mecano_app/core/utils/validators.dart';
import 'package:mecano_app/features/vehicles/data/repositories/vehicle_repository.dart';
import 'package:mecano_app/features/vehicles/domain/models/fuel_type.dart';
import 'package:mecano_app/features/vehicles/domain/models/vehicle.dart';
import 'package:mecano_app/features/vehicles/presentation/providers/vehicle_providers.dart';
import 'package:mecano_app/shared/providers/supabase_provider.dart';
import 'package:mecano_app/shared/widgets/app_error.dart';
import 'package:mecano_app/shared/widgets/app_loading.dart';
import 'package:mecano_app/theme/app_spacing.dart';

class EditVehicleScreen extends ConsumerStatefulWidget {
  const EditVehicleScreen({required this.vehicleId, super.key});

  final String vehicleId;

  @override
  ConsumerState<EditVehicleScreen> createState() => _EditVehicleScreenState();
}

class _EditVehicleScreenState extends ConsumerState<EditVehicleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _yearController = TextEditingController();
  final _mileageController = TextEditingController();
  final _plateNumberController = TextEditingController();
  final _vinController = TextEditingController();
  final _colorController = TextEditingController();
  final _notesController = TextEditingController();
  final _customMakeController = TextEditingController();
  final _customModelController = TextEditingController();

  String? _selectedMake;
  String? _selectedModel;
  FuelType _selectedFuelType = FuelType.gasoline;
  bool _isCustomMake = false;
  bool _isCustomModel = false;
  bool _isSaving = false;
  bool _isDeleting = false;
  bool _isInitialized = false;
  final List<XFile> _newPhotos = [];
  List<String> _existingPhotoUrls = [];

  Vehicle? _originalVehicle;

  @override
  void dispose() {
    _yearController.dispose();
    _mileageController.dispose();
    _plateNumberController.dispose();
    _vinController.dispose();
    _colorController.dispose();
    _notesController.dispose();
    _customMakeController.dispose();
    _customModelController.dispose();
    super.dispose();
  }

  void _initializeFromVehicle(Vehicle vehicle) {
    if (_isInitialized) return;
    _isInitialized = true;
    _originalVehicle = vehicle;

    // Check if make is in popular list
    if (AppConstants.popularMakes.contains(vehicle.make)) {
      _selectedMake = vehicle.make;
      // Check if model is in popular list for this make
      final models = AppConstants.popularModels[vehicle.make] ?? [];
      if (models.contains(vehicle.model)) {
        _selectedModel = vehicle.model;
      } else {
        _isCustomModel = true;
        _customModelController.text = vehicle.model;
      }
    } else {
      _isCustomMake = true;
      _customMakeController.text = vehicle.make;
      _isCustomModel = true;
      _customModelController.text = vehicle.model;
    }

    _yearController.text = vehicle.year.toString();
    _mileageController.text = vehicle.mileage.toString();
    _plateNumberController.text = vehicle.plateNumber ?? '';
    _vinController.text = vehicle.vin ?? '';
    _colorController.text = vehicle.color ?? '';
    _notesController.text = vehicle.notes ?? '';
    _existingPhotoUrls = List.from(vehicle.photoUrls);

    try {
      _selectedFuelType = FuelType.values.firstWhere(
        (e) => e.name == vehicle.fuelType,
      );
    } catch (_) {
      _selectedFuelType = FuelType.gasoline;
    }
  }

  List<String> get _availableModels {
    if (_selectedMake == null || _isCustomMake) return [];
    return AppConstants.popularModels[_selectedMake] ?? [];
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final images = await picker.pickMultiImage(imageQuality: 80);
    if (images.isNotEmpty) {
      setState(() {
        _newPhotos.addAll(images);
      });
    }
  }

  Future<void> _takePhoto() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );
    if (image != null) {
      setState(() {
        _newPhotos.add(image);
      });
    }
  }

  void _removeExistingPhoto(int index) {
    setState(() {
      _existingPhotoUrls.removeAt(index);
    });
  }

  void _removeNewPhoto(int index) {
    setState(() {
      _newPhotos.removeAt(index);
    });
  }

  Future<List<String>> _uploadNewPhotos() async {
    if (_newPhotos.isEmpty) return [];

    final client = ref.read(supabaseClientProvider);
    final urls = <String>[];
    final startIndex = _existingPhotoUrls.length;

    for (var i = 0; i < _newPhotos.length; i++) {
      final photo = _newPhotos[i];
      final ext = photo.path.split('.').last.toLowerCase();
      final storagePath =
          '${widget.vehicleId}/photo_${startIndex + i}.$ext';

      try {
        await client.storage.from('vehicle-photos').upload(
              storagePath,
              File(photo.path),
            );

        final url = client.storage
            .from('vehicle-photos')
            .getPublicUrl(storagePath);

        urls.add(url);
      } catch (_) {
        // Skip failed uploads
      }
    }

    return urls;
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;

    final make = _isCustomMake ? _customMakeController.text.trim() : _selectedMake;
    final model =
        _isCustomModel ? _customModelController.text.trim() : _selectedModel;

    if (make == null || make.isEmpty) {
      context.showSnackBar('Please select or enter a make', isError: true);
      return;
    }
    if (model == null || model.isEmpty) {
      context.showSnackBar('Please select or enter a model', isError: true);
      return;
    }

    setState(() => _isSaving = true);

    // Upload new photos
    final newPhotoUrls = await _uploadNewPhotos();
    final allPhotoUrls = [..._existingPhotoUrls, ...newPhotoUrls];

    final vehicle = _originalVehicle!;
    final updated = vehicle.copyWith(
      make: make,
      model: model,
      year: int.parse(_yearController.text.trim()),
      mileage: int.parse(
        _mileageController.text.trim().replaceAll(RegExp(r'[,\s]'), ''),
      ),
      vin: _vinController.text.trim().isNotEmpty
          ? _vinController.text.trim().toUpperCase()
          : null,
      fuelType: _selectedFuelType.name,
      plateNumber: _plateNumberController.text.trim().isNotEmpty
          ? _plateNumberController.text.trim()
          : null,
      color: _colorController.text.trim().isNotEmpty
          ? _colorController.text.trim()
          : null,
      photoUrls: allPhotoUrls,
      notes: _notesController.text.trim().isNotEmpty
          ? _notesController.text.trim()
          : null,
      updatedAt: DateTime.now(),
    );

    final result =
        await ref.read(vehicleRepositoryProvider).updateVehicle(updated);

    if (!mounted) return;

    setState(() => _isSaving = false);

    result.fold(
      (error) => context.showSnackBar(error.message, isError: true),
      (_) {
        ref.invalidate(vehicleProvider(widget.vehicleId));
        ref.invalidate(vehiclesProvider(vehicle.userId));
        context.showSnackBar('Vehicle updated successfully');
        context.pop();
      },
    );
  }

  Future<void> _handleDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Vehicle'),
        content: const Text(
          'Are you sure you want to delete this vehicle? '
          'This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(ctx).colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() => _isDeleting = true);

    final result = await ref
        .read(vehicleRepositoryProvider)
        .deleteVehicle(widget.vehicleId);

    if (!mounted) return;

    setState(() => _isDeleting = false);

    result.fold(
      (error) => context.showSnackBar(error.message, isError: true),
      (_) {
        final userId = _originalVehicle?.userId;
        if (userId != null) {
          ref.invalidate(vehiclesProvider(userId));
        }
        context.showSnackBar('Vehicle deleted');
        // Pop back to garage screen
        context.go('/garage');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final vehicleAsync = ref.watch(vehicleProvider(widget.vehicleId));

    return vehicleAsync.when(
      loading: () => const Scaffold(
        body: AppLoading(message: 'Loading vehicle...'),
      ),
      error: (error, _) => Scaffold(
        appBar: AppBar(title: const Text('Edit Vehicle')),
        body: AppError(
          message: error.toString(),
          onRetry: () => ref.invalidate(vehicleProvider(widget.vehicleId)),
        ),
      ),
      data: (vehicle) {
        _initializeFromVehicle(vehicle);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Edit Vehicle'),
            actions: [
              IconButton(
                onPressed: _isDeleting ? null : _handleDelete,
                icon: _isDeleting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.delete_outline),
                color: context.colorScheme.error,
                tooltip: 'Delete vehicle',
              ),
            ],
          ),
          body: Form(
            key: _formKey,
            child: ListView(
              padding: AppSpacing.paddingMd,
              children: [
                // Make dropdown
                _buildMakeField(),
                AppSpacing.verticalMd,

                // Model dropdown
                _buildModelField(),
                AppSpacing.verticalMd,

                // Year
                TextFormField(
                  controller: _yearController,
                  decoration: const InputDecoration(
                    labelText: 'Year *',
                    hintText: 'e.g. 2020',
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  keyboardType: TextInputType.number,
                  validator: Validators.year,
                ),
                AppSpacing.verticalMd,

                // Mileage
                TextFormField(
                  controller: _mileageController,
                  decoration: const InputDecoration(
                    labelText: 'Mileage (km) *',
                    hintText: 'e.g. 50000',
                    prefixIcon: Icon(Icons.speed),
                  ),
                  keyboardType: TextInputType.number,
                  validator: Validators.mileage,
                ),
                AppSpacing.verticalMd,

                // Fuel type
                DropdownButtonFormField<FuelType>(
                  value: _selectedFuelType,
                  decoration: const InputDecoration(
                    labelText: 'Fuel Type *',
                    prefixIcon: Icon(Icons.local_gas_station),
                  ),
                  items: FuelType.values.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type.label),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _selectedFuelType = value);
                    }
                  },
                ),
                AppSpacing.verticalMd,

                // Plate number
                TextFormField(
                  controller: _plateNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Plate Number',
                    hintText: 'e.g. 123 TU 4567',
                    prefixIcon: Icon(Icons.badge),
                  ),
                  textCapitalization: TextCapitalization.characters,
                  validator: Validators.plateNumber,
                ),
                AppSpacing.verticalMd,

                // VIN
                TextFormField(
                  controller: _vinController,
                  decoration: const InputDecoration(
                    labelText: 'VIN',
                    hintText: '17-character Vehicle Identification Number',
                    prefixIcon: Icon(Icons.qr_code),
                  ),
                  textCapitalization: TextCapitalization.characters,
                  validator: Validators.vin,
                ),
                AppSpacing.verticalMd,

                // Color
                TextFormField(
                  controller: _colorController,
                  decoration: const InputDecoration(
                    labelText: 'Color',
                    hintText: 'e.g. White, Black, Silver',
                    prefixIcon: Icon(Icons.palette),
                  ),
                  textCapitalization: TextCapitalization.words,
                ),
                AppSpacing.verticalMd,

                // Notes
                TextFormField(
                  controller: _notesController,
                  decoration: const InputDecoration(
                    labelText: 'Notes',
                    hintText: 'Any additional notes about this vehicle',
                    prefixIcon: Icon(Icons.notes),
                    alignLabelWithHint: true,
                  ),
                  maxLines: 3,
                  textCapitalization: TextCapitalization.sentences,
                ),
                AppSpacing.verticalLg,

                // Photos section
                _buildPhotoSection(),
                AppSpacing.verticalXl,

                // Save button
                FilledButton.icon(
                  onPressed: _isSaving ? null : _handleSave,
                  icon: _isSaving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child:
                              CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.check),
                  label:
                      Text(_isSaving ? 'Saving...' : 'Update Vehicle'),
                ),
                AppSpacing.verticalMd,

                // Delete button
                OutlinedButton.icon(
                  onPressed: _isDeleting ? null : _handleDelete,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: context.colorScheme.error,
                    side: BorderSide(color: context.colorScheme.error),
                  ),
                  icon: const Icon(Icons.delete_outline),
                  label: const Text('Delete Vehicle'),
                ),
                AppSpacing.verticalLg,
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMakeField() {
    if (_isCustomMake) {
      return TextFormField(
        controller: _customMakeController,
        decoration: InputDecoration(
          labelText: 'Make *',
          hintText: 'Enter car make',
          prefixIcon: const Icon(Icons.directions_car),
          suffixIcon: IconButton(
            icon: const Icon(Icons.list),
            tooltip: 'Choose from list',
            onPressed: () => setState(() {
              _isCustomMake = false;
              _isCustomModel = false;
              _customMakeController.clear();
              _customModelController.clear();
              _selectedMake = null;
              _selectedModel = null;
            }),
          ),
        ),
        textCapitalization: TextCapitalization.words,
        validator: (v) => Validators.required(v, 'Make'),
      );
    }

    return DropdownButtonFormField<String>(
      value: _selectedMake,
      decoration: const InputDecoration(
        labelText: 'Make *',
        prefixIcon: Icon(Icons.directions_car),
      ),
      hint: const Text('Select make'),
      items: [
        ...AppConstants.popularMakes.map((make) {
          return DropdownMenuItem(value: make, child: Text(make));
        }),
        const DropdownMenuItem(
          value: '_other',
          child: Text('Other...'),
        ),
      ],
      onChanged: (value) {
        if (value == '_other') {
          setState(() {
            _isCustomMake = true;
            _selectedMake = null;
            _selectedModel = null;
            _isCustomModel = false;
          });
        } else {
          setState(() {
            _selectedMake = value;
            _selectedModel = null;
            _isCustomModel = false;
          });
        }
      },
      validator: (v) =>
          v == null && !_isCustomMake ? 'Please select a make' : null,
    );
  }

  Widget _buildModelField() {
    if (_isCustomMake || _isCustomModel) {
      return TextFormField(
        controller: _customModelController,
        decoration: InputDecoration(
          labelText: 'Model *',
          hintText: 'Enter car model',
          prefixIcon: const Icon(Icons.time_to_leave),
          suffixIcon: !_isCustomMake && _availableModels.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.list),
                  tooltip: 'Choose from list',
                  onPressed: () => setState(() {
                    _isCustomModel = false;
                    _customModelController.clear();
                    _selectedModel = null;
                  }),
                )
              : null,
        ),
        textCapitalization: TextCapitalization.words,
        validator: (v) => Validators.required(v, 'Model'),
      );
    }

    return DropdownButtonFormField<String>(
      value: _selectedModel,
      decoration: const InputDecoration(
        labelText: 'Model *',
        prefixIcon: Icon(Icons.time_to_leave),
      ),
      hint: Text(
        _selectedMake == null ? 'Select make first' : 'Select model',
      ),
      items: _selectedMake == null
          ? []
          : [
              ..._availableModels.map((model) {
                return DropdownMenuItem(
                    value: model, child: Text(model));
              }),
              const DropdownMenuItem(
                value: '_other',
                child: Text('Other...'),
              ),
            ],
      onChanged: _selectedMake == null
          ? null
          : (value) {
              if (value == '_other') {
                setState(() {
                  _isCustomModel = true;
                  _selectedModel = null;
                });
              } else {
                setState(() {
                  _selectedModel = value;
                });
              }
            },
      validator: (v) =>
          v == null && !_isCustomModel ? 'Please select a model' : null,
    );
  }

  Widget _buildPhotoSection() {
    final totalPhotos = _existingPhotoUrls.length + _newPhotos.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Photos',
          style: context.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        AppSpacing.verticalSm,
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: AppSpacing.sm,
            mainAxisSpacing: AppSpacing.sm,
          ),
          itemCount: totalPhotos + 1,
          itemBuilder: (context, index) {
            if (index == totalPhotos) {
              // Add photo button
              return InkWell(
                onTap: () => _showPhotoOptions(),
                borderRadius: BorderRadius.circular(AppSpacing.sm),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: context.colorScheme.outline,
                    ),
                    borderRadius: BorderRadius.circular(AppSpacing.sm),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_photo_alternate_outlined,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                      AppSpacing.verticalXs,
                      Text(
                        'Add Photo',
                        style: context.textTheme.labelSmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            // Existing photo
            if (index < _existingPhotoUrls.length) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(AppSpacing.sm),
                    child: CachedNetworkImage(
                      imageUrl: _existingPhotoUrls[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: GestureDetector(
                      onTap: () => _removeExistingPhoto(index),
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            // New photo
            final newIndex = index - _existingPhotoUrls.length;
            return Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSpacing.sm),
                  child: Image.file(
                    File(_newPhotos[newIndex].path),
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: GestureDetector(
                    onTap: () => _removeNewPhoto(newIndex),
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  void _showPhotoOptions() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(ctx);
                _pickImage();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take a Photo'),
              onTap: () {
                Navigator.pop(ctx);
                _takePhoto();
              },
            ),
          ],
        ),
      ),
    );
  }
}
