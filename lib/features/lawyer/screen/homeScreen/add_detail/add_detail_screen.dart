import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import 'widgets/add_detail_form.dart';

class AddDetailScreen extends StatelessWidget {
  const AddDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: SAppBar(
       leadingIcon: Icons.arrow_back,
       title: Text('Add your Detail'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(SSizes.defaultSpaces),
          child: Column(
            children: [
              AddDetailForm(),
            ],
          ),
        ),
      ),
    );
  }
}