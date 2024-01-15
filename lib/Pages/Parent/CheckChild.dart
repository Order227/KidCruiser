import 'package:flutter/material.dart';
import 'package:mobile_dev/Controller/Concretes/Parent/ParentController.dart';
import 'package:mobile_dev/Entities/Concretes/Children.dart';

void main() {
  runApp(CheckChild());
}

class CheckChild extends StatefulWidget {
  @override
  _CheckChildState createState() => _CheckChildState();
}

class _CheckChildState extends State<CheckChild> {
  ParentController parentController = ParentController();
  List<Children> childrenList = [];
  bool isLoading = true;
  String? hostess_name;

  @override
  void initState() {
    super.initState();
    _loadChildren();
  }

  Future<void> _loadChildren() async {
    childrenList = await parentController.getChildren();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Children List'),
        backgroundColor: Color(0xFFDBCFC4), // AppBar rengi
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadChildren,
          )
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Image.asset(
            'assets/output_image.png', // Logo resminin yolu
            width: MediaQuery.of(context).size.width * 0.5,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.00, -1.00),
                  end: Alignment(0, 1),
                  colors: [
                    Color(0xDBFFFBFB),
                    Color(0xF1C6B8C6),
                    Color(0xF3D8D6C2),
                    Color(0xFFDBCFC4),
                  ],
                  stops: [0.0, 0.2, 0.5, 1.0],
                ),
              ),
              child: ListView.builder(
                itemCount: childrenList.length,
                itemBuilder: (context, index) {
                  return _buildChildItem(childrenList[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChildItem(Children child) {
    Color backgroundColor = _getStatusColor(child.state!); // Duruma göre renk belirleme

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor, // Duruma göre renk atama
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        title: Text('${child.name} ${child.surname}  (Hostess: ${child.hostessName} ${child.hostessSurName})'),
        subtitle: Text('Status: ${child.state}'),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          // Burada her çocuk için detay sayfasına yönlendirme yapılabilir.
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "EVDE":
        return Color(0xFFFFB238);
      case "OKUL":
        return Colors.green;
      case "YOLDA":
        return Color(0xFF9c59b7);
      default:
        return Colors.white;
    }
  }
}

