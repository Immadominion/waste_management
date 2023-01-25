import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReportDetail extends StatefulWidget {
  int index;
  ReportDetail({Key? key, required this.index}) : super(key: key);

  @override
  State<ReportDetail> createState() => _ReportDetailState();
}

class _ReportDetailState extends State<ReportDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Item ${widget.index}"),
      ),
      body: Container(

      ),
    );
  }
}

