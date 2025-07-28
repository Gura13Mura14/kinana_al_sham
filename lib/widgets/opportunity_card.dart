import 'package:flutter/material.dart';
import '../models/opportunity_model.dart';
import 'package:intl/intl.dart';

class OpportunityCard extends StatelessWidget {
  final Opportunity opportunity;

  OpportunityCard({required this.opportunity});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat.yMMMMd('en_US'); // يمكنك تغييره لـ Arabic إذا أردت

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(opportunity.title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

            SizedBox(height: 8),

            Text(opportunity.description),

            SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("الموقع: ${opportunity.locationText}"),
                Text(opportunity.isRemote ? "عن بعد" : "حضوري"),
              ],
            ),

            SizedBox(height: 8),

            Row(
              children: [
                Text("من: ${dateFormat.format(opportunity.startDate)}"),
                SizedBox(width: 12),
                Text("إلى: ${dateFormat.format(opportunity.endDate)}"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
