import 'package:bagani/config/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';

class ProfileView extends ConsumerStatefulWidget {
  final int profileId;

  ProfileView({super.key, required this.profileId});

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _addressController = TextEditingController();
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      ref
          .read(profileViewModelProvider.notifier)
          .fetchProfile(widget.profileId);
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _submitProfile() {
    if (_formKey.currentState!.validate()) {
      ref.read(profileViewModelProvider.notifier).updateProfile(
            widget.profileId,
            _nameController.text,
            _emailController.text,
            _addressController.text,
          );
      _toggleEditMode();
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileViewModelProvider);

    return profileState.when(
      data: (profile) {
        _nameController.text = profile.name;
        _emailController.text = profile.email;
        _mobileController.text = profile.mobile;
        _addressController.text = profile.address;

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50), // Space from the top
                  Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              NetworkImage(profile.profilePictureUrl),
                        ),
                        Positioned(
                          right: -10,
                          bottom: -10,
                          child: IconButton(
                            icon: Icon(
                              _isEditing ? Icons.check : Icons.edit,
                              color: Colors.blue,
                            ),
                            onPressed:
                                _isEditing ? _submitProfile : _toggleEditMode,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: _isEditing
                        ? TextFormField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              labelText: 'Name',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          )
                        : Text(
                            profile.name,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: _isEditing
                        ? TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  !value.contains('@')) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                          )
                        : Text(
                            profile.email,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: Colors.grey[600]),
                          ),
                  ),
                  const SizedBox(height: 30),
                  const Divider(),
                  if (!_isEditing)
                    _buildProfileDetail(
                        context, 'Mobile', _mobileController, _isEditing),
                  Divider(),
                  _buildProfileDetail(
                      context, 'Address', _addressController, _isEditing),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.logout, color: Colors.red),
                    title: Text(
                      'Logout',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      // Call logout functionality here
                      ref.read(profileViewModelProvider.notifier).logout();
                      context.go('/auth');
                    },
                  ),
                  const Divider(),
                ],
              ),
            ),
          ),
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('An error occurred')),
    );
  }

  Widget _buildProfileDetail(
    BuildContext context,
    String title,
    TextEditingController controller,
    bool isEditing,
  ) {
    return ListTile(
      title: Text(title),
      subtitle: isEditing
          ? TextFormField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            )
          : Text(controller.text),
    );
  }
}
