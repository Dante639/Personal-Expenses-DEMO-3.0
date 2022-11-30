import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double SpendingAmount;
  final double SpendingPcOfTotal;

  const ChartBar(this.label, this.SpendingAmount, this.SpendingPcOfTotal);

  @override
  Widget build(BuildContext context) {
    //print(label); crash test
    return LayoutBuilder(
      builder: (ctx, constraint) {
        return Column(
          children: [
            Container(
                height: constraint.maxHeight * 0.15,
                child: FittedBox(
                    child: Text(
                  '\$${SpendingAmount.toStringAsFixed(0)}',
                  style: TextStyle(color: Colors.black87),
                ))),
            SizedBox(
              height: constraint.maxHeight*0.05,
            ),
            Container(
              height: constraint.maxHeight * 0.6,
              width: 30,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.purple, width: 7.0),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.4),
                    ),
                  ),
                  FractionallySizedBox(
                      heightFactor: SpendingPcOfTotal,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(20.4),
                        ),
                      )),
                ],
              ),
            ),
              SizedBox(
              height: constraint.maxHeight*0.05,
            ),
            Container(height: constraint.maxHeight*0.15,
              child: FittedBox(
                child: Text(
                  label,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
