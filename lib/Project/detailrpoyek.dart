import 'dart:convert';
import 'dart:developer';
import 'dart:html';
import 'dart:io';

import 'package:audit_app_admin/mainmenu.dart';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsio;

class DetailProyek extends StatefulWidget {
  const DetailProyek({super.key, required this.proyek});

  final Map proyek;

  @override
  State<DetailProyek> createState() => _DetailProyekState();
}

List<Map> daftarharian =
    List<Map>.empty(growable: true); //ISI: PROYEK DAN SUPERVISOR
Map itemproyek = {};
bool isloaded = false;

class _DetailProyekState extends State<DetailProyek> {
  @override
  initState() {
    init();

    super.initState();
  }

  Future<void> init() async {
    daftarharian.clear();

    itemproyek.clear();
    itemproyek = widget.proyek;

    if (itemproyek.length > 9) {
      Backendless.data
          .of('harian_rekap')
          .find(DataQueryBuilder()
            ..whereClause =
                "proyek_terkait.objectId='${itemproyek["proyek_relasi"]["objectId"]}'"
            ..related = ["item_terkait.nama.jenis"]
            ..relationsDepth = 3
            ..sortBy = ["tanggal DESC"])
          .then((value) {
        if (value != null) {
          value.forEach((element) {
            setState(() {
              daftarharian.add(element as Map);
              isloaded = true;
            });
          });
        }
      });
    } else {
      isloaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Proyek: ${itemproyek['nama_proyek']}'),
        leading: CloseButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyHomePage()),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: SizedBox(
        child: Column(
          children: isloaded
              ? [
                  Container(
                      padding: const EdgeInsets.all(15),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                                "Pengeluaran Proyek:\n${CurrencyTextInputFormatter(locale: 'id', symbol: 'Rp. ', decimalDigits: 0).format(itemproyek['Total'].toString())} / ${CurrencyTextInputFormatter(locale: 'id', symbol: 'Rp. ', decimalDigits: 0).format(itemproyek['budget_proyek'].toString())}",
                                textAlign: TextAlign.left,
                                style: const TextStyle(fontSize: 17)),
                          ),
                          SizedBox(width: 0.25.sw),
                          Expanded(
                            child: Text(
                                itemproyek['status_selesai']
                                    ? "Status: \n Selesai"
                                    : "Status: \n Dikerjakan",
                                textAlign: TextAlign.right,
                                style: const TextStyle(fontSize: 17)),
                          )
                        ],
                      )),
                  Container(
                      padding: const EdgeInsets.all(15),
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                          onPressed: () {
                            laporanbaru();
                          },
                          child: const Text("Cetak Laporan Proyek"))),
                  (itemproyek.length > 9)
                      ? ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: daftarharian.length,
                          itemBuilder: (context, index) {
                            var now = DateTime.fromMillisecondsSinceEpoch(
                                daftarharian[index]['tanggal']);

                            var formatter = DateFormat('dd MMM yy');
                            var formattedDate = formatter.format(now);

                            List<int> totalharian = List.empty(growable: true);
                            List<DataRow> rows = List.empty(growable: true);

                            (daftarharian[index]['item_terkait'])
                                .forEach((element) {
                              //CARI TOTAL HARIAN
                              totalharian
                                  .add(int.parse(element['biaya'].toString()));

                              //MASUKAN DATA KEDALAM ROW
                              rows.add(DataRow(cells: [
                                DataCell(Text(element['nama']['jenis']
                                    ['nama_transaksi'])),
                                DataCell(
                                    Text(element['nama']['nama_transaksi'])),
                                DataCell(Text(element['nama']['satuan'])),
                                DataCell(Center(
                                  child: Text(
                                    element['volume'].toString(),
                                    textAlign: TextAlign.center,
                                  ),
                                )),
                                DataCell(Center(
                                  child: Text(
                                      CurrencyTextInputFormatter(
                                              locale: 'id',
                                              symbol: 'Rp. ',
                                              decimalDigits: 0)
                                          .format(element['biayasatuan']
                                              .toString()),
                                      textAlign: TextAlign.center),
                                )),
                                DataCell(Text(
                                    CurrencyTextInputFormatter(
                                            locale: 'id',
                                            symbol: 'Rp. ',
                                            decimalDigits: 0)
                                        .format(element['biaya'].toString()),
                                    textAlign: TextAlign.center)),
                              ]));
                            });

                            return ExpansionTile(
                              title: Text(formattedDate.toString(),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    child: const Text("Pengeluaran Harian: "),
                                  ),
                                  const Spacer(),
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    child: Text(
                                      CurrencyTextInputFormatter(
                                              locale: 'id',
                                              symbol: 'Rp. ',
                                              decimalDigits: 0)
                                          .format(totalharian.sum.toString()),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              children: [
                                SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    physics: const BouncingScrollPhysics(),
                                    child: DataTable(columns: const [
                                      DataColumn(
                                          label: Text("Jenis kegiatan",
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      DataColumn(
                                          label: Text("Nama",
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      DataColumn(
                                          label: Text("Satuan",
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      DataColumn(
                                          label: Text("Volume",
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      DataColumn(
                                          label: Text("Biaya Satuan",
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      DataColumn(
                                          label: Text("Biaya Total",
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ], rows: rows),
                                  ),
                                )
                              ],
                            );
                          },
                        )
                      : Center(
                          child: Text("Belum Ada Laporan Harian",
                              style:
                                  Theme.of(context).textTheme.headlineMedium),
                        )
                ]
              : [
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: SizedBox(
                        width: 60,
                        height: 60,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Loading Options...'),
                  ),
                ],
        ),
      )),
    );
  }
}

void laporanbaru() async {
  //GET DATE PERIOD
  var formatter = DateFormat('dd MMM yy');
  var formattedDate = formatter.format(
          DateTime.fromMillisecondsSinceEpoch(daftarharian.last['tanggal'])) +
      " - " +
      formatter.format(
          DateTime.fromMillisecondsSinceEpoch(daftarharian.first['tanggal']));
  List<String> listpenanggung = List.empty(growable: true);
  itemproyek["penanggung_jawab"].forEach((element) {
    listpenanggung.add(element['username']);
  });

  final xlsio.Workbook workbook = new xlsio.Workbook();
  final xlsio.Worksheet sheet = workbook.worksheets[0];
  sheet.showGridlines = false;
  sheet.enableSheetCalculations();

//SET TEMPLATE

  sheet.getRangeByName('A1').columnWidth = 4.00;
  sheet.getRangeByName('B1:C1').columnWidth = 17.82;
  sheet.getRangeByName('D1:E1').columnWidth = 7.0;

  sheet.getRangeByName('F1').columnWidth = 9.73;
  sheet.getRangeByName('G1').columnWidth = 13.0;
  sheet.getRangeByName('H1').columnWidth = 4.46;

  sheet.getRangeByName('A1:H1').cellStyle.backColor = '#333F4F';
  sheet.getRangeByName('A1:H1').merge();
  sheet.getRangeByName('B4:D6').merge();

  sheet.getRangeByName('B4').setText('LAPORAN PROYEK');
  sheet.getRangeByName('B4').cellStyle.fontSize = 28;

  sheet.getRangeByName('B8').setText('NAMA PROYEK :');
  sheet.getRangeByName('B8').cellStyle.fontSize = 9;
  sheet.getRangeByName('B8').cellStyle.bold = true;

  sheet.getRangeByName('B9').setText(itemproyek['nama_proyek']);
  sheet.getRangeByName('B9').cellStyle.fontSize = 12;

  sheet.getRangeByName('B10').setText('PENANGGUNG JAWAB :');
  sheet.getRangeByName('B10').cellStyle.fontSize = 9;
  sheet.getRangeByName('B10').cellStyle.bold = true;

  sheet.getRangeByName('B11').setText(listpenanggung.join(', '));
  sheet.getRangeByName('B11').cellStyle.fontSize = 10;

  final xlsio.Range range1 = sheet.getRangeByName('F8:G8');
  final xlsio.Range range2 = sheet.getRangeByName('F9:G9');
  final xlsio.Range range3 = sheet.getRangeByName('F10:G10');
  final xlsio.Range range4 = sheet.getRangeByName('F11:G11');

  range1.merge();
  range2.merge();
  range3.merge();
  range4.merge();

  sheet.getRangeByName('F8').setText('Periode Proyek :');
  range1.cellStyle.fontSize = 8;
  range1.cellStyle.bold = true;
  range1.cellStyle.hAlign = xlsio.HAlignType.right;

  sheet.getRangeByName('F9').setText(formattedDate);
  range2.cellStyle.fontSize = 9;
  range2.cellStyle.hAlign = xlsio.HAlignType.right;

  sheet.getRangeByName('F10').setText('Nilai Kontrak Proyek :');
  range3.cellStyle.fontSize = 8;
  range3.cellStyle.bold = true;
  range3.cellStyle.hAlign = xlsio.HAlignType.right;

  sheet.getRangeByName('F11').setNumber(itemproyek['budget_proyek']);
  range4.cellStyle.fontSize = 9;
  range4.cellStyle.hAlign = xlsio.HAlignType.right;
  range4.numberFormat = '\R\p #,##0;-\R\p#,##0';

  //ISHEADER

  sheet.getRangeByName('B14').setText('Jenis Kegiatan');
  sheet.getRangeByName('C14').setText('Nama');
  sheet.getRangeByName('D14').setText('Satuan');
  sheet.getRangeByName('E14').setText('Volume');
  sheet.getRangeByName('F14').setText('Harga');
  sheet.getRangeByName('G14').setText('Total');
  sheet.getRangeByName('B14:G14').cellStyle.fontSize = 10;
  sheet.getRangeByName('B14:G14').cellStyle.bold = true;
//ISI DATA
  int currow = 15;
  daftarharian.forEach((hari) {
    (hari['item_terkait']).forEach((hariitem) {
      currow++;

      sheet
          .getRangeByName('B' + currow.toString())
          .setText(hariitem['nama']['jenis']['nama_transaksi']);
      sheet
          .getRangeByName('C' + currow.toString())
          .setText(hariitem['nama']['nama_transaksi']);
      sheet
          .getRangeByName('D' + currow.toString())
          .setText(hariitem['nama']['satuan']);
      sheet
          .getRangeByName('E' + currow.toString())
          .setNumber(hariitem['volume']);
      sheet
          .getRangeByName('F' + currow.toString())
          .setNumber(hariitem['biayasatuan']);
      sheet
          .getRangeByName('G' + currow.toString())
          .setFormula('=E$currow*F$currow');
      sheet
          .getRangeByName('A' + currow.toString() + ':G' + currow.toString())
          .cellStyle
          .fontSize = 9;
      sheet
          .getRangeByName('E' + currow.toString() + ':G' + currow.toString())
          .cellStyle
          .hAlign = xlsio.HAlignType.right;
      sheet
          .getRangeByName('E' + currow.toString() + ':G' + currow.toString())
          .cellStyle
          .numberFormat = '\R\p #,##0;-\R\p#,##0';
      sheet
          .getRangeByName('A' + currow.toString() + ':D' + currow.toString())
          .cellStyle
          .vAlign = xlsio.VAlignType.center;
    });
  });
  int dataterakhir = currow;
  currow = dataterakhir + 2;
//GET TOTAL
  sheet.getRangeByName('E$currow:G$currow').merge();
  sheet.getRangeByName('E$currow:G$currow').cellStyle.hAlign =
      xlsio.HAlignType.right;
  final xlsio.Range range7 = sheet.getRangeByName('E$currow');
  currow++;
  sheet.getRangeByName('E$currow:G${currow + 1}').merge();

  final xlsio.Range range8 = sheet.getRangeByName('E$currow');

  range7.setText('TOTAL');
  range7.cellStyle.fontSize = 8;
  range8.setFormula('=SUM(G15:G$dataterakhir)');
  range8.numberFormat = '\R\p #,##0;-\R\p#,##0';
  range8.cellStyle.fontSize = 24;
  range8.cellStyle.hAlign = xlsio.HAlignType.right;
  range8.cellStyle.bold = true;
// Save the document.
  final List<int> bytes = workbook.saveAsStream();
  // File('AddingTextNumberDateTime.xlsx').writeAsBytes(bytes);
//Dispose the workbook.
  workbook.dispose();
  await saveAndLaunchFile(bytes, 'Invoice.xlsx');
}

Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
  AnchorElement(
      href:
          'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
    ..setAttribute('download', fileName)
    ..click();
}
