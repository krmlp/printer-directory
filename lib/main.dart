import 'package:flutter/material.dart';

void main() => runApp(FilamentApp());

class FilamentApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Filament Rehberi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainTabPage(),
    );
  }
}

class MainTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('3D Yazıcı Rehberi'),
          backgroundColor: Colors.teal,
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.print),
                text: 'FDM Yazıcı',
              ),
              Tab(
                icon: Icon(Icons.opacity),
                text: 'Reçine Yazıcı',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FilamentSelectionPage(),
            ResinPrinterPage(),
          ],
        ),
      ),
    );
  }
}

class FilamentSelectionPage extends StatelessWidget {
  final List<Map<String, dynamic>> filaments = [
    {
      'name': 'PLA',
      'nozzleTemp': '190-220°C',
      'bedTemp': '50-60°C',
      'speed': '40-60 mm/s',
      'infill': '20-30%',
      'tips': [
        'En iyi sonuçlar için soğutma fanını %100 çalıştırın.',
        'Çarpılmayı önlemek için yüksek ortam sıcaklığından kaçının.',
        'Kırılganlığı önlemek için PLA\'yı kuru ve serin bir yerde saklayın.',
      ],
    },
    {
      'name': 'ABS',
      'nozzleTemp': '230-250°C',
      'bedTemp': '90-110°C',
      'speed': '40-60 mm/s',
      'infill': '20-30%',
      'tips': [
        'Dumanlardan kaçınmak için iyi havalandırılmış bir alanda yazdırın.',
        'Çarpılmayı önlemek için kapalı alan kullanın.',
        'İyi yapışma için tabla ısıtmasının yeterli olduğundan emin olun.',
      ],
    },
    {
      'name': 'PETG',
      'nozzleTemp': '220-250°C',
      'bedTemp': '70-90°C',
      'speed': '40-60 mm/s',
      'infill': '20-30%',
      'tips': [
        'Daha iyi katman yapışması için düşük baskı hızı kullanın.',
        'Katman ayrılmasını önlemek için aşırı soğutmadan kaçının.',
        'Daha iyi yapışma için baskı tablasını iyice temizleyin.',
      ],
    },
    {
      'name': 'TPU',
      'nozzleTemp': '200-230°C',
      'bedTemp': '30-60°C',
      'speed': '20-30 mm/s',
      'infill': '10-20%',
      'tips': [
        'Daha iyi sonuçlar için direct drive ekstruder kullanın.',
        'Filament dolaşmasını önlemek için düşük hızlarda yazdırın.',
        'Temiz ve pürüzsüz bir yüzeyle düzgün tabla yapışması sağlayın.',
      ],
    },
    {
      'name': 'Nylon',
      'nozzleTemp': '240-270°C',
      'bedTemp': '80-110°C',
      'speed': '30-50 mm/s',
      'infill': '20-30%',
      'tips': [
        'Nem sorunlarını önlemek için filamenti yazdırmadan önce kurutun.',
        'Daha iyi katman yapışması için ısıtmalı kabin kullanın.',
        'Daha iyi yapışma için tablaya yapıştırıcı sürün.',
      ],
    },
    {
      'name': 'Carbon Fiber PLA',
      'nozzleTemp': '200-230°C',
      'bedTemp': '50-60°C',
      'speed': '40-60 mm/s',
      'infill': '20-30%',
      'tips': [
        'Aşınmayı önlemek için sertleştirilmiş çelik nozul kullanın.',
        'Daha iyi detay için düşük hızlarda yazdırın.',
        'Temiz bir yüzeyle düzgün tabla yapışması sağlayın.',
      ],
    },
    {
      'name': 'Wood Filament',
      'nozzleTemp': '200-220°C',
      'bedTemp': '50-60°C',
      'speed': '40-60 mm/s',
      'infill': '15-25%',
      'tips': [
        'Tıkanmayı önlemek için daha büyük nozul boyutu kullanın.',
        'İstenen ahşap tonunu elde etmek için sıcaklığı ayarlayın.',
        'Birikmeyi önlemek için nozulu düzenli olarak temizleyin.',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filament Seçimi'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: Icon(Icons.lightbulb_outline, color: Colors.orange),
            tooltip: 'Genel İpuçları',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GeneralTipsPage()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filaments.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              leading: Icon(Icons.print, color: Colors.teal, size: 30),
              title: Text(filaments[index]['name'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              subtitle: Text('Detaylar için dokunun', style: TextStyle(fontSize: 16)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FilamentDetailPage(filament: filaments[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PrintingStepsPage()),
          );
        },
        child: Icon(Icons.photo_library),
        backgroundColor: Colors.green,
        tooltip: '3D Yazıcı Adımları',
      ),
    );
  }
}

class GeneralTipsPage extends StatelessWidget {
  final List<String> generalTips = [
    'Her baskı öncesi tabla seviyesini ayarlayın.',
    'Yazıcınızı temiz ve bakımlı tutun.',
    'Ekstruder kalibrasyonunu yapın.',
    'Filamentleri kuru ve kapalı bir kapta nem alıcı ile saklayın.',
    'Baskıya başlamadan önce nozul ve tablayı ısıtın.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Genel İpuçları'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: generalTips.map((tip) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text('- $tip', style: TextStyle(fontSize: 16)),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class FilamentDetailPage extends StatelessWidget {
  final Map<String, dynamic> filament;

  FilamentDetailPage({required this.filament});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${filament['name']} Detayları'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nozul Sıcaklığı:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _buildDetailBox(filament['nozzleTemp']),
            SizedBox(height: 8),
            Text('Tabla Sıcaklığı:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _buildDetailBox(filament['bedTemp']),
            SizedBox(height: 8),
            Text('Baskı Hızı:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _buildDetailBox(filament['speed']),
            SizedBox(height: 8),
            Text('Dolgu Oranı:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _buildDetailBox(filament['infill']),
            SizedBox(height: 16),
            Text('${filament['name']} için İpuçları:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...filament['tips'].map<Widget>((tip) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text('- $tip', style: TextStyle(fontSize: 16)),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailBox(String detail) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(color: Colors.teal[50], borderRadius: BorderRadius.circular(8)),
      child: Text(detail, style: TextStyle(fontSize: 16)),
    );
  }
}

class PrintingStepsPage extends StatelessWidget {
  final List<Map<String, String>> steps = [
    {
      'image': 'assets/images/step1.JPG',
      'description': 'Adım 1: Filamenti sensörden geçecek şekilde yükleyin.',
    },
    {
      'image': 'assets/images/step2.png',
      'description': 'Adım 2: Yazıcıya yüklediğiniz filament türünü seçin (Ayarları kendisi en uygun şekilde yapacaktır).',
    },
    {
      'image': 'assets/images/step3.png',
      'description': 'Step 3: Baskısını alacağınız modele support eklemesi yapın.Support eklediğiniz yüzeylerde bozulma olacağını unutmayın.(Tpu filament kullanıyorsanız bu adımı atlayın.)',
    },
    {
      'image': 'assets/images/step4.png',
      'description': 'Step 4: Uygulamamızda size gösterilen ayarların yapılı olduğundan emin olun ve size verdiğimiz ipuçlarını dikkate alın.',
    },
    {
      'image': 'assets/images/step5.png',
      'description': 'Step 5: Dilimleme işlemi sonrası baskınızın G-code unu ister bir USB bellek aracılığı ile ister Wi-Fi üzerinden yazıcıya yükleyin.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('3B Yazıcı Adımları'),
        backgroundColor: Colors.blueGrey,
      ),
      body: ListView.builder(
        itemCount: steps.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(steps[index]['image']!, fit: BoxFit.cover),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    steps[index]['description']!,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ResinPrinterPage extends StatelessWidget {
  final List<String> resinTips = [
    'Her zaman nitril eldiven ve koruyucu gözlük kullanın',
    'İyi havalandırılmış bir ortamda çalışın',
    'Reçineyi doğrudan güneş ışığından koruyun',
    'Kullanılmayan reçineyi kapalı ve karanlık bir yerde saklayın',
    'Baskı sonrası parçaları IPA ile temizleyin',
    'Temizlenen parçaları UV kürleme işlemine tabi tutun',
    'Reçine atıklarını özel atık olarak bertaraf edin',
    'Reçine ile temas eden aletleri IPA ile temizleyin',
    'Yazıcı tankını düzenli olarak temizleyin ve filtreleyin',
    'FEP filmi düzenli olarak kontrol edin ve gerekirse değiştirin',
  ];

  final List<Map<String, dynamic>> resins = [
    {
      'name': 'Standart Reçine',
      'exposureTime': '6-8 saniye',
      'bottomExposure': '60-80 saniye',
      'layerHeight': '0.05mm',
      'tips': [
        'UV ışığından koruyun',
        'Eldiven ve maske kullanın',
        'İyi havalandırılmış ortamda çalışın',
      ],
    },
    {
      'name': 'ABS Benzeri Reçine',
      'exposureTime': '8-10 saniye',
      'bottomExposure': '70-90 saniye',
      'layerHeight': '0.05mm',
      'tips': [
        'Dayanıklı parçalar için uygundur',
        'Post-cure işlemi gereklidir',
        'Sıcak suyla temizlemeyin',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Başlık ve İpuçları Satırı
          Container(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      'Reçine Seçici',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.lightbulb_outline, color: Colors.amber, size: 24),
                  tooltip: 'Reçine Yazıcı Genel İpuçları',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Row(
                            children: [
                              Icon(Icons.lightbulb, color: Colors.amber),
                              SizedBox(width: 10),
                              Text('Reçine Yazıcı Genel İpuçları'),
                            ],
                          ),
                          content: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: resinTips.map((tip) => Padding(
                                padding: EdgeInsets.symmetric(vertical: 4),
                                child: Text('• $tip'),
                              )).toList(),
                            ),
                          ),
                          actions: [
                            TextButton(
                              child: Text('Kapat'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          // Reçine Listesi
          Expanded(
            child: ListView.builder(
              itemCount: resins.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    leading: Icon(Icons.opacity, color: Colors.purple, size: 30),
                    title: Text(resins[index]['name'], 
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    subtitle: Text('Detaylar için dokunun', 
                        style: TextStyle(fontSize: 16)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResinDetailPage(resin: resins[index]),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ResinPrintingStepsPage()),
          );
        },
        child: Icon(Icons.photo_library),
        backgroundColor: Colors.purple,
        tooltip: 'Reçine Yazıcı Adımları',
      ),
    );
  }
}

class ResinDetailPage extends StatelessWidget {
  final Map<String, dynamic> resin;

  ResinDetailPage({required this.resin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${resin['name']} Detayları'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pozlama Süresi:', 
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _buildDetailBox(resin['exposureTime']),
            SizedBox(height: 8),
            Text('Taban Katmanı Pozlama:', 
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _buildDetailBox(resin['bottomExposure']),
            SizedBox(height: 8),
            Text('Katman Yüksekliği:', 
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _buildDetailBox(resin['layerHeight']),
            SizedBox(height: 16),
            Text('İpuçları:', 
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...resin['tips'].map<Widget>((tip) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text('- $tip', style: TextStyle(fontSize: 16)),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailBox(String detail) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.purple[50], 
        borderRadius: BorderRadius.circular(8)
      ),
      child: Text(detail, style: TextStyle(fontSize: 16)),
    );
  }
}

class ResinPrintingStepsPage extends StatelessWidget {
  final List<Map<String, String>> steps = [
    {
      'image': 'assets/images/adim1.JPG',
      'description': 'Adım 1: Reçine tankını kontrol edin ve gerekirse temizleyin.',
    },
    {
      'image': 'assets/images/adim2.JPG',
      'description': 'Adım 2: FEP filminin durumunu kontrol edin, hasarlıysa değiştirin.',
    },
    {
      'image': 'assets/images/adim3.JPG',
      'description': 'Adım 3: Baskı platformunun seviyesini kontrol edin ve gerekirse ayarlayın.',
    },
    {
      'image': 'assets/images/resin_step4.png',
      'description': 'Adım 4: Reçineyi tankın içine dikkatlice dökün ve hava kabarcığı olmadığından emin olun.',
    },
    {
      'image': 'assets/images/adim5.png',
      'description': 'Adım 5: Modelinizi dilimleme yazılımında desteklerle birlikte hazırlayın.',
    },
    {
      'image': 'assets/images/adim6.png',
      'description': 'Adım 6: Baskı tamamlandıktan sonra parçayı alkol banyosunda temizleyin (İlk banyo kirli alkol, ikinci banyo temiz alkol ile).',
    },
    {
      'image': 'assets/images/resin_step7.png',
      'description': 'Adım 7: Temizlenen parçayı UV kürleme işlemine tabi tutun.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reçine Yazıcı Adımları'),
        backgroundColor: Colors.purple,
      ),
      body: ListView.builder(
        itemCount: steps.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  steps[index]['image']!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    steps[index]['description']!,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
