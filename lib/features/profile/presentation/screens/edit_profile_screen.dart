import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mecano_app/core/constants/app_constants.dart';
import 'package:mecano_app/core/extensions/context_extensions.dart';
import 'package:mecano_app/core/utils/validators.dart';
import 'package:mecano_app/features/profile/data/repositories/profile_repository.dart';
import 'package:mecano_app/features/profile/domain/models/user_profile.dart';
import 'package:mecano_app/theme/app_spacing.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();

  String? _selectedLocation;
  String? _avatarUrl;
  String? _pendingAvatarPath;
  bool _isLoading = false;
  bool _isInitialized = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _initFromProfile(UserProfile profile) {
    if (_isInitialized) return;
    _isInitialized = true;

    _fullNameController.text = profile.fullName ?? '';
    _phoneController.text = profile.phone ?? '';
    _selectedLocation = profile.location;
    _avatarUrl = profile.avatarUrl;
  }

  Future<void> _pickAvatar() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 80,
    );

    if (image == null) return;

    setState(() {
      _pendingAvatarPath = image.path;
    });
  }

  Future<void> _save(UserProfile currentProfile) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final repo = ref.read(profileRepositoryProvider);

    // Upload avatar if a new one was picked
    String? avatarUrl = _avatarUrl;
    if (_pendingAvatarPath != null) {
      final uploadResult = await repo.uploadAvatar(_pendingAvatarPath!);
      final uploadFailed = uploadResult.fold(
        (error) {
          if (mounted) {
            context.showSnackBar(error.message, isError: true);
          }
          return true;
        },
        (url) {
          avatarUrl = url;
          return false;
        },
      );

      if (uploadFailed) {
        if (mounted) setState(() => _isLoading = false);
        return;
      }
    }

    final updatedProfile = currentProfile.copyWith(
      fullName: _fullNameController.text.trim(),
      phone: _phoneController.text.trim().isEmpty
          ? null
          : _phoneController.text.trim(),
      location: _selectedLocation,
      avatarUrl: avatarUrl,
    );

    final result = await repo.updateProfile(updatedProfile);

    if (!mounted) return;

    setState(() => _isLoading = false);

    result.fold(
      (error) => context.showSnackBar(error.message, isError: true),
      (_) {
        ref.invalidate(userProfileProvider);
        context.showSnackBar('Profile updated successfully');
        context.pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(userProfileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: profileAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Text('Failed to load profile: $error'),
        ),
        data: (profile) {
          _initFromProfile(profile);

          return SingleChildScrollView(
            padding: AppSpacing.paddingLg,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Avatar picker
                  Center(
                    child: GestureDetector(
                      onTap: _pickAvatar,
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 52,
                            backgroundColor:
                                context.colorScheme.primaryContainer,
                            backgroundImage: _avatarImage(),
                            child: _avatarImage() == null
                                ? Icon(
                                    Icons.person,
                                    size: 52,
                                    color: context
                                        .colorScheme.onPrimaryContainer,
                                  )
                                : null,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(AppSpacing.xs),
                              decoration: BoxDecoration(
                                color: context.colorScheme.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                size: 20,
                                color: context.colorScheme.onPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  AppSpacing.verticalXl,

                  // Full name
                  TextFormField(
                    controller: _fullNameController,
                    decoration: const InputDecoration(
                      labelText: 'Full Name',
                      hintText: 'Enter your full name',
                      prefixIcon: Icon(Icons.person_outlined),
                    ),
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    validator: (value) =>
                        Validators.required(value, 'Full name'),
                  ),
                  AppSpacing.verticalMd,

                  // Phone
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Phone',
                      hintText: '${AppConstants.phonePrefix} XX XXX XXX',
                      prefixIcon: Icon(Icons.phone_outlined),
                    ),
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return null; // Phone is optional
                      }
                      return Validators.phone(value);
                    },
                  ),
                  AppSpacing.verticalMd,

                  // Location (Tunisian governorates)
                  DropdownButtonFormField<String>(
                    value: _selectedLocation,
                    decoration: const InputDecoration(
                      labelText: 'Location',
                      hintText: 'Select your governorate',
                      prefixIcon: Icon(Icons.location_on_outlined),
                    ),
                    items: AppConstants.governorates
                        .map(
                          (g) => DropdownMenuItem(
                            value: g,
                            child: Text(g),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() => _selectedLocation = value);
                    },
                  ),
                  AppSpacing.verticalXl,

                  // Save button
                  ElevatedButton(
                    onPressed: _isLoading ? null : () => _save(profile),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : const Text('Save'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  ImageProvider? _avatarImage() {
    if (_pendingAvatarPath != null) {
      return FileImage(File(_pendingAvatarPath!));
    }
    if (_avatarUrl != null) {
      return CachedNetworkImageProvider(_avatarUrl!);
    }
    return null;
  }
}
