import 'dart:ui';

import 'package:dream_carz/core/colors.dart';
import 'package:dream_carz/core/constants.dart';
import 'package:dream_carz/core/responsiveutils.dart';
import 'package:dream_carz/presentation/screens/screen_mydocuments/widgets/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Document {
  final String id;
  final String name;
  final String type;
  final String uploadDate;
  final DocumentStatus status;
  final String? imagePath; // For uploaded documents
  final IconData icon;

  Document({
    required this.id,
    required this.name,
    required this.type,
    required this.uploadDate,
    required this.status,
    this.imagePath,
    required this.icon,
  });
}

enum DocumentStatus { verified, pending, rejected, notUploaded }

class MyDocumentsPage extends StatefulWidget {
  const MyDocumentsPage({super.key});

  @override
  State<MyDocumentsPage> createState() => _MyDocumentsPageState();
}

class _MyDocumentsPageState extends State<MyDocumentsPage> {
  final ImagePicker _picker = ImagePicker();

  // Hardcoded document data
  List<Document> documents = [
    Document(
      id: "DOC001",
      name: "Driving License",
      type: "Identity Document",
      uploadDate: "Dec 15, 2024",
      status: DocumentStatus.verified,
      icon: Icons.credit_card,
    ),
    Document(
      id: "DOC002",
      name: "Aadhaar Card",
      type: "Identity Document",
      uploadDate: "Dec 10, 2024",
      status: DocumentStatus.pending,
      icon: Icons.badge,
    ),
    Document(
      id: "DOC003",
      name: "PAN Card",
      type: "Tax Document",
      uploadDate: "Nov 28, 2024",
      status: DocumentStatus.verified,
      icon: Icons.account_balance_wallet,
    ),
  ];

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
          text: 'My Documents',
          color: const Color(0xFF1A365D),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
        itemCount: documents.length,
        itemBuilder: (context, index) {
          return DocumentCard(
            document: documents[index],
            onUpload: () =>
                _showImagePickerBottomSheet(context, documents[index]),
            onView: () => _viewDocument(documents[index]),
          );
        },
      ),
    );
  }

  void _showImagePickerBottomSheet(BuildContext context, Document document) {
    CustomImagePicker.show(
      context: context,
      title: 'Upload ${document.name}',
      onImageSelected: (XFile? image) {
        if (image != null) {
          _handleImageUpload(document, image);
        }
      },
    );
  }

  void _handleImageUpload(Document document, XFile image) {
    // Here you would typically upload to your server
    // For now, just update the UI
    setState(() {
      int index = documents.indexWhere((doc) => doc.id == document.id);
      if (index != -1) {
        documents[index] = Document(
          id: document.id,
          name: document.name,
          type: document.type,
          uploadDate: "Just now",
          status: DocumentStatus.pending,
          imagePath: image.path,
          icon: document.icon,
        );
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: ResponsiveText(
          '${document.name} uploaded successfully!',
          sizeFactor: 0.9,
          color: Appcolors.kwhitecolor,
        ),
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusStyles.kradius10(),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _viewDocument(Document document) {
    // Handle view document action
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: ResponsiveText(
          'Viewing ${document.name}',
          sizeFactor: 0.9,
          color: Appcolors.kwhitecolor,
        ),
        backgroundColor: Appcolors.kprimarycolor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusStyles.kradius10(),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class DocumentCard extends StatelessWidget {
  final Document document;
  final VoidCallback onUpload;
  final VoidCallback onView;

  const DocumentCard({
    super.key,
    required this.document,
    required this.onUpload,
    required this.onView,
  });

  Color getStatusColor(DocumentStatus status) {
    switch (status) {
      case DocumentStatus.verified:
        return Colors.green;
      case DocumentStatus.pending:
        return Colors.orange;
      case DocumentStatus.rejected:
        return Colors.red;
      case DocumentStatus.notUploaded:
        return Colors.grey;
    }
  }

  String getStatusText(DocumentStatus status) {
    switch (status) {
      case DocumentStatus.verified:
        return 'Verified';
      case DocumentStatus.pending:
        return 'Pending';
      case DocumentStatus.rejected:
        return 'Rejected';
      case DocumentStatus.notUploaded:
        return 'Not Uploaded';
    }
  }

  IconData getStatusIcon(DocumentStatus status) {
    switch (status) {
      case DocumentStatus.verified:
        return Icons.verified;
      case DocumentStatus.pending:
        return Icons.pending;
      case DocumentStatus.rejected:
        return Icons.cancel;
      case DocumentStatus.notUploaded:
        return Icons.upload_file;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: ResponsiveUtils.hp(2)),
      decoration: BoxDecoration(
        color: Appcolors.kwhitecolor,
        borderRadius: BorderRadiusStyles.kradius15(),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
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
            // Header with document info and status
            Row(
              children: [
                // Document icon
                Container(
                  width: ResponsiveUtils.wp(12),
                  height: ResponsiveUtils.wp(12),
                  decoration: BoxDecoration(
                    color: Appcolors.kprimarycolor.withOpacity(0.1),
                    borderRadius: BorderRadiusStyles.kradius10(),
                  ),
                  child: Icon(
                    document.icon,
                    size: ResponsiveUtils.sp(6),
                    color: Appcolors.kprimarycolor,
                  ),
                ),

                ResponsiveSizedBox.width10,

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ResponsiveText(
                        document.name,
                        sizeFactor: 1.1,
                        weight: FontWeight.bold,
                        color: Appcolors.kblackcolor,
                      ),
                      ResponsiveSizedBox.height5,
                      ResponsiveText(
                        document.type,
                        sizeFactor: 0.8,
                        weight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                      if (document.uploadDate.isNotEmpty) ...[
                        ResponsiveSizedBox.height5,
                        ResponsiveText(
                          'Uploaded: ${document.uploadDate}',
                          sizeFactor: 0.75,
                          color: Colors.grey[500],
                        ),
                      ],
                    ],
                  ),
                ),

                // Status badge
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveUtils.wp(3),
                    vertical: ResponsiveUtils.hp(0.8),
                  ),
                  decoration: BoxDecoration(
                    color: getStatusColor(document.status).withOpacity(0.1),
                    borderRadius: BorderRadiusStyles.kradius20(),
                    border: Border.all(
                      color: getStatusColor(document.status),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        getStatusIcon(document.status),
                        size: ResponsiveUtils.sp(3.5),
                        color: getStatusColor(document.status),
                      ),
                      ResponsiveSizedBox.width5,
                      ResponsiveText(
                        getStatusText(document.status),
                        sizeFactor: 0.75,
                        weight: FontWeight.w600,
                        color: getStatusColor(document.status),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            ResponsiveSizedBox.height20,

            // Action buttons
            Row(
              children: [
                // Upload/Re-upload button
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onUpload,
                    icon: Icon(
                      document.status == DocumentStatus.notUploaded
                          ? Icons.upload_file
                          : Icons.refresh,
                      size: ResponsiveUtils.sp(4),
                      color: Appcolors.kwhitecolor,
                    ),
                    label: ResponsiveText(
                      document.status == DocumentStatus.notUploaded
                          ? 'Upload'
                          : 'Re-upload',
                      sizeFactor: 0.9,
                      weight: FontWeight.w600,
                      color: Appcolors.kwhitecolor,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Appcolors.kprimarycolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusStyles.kradius10(),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: ResponsiveUtils.hp(1.5),
                      ),
                    ),
                  ),
                ),

                if (document.status != DocumentStatus.notUploaded) ...[
                  ResponsiveSizedBox.width10,
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: onView,
                      icon: Icon(
                        Icons.visibility,
                        size: ResponsiveUtils.sp(4),
                        color: Appcolors.kprimarycolor,
                      ),
                      label: ResponsiveText(
                        'View',
                        sizeFactor: 0.9,
                        weight: FontWeight.w600,
                        color: Appcolors.kprimarycolor,
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Appcolors.kprimarycolor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusStyles.kradius10(),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: ResponsiveUtils.hp(1.5),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),

            // Show rejection reason if document is rejected
            if (document.status == DocumentStatus.rejected) ...[
              ResponsiveSizedBox.height15,
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(ResponsiveUtils.wp(3)),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadiusStyles.kradius10(),
                  border: Border.all(
                    color: Colors.red.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: ResponsiveUtils.sp(4),
                      color: Colors.red,
                    ),
                    ResponsiveSizedBox.width10,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ResponsiveText(
                            'Rejection Reason:',
                            sizeFactor: 0.85,
                            weight: FontWeight.w600,
                            color: Colors.red,
                          ),
                          ResponsiveSizedBox.height5,
                          ResponsiveText(
                            'Document image is not clear. Please upload a clearer image.',
                            sizeFactor: 0.8,
                            color: Colors.red[700],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
