
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BMIScreen(),
    ),
  );
}

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  final _bbController = TextEditingController();
  final _tbController = TextEditingController();

  double? _hasilBMI;
  String _keterangan = 'Silakan Masukkan Data Anda!';
  String _jenisKelamin = 'Laki-laki';

  void _hitungBMI() {
    final double bb = double.tryParse(
          _bbController.text.replaceAll(',', '.'),
        ) ??
        0;

    final double tbInCm = double.tryParse(
          _tbController.text.replaceAll(',', '.'),
        ) ??
        0;

    setState(() {
      if (bb > 0 && tbInCm > 0) {
        final double tbInM = tbInCm / 100;
        final double bmi = bb / (tbInM * tbInM);

        _hasilBMI = bmi;

        if (bmi < 18.5) {
          _keterangan = 'Kurus kureng';
        } else if (bmi < 25) {
          _keterangan = 'Madep Ideal';
        } else if (bmi < 30) {
          _keterangan = 'Gemuk Kureng';
        } else {
          _keterangan = 'Obesitas!!!';
        }
      } else {
        _hasilBMI = null;
        _keterangan = 'Masukkan Data Yang Valid!!!';
      }
    });
  }

  void _resetBMI() {
    setState(() {
      _bbController.clear();
      _tbController.clear();
      _hasilBMI = null;
      _keterangan = 'Silakan Masukkan Data Anda!';
      _jenisKelamin = 'Laki-laki';
    });
  }

  @override
  void dispose() {
    _bbController.dispose();
    _tbController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kalkulator BMI',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
          ),
        ),
        leading: Icon(
          Icons.calculate,
          color: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Jenis Kelamin',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),

              SizedBox(height: 10),

              DropdownButtonFormField<String>(
                value: _jenisKelamin,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                items: [
                  DropdownMenuItem(
                    value: 'Laki-laki',
                    child: Text('Laki-laki'),
                  ),
                  DropdownMenuItem(
                    value: 'Perempuan',
                    child: Text('Perempuan'),
                  ),
                ],
                onChanged: (String? value) {
                  setState(() {
                    _jenisKelamin = value!;
                  });
                },
              ),

              SizedBox(height: 15),

              TextField(
                controller: _bbController,
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.monitor_weight,
                    color: Colors.blue,
                  ),
                  labelText: 'Berat Badan',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              SizedBox(height: 15),

              TextField(
                controller: _tbController,
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.height,
                    color: Colors.blue,
                  ),
                  labelText: 'Tinggi Badan',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              SizedBox(height: 15),

              ElevatedButton(
                onPressed: _hitungBMI,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text(
                  'Hitung BMI',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),

              SizedBox(height: 10),

              ElevatedButton(
                onPressed: _resetBMI,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text(
                  'Reset',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),

              SizedBox(height: 15),

              Text(
                'Hasil BMI :',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.blue,
                ),
              ),

              SizedBox(height: 15),

              Container(
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.lightBlue.shade50,
                  border: Border.all(
                    color: Colors.blue,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _hasilBMI?.toStringAsFixed(1) ?? '--',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),

                    SizedBox(height: 15),

                    Text(
                      _keterangan,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.red,
                      ),
                    ),

                    SizedBox(height: 15),

                    if (_hasilBMI != null)
                      Text(
                        'Jenis Kelamin: $_jenisKelamin',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
