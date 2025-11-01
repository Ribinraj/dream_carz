import 'package:dream_carz/core/colors.dart';
import 'package:dream_carz/core/constants.dart';
import 'package:dream_carz/core/responsiveutils.dart';
import 'package:dream_carz/presentation/blocs/delete_account_bloc/delete_account_bloc.dart';

import 'package:dream_carz/widgets/custom_snackbar.dart';
import 'package:dream_carz/widgets/logout_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



class DeleteAccountPage extends StatefulWidget {
  final String username;
  final String mobilenumber;
  const DeleteAccountPage({
    super.key,
    required this.username,
    required this.mobilenumber,
  });

  @override
  State<DeleteAccountPage> createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _reasonController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController.text = widget.username;
    _numberController.text = widget.mobilenumber;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  Future<bool> _showDeleteConfirmation() async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.orange,
                    size: 28,
                  ),
                  SizedBox(width: 12),
                  Text('Confirm Deletion'),
                ],
              ),
              content: const Text(
                'Are you sure you want to delete your account? This action cannot be undone.',
                style: TextStyle(fontSize: 16),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ),
                ElevatedButton(
                         onPressed: () {
                    context.read<DeleteAccountBloc>().add(
                      DeleteButtonClickEvent(reason: _reasonController.text),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade600,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Delete'),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
     String? Function(String?)? validator,
    TextInputType? keyboardType,
    int maxLines = 1,
    IconData? prefixIcon,
    bool enabled = true,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        enabled: enabled,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: Colors.grey.shade600)
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Appcolors.ksecondarycolor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
          filled: true,
          fillColor: enabled ? Colors.grey.shade50 : Colors.grey.shade100,
          labelStyle: TextStyle(color: Colors.grey.shade700),
          alignLabelWithHint: maxLines > 1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Appcolors.kbackgroundcolor,
       appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.chevron_left,
            size: ResponsiveUtils.wp(8),
            color: Colors.black,
          ),
        ),
        title: TextStyles.subheadline(
          text: 'Delete Account',
          color: const Color(0xFF1A365D),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
                  ResponsiveSizedBox.height20,
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Occupant Name (disabled/readonly)
                      _buildTextField(
                        controller: _nameController,
                        label: "Occupant Name",
                        prefixIcon: Icons.person_outline,
                        enabled: false, // Make it readonly
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return "Please enter occupant name";
                        //   }
                        //   return null;
                        // },
                      ),
                          ResponsiveSizedBox.height20,

                      // Occupant Number (disabled/readonly)
                      _buildTextField(
                        controller: _numberController,
                        label: "Mobile Number",
                        prefixIcon: Icons.phone_outlined,
                        keyboardType: TextInputType.number,
                        enabled: false, // Make it readonly
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return "Please enter mobile number";
                        //   }
                        //   return null;
                        // },
                      ),
                      ResponsiveSizedBox.height20,

                      // Reason
                      _buildTextField(
                        controller: _reasonController,
                        label: "Reason for Account Deletion",
                        prefixIcon: Icons.edit_note_outlined,
                        maxLines: 4,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please provide a reason";
                          }
                          return null;
                        },
                      ),
                      ResponsiveSizedBox.height30,

                      // Warning Message
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.orange.shade200),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Colors.orange.shade700,
                            ),
                            ResponsiveSizedBox.height10,
                            Expanded(
                              child: Text(
                                "This action is irreversible. All your data will be permanently deleted after verification",
                                style: TextStyle(
                                  color: Colors.orange.shade700,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ResponsiveSizedBox.height20,

                      // Delete Account Button
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child:       BlocConsumer<
                                    DeleteAccountBloc,
                                    DeleteAccountState
                                  >(
                                    listener: (context, state) {
                                      if (state is DeleteAccountSuccessState) {
                                        CustomSnackbar.show(
                                          context,
                                          message: state.message,
                                          type: SnackbarType.success,
                                        );
                                        AuthUtils.handleLogout(context); 
                                      } else if (state
                                          is DeleteAccountErrorState) {
                                        CustomSnackbar.show(
                                          context,
                                          message: state.message,
                                          type: SnackbarType.error,
                                        );
                                      }
                                    },
                                    builder: (context, state) {
                                      if (state is DeleteAccountLoadingState) {
                                        return ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Colors.red.shade600,
                                            foregroundColor: Colors.white,
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 12,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            elevation: 0,
                                          ),
                                          child: SpinKitWave(
                                            size: 15,
                                            color: Appcolors.kwhitecolor,
                                          ),
                                        );
                                      }
                                      return ElevatedButton(
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            _showDeleteConfirmation();
                                          } else {
                                            CustomSnackbar.show(
                                              context,
                                              message: 'Fill required fields',
                                              type: SnackbarType.error,
                                            );
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red.shade600,
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 12,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          elevation: 0,
                                        ),
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.delete_forever,
                                              size: 20,
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              "Delete Account",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
