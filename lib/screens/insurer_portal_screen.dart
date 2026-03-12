import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:file_picker/file_picker.dart';
import 'insurer_login_screen.dart';

class InsurerPortalScreen extends StatefulWidget {
  const InsurerPortalScreen({super.key});

  @override
  State<InsurerPortalScreen> createState() => _InsurerPortalScreenState();
}

class _InsurerPortalScreenState extends State<InsurerPortalScreen> {
  String? selectedDataType;
  String? fileName;
  final List<String> dataTypes = [
    'Life Insurance',
    'Health Insurance',
    'Motor Insurance',
  ];

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv', 'xlsx', 'xls'],
    );

    if (result != null) {
      setState(() {
        fileName = result.files.single.name;
      });
    }
  }

  void _clearFile() {
    setState(() {
      fileName = null;
    });
  }

  void _handleLogout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const InsurerLoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: TextButton.icon(
              onPressed: _handleLogout,
              icon: const Icon(Icons.logout, color: Color(0xFFED1C24)),
              label: const Text(
                'Logout',
                style: TextStyle(
                  color: Color(0xFFED1C24),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // HDFC Logo and Title
              Column(
                children: [
                   SvgPicture.asset(
                    'assets/images/hdfc-bank-logo.svg',
                    height: 60,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Insurer Portal',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 48),
              
              // Upload Card
              Container(
                width: 500,
                decoration: BoxDecoration(
                  color: const Color(0xFF0451B5), // Deep blue
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'Upload File',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    // Data Type Dropdown
                    const Text(
                      'Data Type',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedDataType,
                          hint: const Text('Choose Data Type'),
                          isExpanded: true,
                          items: dataTypes.map((String type) {
                            return DropdownMenuItem<String>(
                              value: type,
                              child: Text(type),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              selectedDataType = value;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // CSV File Upload
                    const Text(
                      'CSV File',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: _pickFile,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                fileName ?? 'Upload CSV or Excel File',
                                style: TextStyle(
                                  color: fileName == null ? Colors.grey[600] : Colors.black,
                                ),
                              ),
                            ),
                            if (fileName != null) ...[
                              const Icon(Icons.check_circle, color: Colors.green),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: _clearFile,
                                child: const Icon(Icons.delete, color: Colors.red),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    
                    // Submit Button
                    Center(
                      child: SizedBox(
                        width: 150,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: (selectedDataType != null && fileName != null)
                              ? () {
                                  // Handle submission
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('File submitted successfully!')),
                                  );
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: fileName != null
                                ? const Color(0xFFED1C24)
                                : Colors.white,
                            foregroundColor: fileName != null
                                ? Colors.white
                                : const Color(0xFFED1C24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            disabledBackgroundColor: fileName != null
                                ? const Color(0xFFED1C24).withValues(alpha: 0.6)
                                : Colors.white,
                            disabledForegroundColor: fileName != null
                                ? Colors.white.withValues(alpha: 0.6)
                                : const Color(0xFFED1C24).withValues(alpha: 0.6),
                          ),
                          child: const Text(
                            'Submit',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
