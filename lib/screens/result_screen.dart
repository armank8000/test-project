import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {

  List<Map> marks = [
   {"Exam_type":"Final Exam",
    "Marks":[ {"maths":09},
    {"science":08},
    {"english":07},
    {"social sceince": 94},
    {"drawing":99}]}
  ];




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: Container(padding: EdgeInsets.all(8),child: SingleChildScrollView(
        child: Column(children: [

Text(

                'Techno International School',

                style: TextStyle(

                  fontSize: 20,

                  fontWeight: FontWeight.bold,

                ),

              ), SizedBox(height: 8),

              Text(

                'India',

                style: TextStyle(

                  fontSize: 18,

                ),

              ),

              SizedBox(height: 8),

              Text(

                '2023-24',

                style: TextStyle(

                  fontSize: 16,

                ),

              ),SizedBox(height: 16),

              _buildRow('Student Name', 'Sanskar Sharma'),

              _buildRow('Parent Name', 'Khushal Sharma'),

              _buildRow('Dob', '24/02/2006'),

              _buildRow('Exam Name', 'Yearly'),

              _buildRow('Class', '10 th'),

              _buildRow('Roll No', '61'),

              SizedBox(height: 16),

              _buildTable(),

              SizedBox(height: 16),

              _buildRow('Grade', 'A (84.5%)'),

              _buildRow('Attendance', '180'), _buildRow('Remarks', 'Excellent performance!'),

              SizedBox(height: 32),

              
        ],),
      ),)
    );
  }


Widget _buildRow(String title, String value) {

    return Row(

      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [

        Text(

          title,

          style: TextStyle(

            fontSize: 16,

            fontWeight: FontWeight.bold,

          ),

        ),

        Text(

          value,

          style: TextStyle(

            fontSize: 16,

          ),

        ),

      ],

    );

  }


  Widget _buildTable() {
  // Extract the marks data from the marks list
  List<Map> subjectMarks = marks[0]['Marks'];

  // Create a list of TableRow widgets
  List<TableRow> tableRows = [
    TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Subject',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold,)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Total Marks', textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Marks Obt.',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        
      ],
    ),
  ];

  // Loop through each subject in the subjectMarks list and create a TableRow for each
  for (var subject in subjectMarks) {
    String subjectName = subject.keys.first; // Get the subject name
    int marksObtained = subject[subjectName]; // Get the obtained marks
    int totalMarks = 100; // Assuming total marks are 100 for each subject

    tableRows.add(
      TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(subjectName),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(totalMarks.toString(),textAlign: TextAlign.center,),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(marksObtained.toString(),textAlign: TextAlign.center,),
          ),
          
        ],
      ),
    );
  }

  return Table(
    border: TableBorder.all(),
    children: tableRows,
  );
}}