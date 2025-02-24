import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart';

void main() {
  runApp(const Jaztea());
}

class Jaztea extends StatelessWidget {
  const Jaztea({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LinktreePage(),
    );
  }
}

class LinktreePage extends StatelessWidget {
  const LinktreePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFFf7c424), // Color de fondo amarillo
        ),
 child: Center(
  child: ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: 2000), // Máximo 600px de ancho
    child: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
          Center(
            child: Image.asset(
              'assets/logoletras.png',
              fit: BoxFit.contain,
              width: MediaQuery.of(context).size.width * 0.8,
              height: 100,
            ),
          ),
          const SizedBox(height: 20),

          // 🔹 Botones de redes sociales
          const LinkButton(
            text: 'FACEBOOK || JAZTEA EL ORIGINAL',
            icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.blue),
            url:
                'https://www.facebook.com/share/188dBHT2wf/?mibextid=LQQJ4d',
          ),
          const LinkButton(
            text: 'INSTAGRAM || JAZTEA EL ORIGINAL',
            icon: FaIcon(FontAwesomeIcons.instagram, color: Colors.pink),
            url:
                'https://www.instagram.com/jaztea.original/?igsh=aTVmaWF2aDVraDZ3',
          ),
          const LinkButton(
            text: 'TIKTOK || JAZTEA EL ORIGINAL',
            icon: FaIcon(FontAwesomeIcons.tiktok, color: Colors.black),
            url:
                'https://www.tiktok.com/@jazteaeloriginal?_t=8sBQBlA14Mf&_r=1',
          ),
          const LinkButton(
            text: 'WHATSAPP || JAZTEA EL ORIGINAL',
            icon: FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green),
            url:
                'https://api.whatsapp.com/send?phone=5213316022513&text=Hola%20Jaztea%2C%20Me%20gustaria%20realizar%20un%20pedido%20a%20domicilio',
          ),

          // 🔹 Tarjetas de ubicación
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: [
                LocationCard(
                  title: 'Jaztea Room Lola',
                  address:
                      'Lola Beltrán 3297, 80058 Culiacán Rosales, Sin.',
                  url: 'https://maps.app.goo.gl/Vx3FXTbeixnzdp8J8',
                ),
                LocationCard(
                  title: 'Jaztea Room Arjona',
                  address:
                      'Blvd. Mario López Valdez 1535-local 17, 80056 Culiacán Rosales, Sin.',
                  url: 'https://maps.app.goo.gl/1J28oj6mJSSa1QA89',
                ),
              ],
            ),
          ),

          const SizedBox(height: 50), // Espaciado inferior
        ],
      ),
    ),
  ),
),

      ),
    );
  }
}

// 🔹 Botón de enlace con diseño adaptativo
class LinkButton extends StatelessWidget {
  final String text;
  final Widget icon;
  final String url;

  const LinkButton({
    super.key,
    required this.text,
    required this.icon,
    required this.url,
  });

  Future<void> _launchURL(BuildContext context) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo abrir el enlace.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        bool hideEverything = width < 110;
        bool showOnlyIcons = width >= 111 && width < 200;
        bool showIconsWithPartialText = width >= 200 && width < 400;
        bool showFullText = width >= 400;

        String displayText = showIconsWithPartialText
            ? text.split("||")[0]
            : showFullText
                ? text
                : "";

        return Visibility(
          visible: !hideEverything,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 80),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: () => _launchURL(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icon,
                    if (displayText.isNotEmpty) ...[
                      const SizedBox(width: 10),
                      Text(
                        displayText,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class LocationCard extends StatelessWidget {
  final String title;
  final String address;
  final String url;

  const LocationCard({
    super.key,
    required this.title,
    required this.address,
    required this.url,
  });

  Future<void> _launchURL(BuildContext context) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo abrir el enlace de Google Maps.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;

        if (width < 110) return const SizedBox.shrink();

        bool showIconAndTitle = width >= 111 && width < 400;
        bool showFullDetails = width >= 400;

        return SizedBox(
          width: 250,
          height: 250,
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: InkWell(
              onTap: () => _launchURL(context),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.location_on, color: Colors.red, size: 30),
                    if (showIconAndTitle || showFullDetails) ...[
                      const SizedBox(height: 10),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                    if (showFullDetails) ...[
                      const SizedBox(height: 5),
                      Text(
                        address,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
