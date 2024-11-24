import 'package:erp_student_app/models/functions.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  var name;
  var classes;
  var rollno;
 
  double marksobt = 0;


  List<Map> marks = [
   {"Exam_type":"Final Exam",
    "Marks":[ {"maths":09},
    {"science":08},
    {"english":07},
    {"social sceince": 94},
    {"drawing":99}]}
  ];

@override
  void initState() {
    details();
    super.initState();
  }

void details()async{
  List<Map> subjectMarks = marks[0]['Marks'];
var rollno1 = await  SecuredStorage(myKey: 'studentRoll').getData();
var name1 = await SecuredStorage(myKey: 'studentName').getData();
var classes1  =await SecuredStorage(myKey: 'studentClass').getData();
setState(() {
  rollno=rollno1;
  name=name1;
  classes=classes1;
});
for(var i in subjectMarks){
  String subjectName = i.keys.first;
  setState(() {
    marksobt += i[subjectName];
  });

}

}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: Container(padding: const EdgeInsets.all(8),child: SingleChildScrollView(
        child: Column(children: [

const Text(

                'Nav jyoti model school',

                style: TextStyle(

                  fontSize: 20,

                  fontWeight: FontWeight.bold,

                ),

              ), const SizedBox(height: 8),


              const SizedBox(height: 8),

              const Text(

                '2023-24',

                style: TextStyle(

                  fontSize: 16,

                ),

              ),const SizedBox(height: 16),

              _buildRow('Student Name', name.toString()),

              _buildRow('Parent Name', 'Khushal Sharma'),

              _buildRow('Dob', '24/02/2006'),

              _buildRow('Exam Name', marks[0]['Exam_type']),

              _buildRow('Class', classes.toString()),

              _buildRow('Roll No', rollno.toString()),

              const SizedBox(height: 16),

              _buildTable(),

              const SizedBox(height: 16),

              _buildRow('Grade', marksobt.toString()),

              _buildRow('Attendance', '180'),
               _buildRow('Remarks', 'Excellent performance!'),

              const SizedBox(height: 32),

              
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

          style: const TextStyle(

            fontSize: 16,

            fontWeight: FontWeight.bold,

          ),

        ),

        Text(

          value,

          style: const TextStyle(

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
    const TableRow(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Subject',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold,)),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Total Marks', textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
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