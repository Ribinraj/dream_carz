// import 'dart:convert';
// import 'dart:io';
// import 'dart:ui';

// import 'package:dream_carz/core/colors.dart';
// import 'package:dream_carz/core/constants.dart';
// import 'package:dream_carz/core/responsiveutils.dart';
// import 'package:dream_carz/data/documentlist_model.dart';
// import 'package:dream_carz/data/upload_documentmodel.dart';
// import 'package:dream_carz/presentation/blocs/fetch_documentlists_bloc/fetch_document_lists_bloc.dart';
// import 'package:dream_carz/presentation/blocs/upload_document_bloc/upload_document_bloc.dart';
// import 'package:dream_carz/presentation/screens/screen_bookingconfirmation/screen_bookingconfirmationpage.dart';
// import 'package:dream_carz/presentation/screens/screen_mydocuments/widgets/image_picker.dart';
// import 'package:dream_carz/widgets/custom_navigation.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';

// class DocumentUploadItem {
//   final DocumentlistModel document;
//   XFile? selectedFile;
//   bool isUploaded;

//   DocumentUploadItem({
//     required this.document,
//     this.selectedFile,
//     this.isUploaded = false,
//   });
// }

// class MyDocumentsPage extends StatefulWidget {
//   final String bookingId;

//   const MyDocumentsPage({super.key, required this.bookingId});

//   @override
//   State<MyDocumentsPage> createState() => _MyDocumentsPageState();
// }

// class _MyDocumentsPageState extends State<MyDocumentsPage> {
//   final ImagePicker _picker = ImagePicker();
//   List<DocumentUploadItem> documentItems = [];

//   @override
//   void initState() {
//     super.initState();
//     // Fetch document list on page load
//     context.read<FetchDocumentListsBloc>().add(
//       FetchDocmentsButtonClickEvent(bookingId: widget.bookingId),
//     );
//   }

//   Future<String> _convertImageToBase64(String filePath) async {
//     final bytes = await File(filePath).readAsBytes();
//     return base64Encode(bytes);
//   }

//   bool _validateMandatoryDocuments() {
//     for (var item in documentItems) {
//       if (item.document.mandatory == "1" && item.selectedFile == null) {
//         return false;
//       }
//     }
//     return true;
//   }

//   Future<void> _submitDocuments() async {
//     if (!_validateMandatoryDocuments()) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: ResponsiveText(
//             'Please upload all mandatory documents',
//             sizeFactor: 0.9,
//             color: Appcolors.kwhitecolor,
//           ),
//           backgroundColor: Colors.red,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadiusStyles.kradius10(),
//           ),
//           behavior: SnackBarBehavior.floating,
//         ),
//       );
//       return;
//     }

//     // Prepare documents for upload
//     List<DocumentFile> documentsToUpload = [];

//     for (var item in documentItems) {
//       if (item.selectedFile != null) {
//         final base64String = await _convertImageToBase64(
//           item.selectedFile!.path,
//         );
//         documentsToUpload.add(
//           DocumentFile(
//             documentId: int.tryParse(item.document.documentId ?? '0'),
//             fileName: item.selectedFile!.name,
//             fileBase64: base64String,
//           ),
//         );
//       }
//     }

//     if (documentsToUpload.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: ResponsiveText(
//             'Please select at least one document to upload',
//             sizeFactor: 0.9,
//             color: Appcolors.kwhitecolor,
//           ),
//           backgroundColor: Colors.orange,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadiusStyles.kradius10(),
//           ),
//           behavior: SnackBarBehavior.floating,
//         ),
//       );
//       return;
//     }

//     // Trigger upload
//     context.read<UploadDocumentBloc>().add(
//       UploadDocumentButtonClickEvent(
//         documents: UploadDocumentmodel(
//           bookingId: int.tryParse(widget.bookingId),
//           documents: documentsToUpload,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Appcolors.kbackgroundcolor,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: Icon(
//             Icons.chevron_left,
//             size: ResponsiveUtils.wp(8),
//             color: Colors.black,
//           ),
//         ),
//         title: TextStyles.subheadline(
//           text: 'Upload Documents',
//           color: const Color(0xFF1A365D),
//         ),
//         centerTitle: true,
//       ),
//       body: MultiBlocListener(
//         listeners: [
//           BlocListener<FetchDocumentListsBloc, FetchDocumentListsState>(
//             listener: (context, state) {
//               if (state is FetchDocumentsSuccessState) {
//                 setState(() {
//                   documentItems = state.documents
//                       .map((doc) => DocumentUploadItem(document: doc))
//                       .toList();
//                 });
//               } else if (state is FetchDocumentsErrorState) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: ResponsiveText(
//                       state.message,
//                       sizeFactor: 0.9,
//                       color: Appcolors.kwhitecolor,
//                     ),
//                     backgroundColor: Colors.red,
//                   ),
//                 );
//               }
//             },
//           ),
//           BlocListener<UploadDocumentBloc, UploadDocumentState>(
//             listener: (context, state) {
//               if (state is UploadDocumentSuccessState) {
//                 CustomNavigation.pushReplaceWithTransition(
//                   context,
//                   OrderConfirmedPage(),
//                 );
//                 // ScaffoldMessenger.of(context).showSnackBar(
//                 //   SnackBar(
//                 //     content: ResponsiveText(
//                 //       state.message,
//                 //       sizeFactor: 0.9,
//                 //       color: Appcolors.kwhitecolor,
//                 //     ),
//                 //     backgroundColor: Colors.green,
//                 //     shape: RoundedRectangleBorder(
//                 //       borderRadius: BorderRadiusStyles.kradius10(),
//                 //     ),
//                 //     behavior: SnackBarBehavior.floating,
//                 //   ),
//                 // );
//                 // // Mark all as uploaded
//                 // setState(() {
//                 //   for (var item in documentItems) {
//                 //     if (item.selectedFile != null) {
//                 //       item.isUploaded = true;
//                 //     }
//                 //   }
//                 // });
//               } else if (state is UploadDocumentErrorState) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: ResponsiveText(
//                       state.message,
//                       sizeFactor: 0.9,
//                       color: Appcolors.kwhitecolor,
//                     ),
//                     backgroundColor: Colors.red,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadiusStyles.kradius10(),
//                     ),
//                     behavior: SnackBarBehavior.floating,
//                   ),
//                 );
//               }
//             },
//           ),
//         ],
//         child: BlocBuilder<FetchDocumentListsBloc, FetchDocumentListsState>(
//           builder: (context, state) {
//             if (state is FetchDocumentsLoadingState) {
//               return Center(
//                 child: CircularProgressIndicator(
//                   color: Appcolors.kprimarycolor,
//                 ),
//               );
//             }

//             if (documentItems.isEmpty) {
//               return Center(
//                 child: ResponsiveText(
//                   'No documents to upload',
//                   sizeFactor: 1.0,
//                   color: Colors.grey,
//                 ),
//               );
//             }

//             return Column(
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                     padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
//                     itemCount: documentItems.length,
//                     itemBuilder: (context, index) {
//                       return DocumentUploadCard(
//                         documentItem: documentItems[index],
//                         onImageSelected: (image) {
//                           setState(() {
//                             documentItems[index].selectedFile = image;
//                             documentItems[index].isUploaded = false;
//                           });
//                         },
//                         onRemove: () {
//                           setState(() {
//                             documentItems[index].selectedFile = null;
//                             documentItems[index].isUploaded = false;
//                           });
//                         },
//                       );
//                     },
//                   ),
//                 ),
//                 // Submit button
//                 Container(
//                   padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.2),
//                         spreadRadius: 1,
//                         blurRadius: 10,
//                         offset: const Offset(0, -2),
//                       ),
//                     ],
//                   ),
//                   child: BlocBuilder<UploadDocumentBloc, UploadDocumentState>(
//                     builder: (context, uploadState) {
//                       return SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: uploadState is UploadDocumentLoadingState
//                               ? null
//                               : _submitDocuments,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Appcolors.kprimarycolor,
//                             disabledBackgroundColor: Appcolors.kprimarycolor
//                                 .withOpacity(0.6),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadiusStyles.kradius10(),
//                             ),
//                             padding: EdgeInsets.symmetric(
//                               vertical: ResponsiveUtils.hp(2),
//                             ),
//                           ),
//                           child: uploadState is UploadDocumentLoadingState
//                               ? SizedBox(
//                                   height: ResponsiveUtils.sp(5),
//                                   width: ResponsiveUtils.sp(5),
//                                   child: CircularProgressIndicator(
//                                     color: Appcolors.kwhitecolor,
//                                     strokeWidth: 2,
//                                   ),
//                                 )
//                               : ResponsiveText(
//                                   'Submit Documents',
//                                   sizeFactor: 1.0,
//                                   weight: FontWeight.bold,
//                                   color: Appcolors.kwhitecolor,
//                                 ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class DocumentUploadCard extends StatelessWidget {
//   final DocumentUploadItem documentItem;
//   final Function(XFile) onImageSelected;
//   final VoidCallback onRemove;

//   const DocumentUploadCard({
//     super.key,
//     required this.documentItem,
//     required this.onImageSelected,
//     required this.onRemove,
//   });

//   IconData _getDocumentIcon(String? documentName) {
//     final name = documentName?.toLowerCase() ?? '';
//     if (name.contains('aadhar') || name.contains('aadhaar')) {
//       return Icons.badge;
//     } else if (name.contains('license') || name.contains('driving')) {
//       return Icons.credit_card;
//     } else if (name.contains('pan')) {
//       return Icons.account_balance_wallet;
//     } else if (name.contains('address') || name.contains('proof')) {
//       return Icons.home;
//     }
//     return Icons.description;
//   }

//   void _showImagePicker(BuildContext context) {
//     CustomImagePicker.show(
//       context: context,
//       title: 'Upload ${documentItem.document.documentName}',
//       onImageSelected: (XFile? image) {
//         if (image != null) {
//           onImageSelected(image);
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: ResponsiveText(
//                 'Image selected successfully!',
//                 sizeFactor: 0.9,
//                 color: Appcolors.kwhitecolor,
//               ),
//               backgroundColor: Colors.green,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadiusStyles.kradius10(),
//               ),
//               behavior: SnackBarBehavior.floating,
//               duration: const Duration(seconds: 2),
//             ),
//           );
//         }
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isMandatory = documentItem.document.mandatory == "1";
//     final hasImage = documentItem.selectedFile != null;

//     return Container(
//       margin: EdgeInsets.only(bottom: ResponsiveUtils.hp(2)),
//       decoration: BoxDecoration(
//         color: Appcolors.kwhitecolor,
//         borderRadius: BorderRadiusStyles.kradius15(),
//         border: isMandatory && !hasImage
//             ? Border.all(color: Colors.orange.withOpacity(0.5), width: 1.5)
//             : null,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 10,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Container(
//                   width: ResponsiveUtils.wp(12),
//                   height: ResponsiveUtils.wp(12),
//                   decoration: BoxDecoration(
//                     color: Appcolors.kprimarycolor.withOpacity(0.1),
//                     borderRadius: BorderRadiusStyles.kradius10(),
//                   ),
//                   child: Icon(
//                     _getDocumentIcon(documentItem.document.documentName),
//                     size: ResponsiveUtils.sp(6),
//                     color: Appcolors.kprimarycolor,
//                   ),
//                 ),
//                 ResponsiveSizedBox.width10,
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ResponsiveText(
//                         documentItem.document.documentName ?? 'Document',
//                         sizeFactor: 1.0,
//                         weight: FontWeight.bold,
//                         color: Appcolors.kblackcolor,
//                       ),
//                       ResponsiveSizedBox.height5,
//                       Container(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: ResponsiveUtils.wp(2),
//                           vertical: ResponsiveUtils.hp(0.5),
//                         ),
//                         decoration: BoxDecoration(
//                           color: isMandatory
//                               ? Colors.orange.withOpacity(0.1)
//                               : Colors.grey.withOpacity(0.1),
//                           borderRadius: BorderRadiusStyles.kradius5(),
//                         ),
//                         child: ResponsiveText(
//                           isMandatory ? 'Mandatory' : 'Optional',
//                           sizeFactor: 0.7,
//                           weight: FontWeight.w600,
//                           color: isMandatory ? Colors.orange : Colors.grey,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 if (documentItem.isUploaded)
//                   Container(
//                     padding: EdgeInsets.all(ResponsiveUtils.wp(2)),
//                     decoration: BoxDecoration(
//                       color: Colors.green.withOpacity(0.1),
//                       shape: BoxShape.circle,
//                     ),
//                     child: Icon(
//                       Icons.check_circle,
//                       color: Colors.green,
//                       size: ResponsiveUtils.sp(5),
//                     ),
//                   ),
//               ],
//             ),
//             if (hasImage) ...[
//               ResponsiveSizedBox.height15,
//               Container(
//                 height: ResponsiveUtils.hp(15),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadiusStyles.kradius10(),
//                   border: Border.all(color: Colors.grey.withOpacity(0.3)),
//                 ),
//                 child: Stack(
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadiusStyles.kradius10(),
//                       child: Image.file(
//                         File(documentItem.selectedFile!.path),
//                         width: double.infinity,
//                         height: double.infinity,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     Positioned(
//                       top: ResponsiveUtils.wp(2),
//                       right: ResponsiveUtils.wp(2),
//                       child: GestureDetector(
//                         onTap: onRemove,
//                         child: Container(
//                           padding: EdgeInsets.all(ResponsiveUtils.wp(1.5)),
//                           decoration: BoxDecoration(
//                             color: Colors.red,
//                             shape: BoxShape.circle,
//                           ),
//                           child: Icon(
//                             Icons.close,
//                             color: Colors.white,
//                             size: ResponsiveUtils.sp(4),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//             ResponsiveSizedBox.height15,
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton.icon(
//                 onPressed: () => _showImagePicker(context),
//                 icon: Icon(
//                   hasImage ? Icons.refresh : Icons.upload_file,
//                   size: ResponsiveUtils.sp(4.5),
//                   color: Appcolors.kwhitecolor,
//                 ),
//                 label: ResponsiveText(
//                   hasImage ? 'Change Image' : 'Select Image',
//                   sizeFactor: 0.9,
//                   weight: FontWeight.w600,
//                   color: Appcolors.kwhitecolor,
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Appcolors.kprimarycolor,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadiusStyles.kradius10(),
//                   ),
//                   padding: EdgeInsets.symmetric(
//                     vertical: ResponsiveUtils.hp(1.5),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//////////////////////////////////////////
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:dream_carz/core/colors.dart';
import 'package:dream_carz/core/constants.dart';
import 'package:dream_carz/core/responsiveutils.dart';
import 'package:dream_carz/data/documentlist_model.dart';
import 'package:dream_carz/data/upload_documentmodel.dart';
import 'package:dream_carz/presentation/blocs/fetch_documentlists_bloc/fetch_document_lists_bloc.dart';
import 'package:dream_carz/presentation/blocs/upload_document_bloc/upload_document_bloc.dart';
import 'package:dream_carz/presentation/screens/screen_bookingconfirmation/screen_bookingconfirmationpage.dart';
import 'package:dream_carz/presentation/screens/screen_mydocuments/widgets/image_picker.dart';
import 'package:dream_carz/widgets/custom_navigation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class DocumentUploadItem {
  final DocumentlistModel document;
  XFile? selectedFile;
  bool isUploaded;

  DocumentUploadItem({
    required this.document,
    this.selectedFile,
    this.isUploaded = false,
  });
}

class MyDocumentsPage extends StatefulWidget {
  final String bookingId;

  const MyDocumentsPage({super.key, required this.bookingId});

  @override
  State<MyDocumentsPage> createState() => _MyDocumentsPageState();
}

class _MyDocumentsPageState extends State<MyDocumentsPage> {
  final ImagePicker _picker = ImagePicker();
  List<DocumentUploadItem> documentItems = [];

  @override
  void initState() {
    super.initState();
    // Fetch document list on page load
    context.read<FetchDocumentListsBloc>().add(
      FetchDocmentsButtonClickEvent(bookingId: widget.bookingId),
    );
  }

  Future<String> _convertImageToBase64(String filePath) async {
    final bytes = await File(filePath).readAsBytes();
    return base64Encode(bytes);
  }

  bool _validateMandatoryDocuments() {
    for (var item in documentItems) {
      if (item.document.mandatory == "1" && item.selectedFile == null) {
        return false;
      }
    }
    return true;
  }

  Future<void> _submitDocuments() async {
    if (!_validateMandatoryDocuments()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: ResponsiveText(
            'Please upload all mandatory documents',
            sizeFactor: 0.9,
            color: Appcolors.kwhitecolor,
          ),
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusStyles.kradius10(),
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Prepare documents for upload
    List<DocumentFile> documentsToUpload = [];

    for (var item in documentItems) {
      if (item.selectedFile != null) {
        final base64String = await _convertImageToBase64(
          item.selectedFile!.path,
        );
        documentsToUpload.add(
          DocumentFile(
            documentId: int.tryParse(item.document.documentId ?? '0'),
            fileName: item.selectedFile!.name,
            fileBase64: base64String,
          ),
        );
      }
    }

    if (documentsToUpload.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: ResponsiveText(
            'Please select at least one document to upload',
            sizeFactor: 0.9,
            color: Appcolors.kwhitecolor,
          ),
          backgroundColor: Colors.orange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusStyles.kradius10(),
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Trigger upload
    context.read<UploadDocumentBloc>().add(
      UploadDocumentButtonClickEvent(
        documents: UploadDocumentmodel(
          bookingId: int.tryParse(widget.bookingId),
          documents: documentsToUpload,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.kbackgroundcolor,
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
          text: 'Upload Documents',
          color: const Color(0xFF1A365D),
        ),
        centerTitle: true,
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<FetchDocumentListsBloc, FetchDocumentListsState>(
            listener: (context, state) {
              if (state is FetchDocumentsSuccessState) {
                setState(() {
                  documentItems = state.documents
                      .map((doc) => DocumentUploadItem(document: doc))
                      .toList();
                });
              } else if (state is FetchDocumentsErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: ResponsiveText(
                      state.message,
                      sizeFactor: 0.9,
                      color: Appcolors.kwhitecolor,
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
          BlocListener<UploadDocumentBloc, UploadDocumentState>(
            listener: (context, state) {
              if (state is UploadDocumentSuccessState) {
                CustomNavigation.pushReplaceWithTransition(
                  context,
                  OrderConfirmedPage(),
                );
              } else if (state is UploadDocumentErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: ResponsiveText(
                      state.message,
                      sizeFactor: 0.9,
                      color: Appcolors.kwhitecolor,
                    ),
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusStyles.kradius10(),
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<FetchDocumentListsBloc, FetchDocumentListsState>(
          builder: (context, state) {
            if (state is FetchDocumentsLoadingState) {
              return Center(
                child: CircularProgressIndicator(
                  color: Appcolors.kprimarycolor,
                ),
              );
            }

            if (documentItems.isEmpty) {
              return Center(
                child: ResponsiveText(
                  'No documents to upload',
                  sizeFactor: 1.0,
                  color: Colors.grey,
                ),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
                    itemCount: documentItems.length,
                    itemBuilder: (context, index) {
                      return DocumentUploadCard(
                        documentItem: documentItems[index],
                        onImageSelected: (image) {
                          setState(() {
                            documentItems[index].selectedFile = image;
                            documentItems[index].isUploaded = false;
                          });
                        },
                        onRemove: () {
                          setState(() {
                            documentItems[index].selectedFile = null;
                            documentItems[index].isUploaded = false;
                          });
                        },
                      );
                    },
                  ),
                ),
                // Submit button
                Container(
                  padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: BlocBuilder<UploadDocumentBloc, UploadDocumentState>(
                    builder: (context, uploadState) {
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: uploadState is UploadDocumentLoadingState
                              ? null
                              : _submitDocuments,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Appcolors.kprimarycolor,
                            disabledBackgroundColor: Appcolors.kprimarycolor
                                .withOpacity(0.6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusStyles.kradius10(),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: ResponsiveUtils.hp(2),
                            ),
                          ),
                          child: uploadState is UploadDocumentLoadingState
                              ? SizedBox(
                                  height: ResponsiveUtils.sp(5),
                                  width: ResponsiveUtils.sp(5),
                                  child: CircularProgressIndicator(
                                    color: Appcolors.kwhitecolor,
                                    strokeWidth: 2,
                                  ),
                                )
                              : ResponsiveText(
                                  'Submit Documents',
                                  sizeFactor: 1.0,
                                  weight: FontWeight.bold,
                                  color: Appcolors.kwhitecolor,
                                ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class DocumentUploadCard extends StatelessWidget {
  final DocumentUploadItem documentItem;
  final Function(XFile) onImageSelected;
  final VoidCallback onRemove;

  const DocumentUploadCard({
    super.key,
    required this.documentItem,
    required this.onImageSelected,
    required this.onRemove,
  });

  IconData _getDocumentIcon(String? documentName) {
    final name = documentName?.toLowerCase() ?? '';
    if (name.contains('aadhar') || name.contains('aadhaar')) {
      return Icons.badge;
    } else if (name.contains('license') || name.contains('driving')) {
      return Icons.credit_card;
    } else if (name.contains('pan')) {
      return Icons.account_balance_wallet;
    } else if (name.contains('address') || name.contains('proof')) {
      return Icons.home;
    }
    return Icons.description;
  }

  Color _getIconColor(String? documentName) {
    final name = documentName?.toLowerCase() ?? '';
    if (name.contains('aadhar') || name.contains('aadhaar')) {
      return const Color(0xFF6366F1); // Indigo
    } else if (name.contains('license') || name.contains('driving')) {
      return const Color(0xFF10B981); // Emerald
    } else if (name.contains('pan')) {
      return const Color(0xFFF59E0B); // Amber
    } else if (name.contains('address') || name.contains('proof')) {
      return const Color(0xFF8B5CF6); // Purple
    }
    return const Color(0xFF3B82F6); // Blue
  }

  void _showImagePicker(BuildContext context) {
    CustomImagePicker.show(
      context: context,
      title: 'Upload ${documentItem.document.documentName}',
      onImageSelected: (XFile? image) {
        if (image != null) {
          onImageSelected(image);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: ResponsiveText(
                'Image selected successfully!',
                sizeFactor: 0.9,
                color: Appcolors.kwhitecolor,
              ),
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusStyles.kradius10(),
              ),
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMandatory = documentItem.document.mandatory == "1";
    final hasImage = documentItem.selectedFile != null;
    final iconColor = _getIconColor(documentItem.document.documentName);

    return Container(
      margin: EdgeInsets.only(bottom: ResponsiveUtils.hp(2)),
      decoration: BoxDecoration(
        color: Appcolors.kwhitecolor,
        borderRadius: BorderRadiusStyles.kradius15(),
        border: isMandatory && !hasImage
            ? Border.all(color: const Color(0xFFEF4444).withOpacity(0.3), width: 1.5)
            : Border.all(color: Colors.grey.withOpacity(0.1), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: ResponsiveUtils.wp(13),
                  height: ResponsiveUtils.wp(13),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        iconColor.withOpacity(0.1),
                        iconColor.withOpacity(0.05),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadiusStyles.kradius10(),
                  ),
                  child: Icon(
                    _getDocumentIcon(documentItem.document.documentName),
                    size: ResponsiveUtils.sp(6.5),
                    color: iconColor,
                  ),
                ),
                ResponsiveSizedBox.width10,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: ResponsiveText(
                              documentItem.document.documentName ?? 'Document',
                              sizeFactor: 1.0,
                              weight: FontWeight.w600,
                              color: const Color(0xFF1F2937),
                            ),
                          ),
                          if (isMandatory)
                            Icon(
                              Icons.star,
                              size: ResponsiveUtils.sp(3.5),
                              color: const Color(0xFFEF4444),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (documentItem.isUploaded)
                  Container(
                    padding: EdgeInsets.all(ResponsiveUtils.wp(1.5)),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check_circle_rounded,
                      color: const Color(0xFF10B981),
                      size: ResponsiveUtils.sp(5),
                    ),
                  ),
              ],
            ),
            if (hasImage) ...[
              ResponsiveSizedBox.height15,
              Container(
                height: ResponsiveUtils.hp(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusStyles.kradius10(),
                  border: Border.all(color: Colors.grey.withOpacity(0.2)),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadiusStyles.kradius10(),
                      child: Image.file(
                        File(documentItem.selectedFile!.path),
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: ResponsiveUtils.wp(2),
                      right: ResponsiveUtils.wp(2),
                      child: GestureDetector(
                        onTap: onRemove,
                        child: Container(
                          padding: EdgeInsets.all(ResponsiveUtils.wp(1.5)),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEF4444),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.close_rounded,
                            color: Colors.white,
                            size: ResponsiveUtils.sp(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            SizedBox(height: ResponsiveUtils.hp(1.5)),
            Row(
              children: [
                Spacer(),
                OutlinedButton.icon(
                  onPressed: () => _showImagePicker(context),
                  icon: Icon(
                    hasImage ? Icons.sync_rounded : Icons.upload_rounded,
                    size: ResponsiveUtils.sp(4),
                    color: hasImage ? iconColor : Appcolors.kprimarycolor,
                  ),
                  label: ResponsiveText(
                    hasImage ? 'Change' : 'Select Image',
                    sizeFactor: 0.7,
                    weight: FontWeight.w600,
                    color: hasImage ? iconColor : Appcolors.kprimarycolor,
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: hasImage 
                          ? iconColor.withOpacity(0.3) 
                          : Appcolors.kprimarycolor.withOpacity(0.3),
                      width: 1.5,
                    ),
                    backgroundColor: hasImage 
                        ? iconColor.withOpacity(0.05)
                        : Appcolors.kprimarycolor.withOpacity(0.05),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusStyles.kradius10(),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: ResponsiveUtils.hp(.5),horizontal: ResponsiveUtils.wp(2)
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}