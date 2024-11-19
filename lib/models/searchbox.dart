// import 'dart:ffi';

import 'package:flutter/material.dart';
// import 'package:hospital_management_system/models/api_functions.dart';
// import 'package:hospital_management_system/testing.dart';

class DropDownSearch extends StatefulWidget {
  const DropDownSearch({
    super.key,
    required this.title,
    required this.textController,
    required this.items,
  });
  final String title;
  final TextEditingController? textController;
  final List<String>? items;

  @override
  State<DropDownSearch> createState() => _DropDownSearchState();
}

class _DropDownSearchState extends State<DropDownSearch> {
  bool _isTapped = false;
  List<String> _filteredList = [];
  List<String> _subFilteredList = [];
  var decide;

  @override
  @override
  initState() {
    _filteredList = widget.items!;
    _subFilteredList = _filteredList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Container(
              // height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  TextFormField(
                    onTapOutside: (event) {
                      // setState(() {
                      //   _isTapped = false;
                      // });
                      FocusScope.of(context).unfocus();
                      FocusScope.of(context).nextFocus();
                    },
                    controller: widget.textController,
                    onChanged: (val) {
                      setState(() {
                        _filteredList = _subFilteredList
                            .where((element) => element.toLowerCase().contains(
                                widget.textController!.text.toLowerCase()))
                            .toList();
                      });
                    },
                    validator: (val) =>
                        val!.isEmpty ? 'Field can\'t empty' : null,
                    style: const TextStyle(color: Colors.black, fontSize: 16.0),
                    onTap: () => setState(() => _isTapped = !_isTapped),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      errorStyle: const TextStyle(fontSize: 0.01),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          style: BorderStyle.solid,
                        ),
                      ),
                      contentPadding:
                          const EdgeInsets.only(bottom: 10, left: 10),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Colors.black.withOpacity(0.7),
                              width: 0.8)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Colors.black.withOpacity(0.7),
                              width: 0.8)),
                      labelStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: Colors.black.withOpacity(0.7), width: 0.8),
                      ),
                      suffixIcon: const Icon(Icons.arrow_drop_down, size: 25),
                      isDense: true,
                    ),
                  ),
                  _isTapped && _filteredList.isNotEmpty
                      ? Container(
                          height: 150.0,
                          color: Colors.grey.shade200,
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ListView.builder(
                            itemCount: _filteredList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  setState(() => _isTapped = !_isTapped);
                                  widget.textController!.text =
                                      _filteredList[index];
                                  setState(() {});
                                  decide = _filteredList[index];
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(_filteredList[index],
                                      style: const TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 17.0)),
                                ),
                              );
                            },
                          ),
                        )
                      : const SizedBox.shrink(),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: ElevatedButton(
                  //       style: ElevatedButton.styleFrom(
                  //           backgroundColor: Color.fromARGB(213, 113, 1, 1)),
                  //       child: Text(
                  //         widget.title,
                  //         style: const TextStyle(
                  //             fontSize: 22,
                  //             color: Color.fromARGB(255, 255, 255, 255),
                  //             fontWeight: FontWeight.w600),
                  //       ),
                  //       onPressed: () {
                  //         _isTapped = false;
                  //         if (decide != null) {
                  //           Navigator.of(context).push(
                  //             MaterialPageRoute(
                  //                 builder: (_) => Testing(varied: decide)),
                  //           );
                  //           //widget.textController!.dispose();
                  //         } else {
                  //           showMessageBox(
                  //             context,
                  //             message: 'Please select a catogory',
                  //           );
                  //         }
                  //       }),
                  //    ),
                ],
              ))
        ]);
  }
}
