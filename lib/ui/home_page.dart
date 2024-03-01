import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<RowItem> rows = [];
  List<String> paymentOptions = ['Cash', 'Card', 'Online', 'Other'];

  @override
  void initState() {
    super.initState();
    // Initial row
    rows.add(RowItem(type: 'Cash', amount: 0));
  }

  Widget buildRow(RowItem rowItem) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField(
              value: rowItem.type,
              items: paymentOptions.map((String option) {
                return DropdownMenuItem(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  rowItem.type = value.toString();
                });
              },
              decoration: InputDecoration(
                labelText: 'Payment Type',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(labelText: 'Amount', hintText: "Enter the amount",
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                rowItem.amount = int.tryParse(value) ?? 0;
              },
            ),
          ),
        ),

        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            setState(() {
              rows.remove(rowItem);
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    int totalAmount = rows.fold(0, (sum, item) => sum + item.amount);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 25,right: 25,top: 40),
          child: Column(
            children: [
              for (var rowItem in rows) buildRow(rowItem),
              SizedBox(height: 20),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        rows.add(RowItem(type: '', amount: 0));
                      });
                    },
                    child: Row(
                      children: [
                        Icon(Icons.add),
                        Text(
                          "Add ",
                          style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width:60,),
                  Text(
                    'Total Amount: $totalAmount',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RowItem {
  String type;
  int amount;

  RowItem({required this.type, required this.amount});
}