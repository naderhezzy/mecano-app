import 'dart:io';

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
import 'package:mecano_app/theme/app_spacing.dart';
import 'package:uuid/uuid.dart';

class AddVehicleScreen extends ConsumerStatefulWidget {
  const AddVehicleScreen({super.key});

  @override
  ConsumerState<AddVehicleScreen> createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends ConsumerState<AddVehicleScreen> {
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
  final List<XFile> _selectedPhotos = [];

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

  List<String> get _availableModels {
    if (_selectedMake == null || _isCustomMake) return [];
    return AppConstants.popularModels[_selectedMake] ?? [];
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final images = await picker.pickMultiImage(imageQuality: 80);
    if (images.isNotEmpty) {
      setState(() {
        _selectedPhotos.addAll(images);
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
        _selectedPhotos.add(image);
      });
    }
  }

  void _removePhoto(int index) {
    setState(() {
      _selectedPhotos.removeAt(index);
    });
  }

  Future<List<String>> _uploadPhotos(String vehicleId) async {
    if (_selectedPhotos.isEmpty) return [];

    final client = ref.read(supabaseClientProvider);
    final urls = <String>[];

    for (var i = 0; i < _selectedPhotos.length; i++) {
      final photo = _selectedPhotos[i];
      final ext = photo.path.split('.').last.toLowerCase();
      final storagePath = '$vehicleId/photo_$i.$ext';

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

    final userId =
        ref.read(supabaseClientProvider).auth.currentUser?.id;

    if (userId == null) {
      if (mounted) {
        context.showSnackBar('User not authenticated', isError: true);
        setState(() => _isSaving = false);
      }
      return;
    }

    final vehicleId = const Uuid().v4();
    final now = DateTime.now();

    // Upload photos
    final photoUrls = await _uploadPhotos(vehicleId);

    final vehicle = Vehicle(
      id: vehicleId,
      userId: userId,
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
      photoUrls: photoUrls,
      notes: _notesController.text.trim().isNotEmpty
          ? _notesController.text.trim()
          : null,
      createdAt: now,
      updatedAt: now,
    );

    final result =
        await ref.read(vehicleRepositoryProvider).addVehicle(vehicle);

    if (!mounted) return;

    setState(() => _isSaving = false);

    result.fold(
      (error) => context.showSnackBar(error.message, isError: true),
      (_) {
        ref.invalidate(vehiclesProvider(userId));
        context.showSnackBar('Vehicle added successfully');
        context.pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Vehicle'),
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
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.check),
              label: Text(_isSaving ? 'Saving...' : 'Save Vehicle'),
            ),
            AppSpacing.verticalLg,
          ],
        ),
      ),
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
                return DropdownMenuItem(value: model, child: Text(model));
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
          itemCount: _selectedPhotos.length + 1,
          itemBuilder: (context, index) {
            if (index == _selectedPhotos.length) {
              // Add photo button
              return InkWell(
                onTap: () => _showPhotoOptions(),
                borderRadius: BorderRadius.circular(AppSpacing.sm),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: context.colorScheme.outline,
                      style: BorderStyle.solid,
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

            // Photo thumbnail
            return Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSpacing.sm),
                  child: Image.file(
                    File(_selectedPhotos[index].path),
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: GestureDetector(
                    onTap: () => _removePhoto(index),
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
