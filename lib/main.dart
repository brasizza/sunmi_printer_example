import 'package:flutter/material.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<bool?> _bindingPrinter() async {
    final bool? result = await SunmiPrinter.bindingPrinter();
    return result;
  }

  @override
  void initState() {
    super.initState();

    _bindingPrinter();
  }

  Future<void> _printColum() async {
    await SunmiPrinter.initPrinter();
    await SunmiPrinter.startTransactionPrint(true);
    for (var i = 0; i < 10; i++) {
      var data = 'TESTE';
      var data2 = 'XXX';
      await SunmiPrinter.printRow(cols: [
        ColumnMaker(
          text: data,
          width: 15,
          align: SunmiPrintAlign.LEFT,
        ),
        ColumnMaker(
          text: data2,
          width: 15,
          align: SunmiPrintAlign.RIGHT,
        )
      ]);
    }
    await SunmiPrinter.lineWrap(2);
    await SunmiPrinter.exitTransactionPrint(true);
    await SunmiPrinter.cut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[Text('Sunmi Column Example')],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _printColum();
        },
        tooltip: 'Print columns',
        child: const Icon(Icons.add),
      ),
    );
  }
}
