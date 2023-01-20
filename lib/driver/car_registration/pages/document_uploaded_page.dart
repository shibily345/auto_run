import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DocumentUploadedPage extends StatefulWidget {
  const DocumentUploadedPage({Key? key}) : super(key: key);

  @override
  State<DocumentUploadedPage> createState() => _DocumentUploadedPageState();
}

class _DocumentUploadedPageState extends State<DocumentUploadedPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Upload Picture',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).primaryColorDark),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          width: Get.width,
          height: Get.height * 0.1,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  offset: const Offset(10, 10),
                  color: Theme.of(context).splashColor,
                ),
                BoxShadow(
                  blurRadius: 10,
                  offset: const Offset(-10, -10),
                  color: Theme.of(context).shadowColor,
                ),
              ]),
          child: Row(
            children: [
              const Icon(
                Icons.cloud_upload,
                size: 40,
                color: Color(0xff7D7D7D),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Vehicle Registration',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColorDark),
                  ),
                  Text(
                    'waiting For Approval',
                    style: TextStyle(
                        fontSize: 12, color: Theme.of(context).indicatorColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
