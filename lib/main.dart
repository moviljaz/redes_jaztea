// ignore_for_file: use_build_context_synchronously

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
        color: const Color((0xFFf7c424)), // Cambia este color al que desees
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'assets/logoletras.png',
                    fit: BoxFit.contain,
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 100,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  '',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                const LinkButton(
                  text: 'FACEBOOK || JAZTEA EL ORIGINAL',
                  icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.blue),
                  url: 'https://www.facebook.com/share/188dBHT2wf/?mibextid=LQQJ4d',
                ),
                const LinkButton(
                  text: 'INSTAGRAM || JAZTEA EL ORIGINAL',
                  icon: FaIcon(FontAwesomeIcons.instagram, color: Colors.pink),
                  url: 'https://www.instagram.com/jaztea.original/?igsh=aTVmaWF2aDVraDZ3',
                ),
                const LinkButton(
                  text: 'TIKTOK || JAZTEA EL ORIGINAL',
                  icon: FaIcon(FontAwesomeIcons.tiktok, color: Colors.black),
                  url: 'https://www.tiktok.com/@jazteaeloriginal?_t=8sBQBlA14Mf&_r=1',
                ),
                const LinkButton(
                  text: 'WHATSAPP || JAZTEA EL ORIGINAL',
                  icon: FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green),
                  url: 'https://api.whatsapp.com/send?phone=5213316022513&text=Hola%20Jaztea%2C%20Me%20gustaria%20realizar%20un%20pedido%20a%20domicilio', // Cambia al número deseado.
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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
  if (kIsWeb) {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No se pudo abrir el enlace en el navegador.'),
        ),
      );
    }
  } else {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No se pudo abrir el enlace.'),
        ),
      );
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;

        // Ajustar el contenido basado en el ancho.
        bool showOnlyIcons = width < 200; // Mostrar solo íconos si es muy pequeño.
        bool showIconsWithPartialText = width >= 200 && width < 400; // Iconos con texto parcial.
// Iconos con texto completo.

        String displayText = text;
        if (showIconsWithPartialText) {
          displayText = text.split("||")[0]; // Mostrar texto antes de los `||`.
        } else if (showOnlyIcons) {
          displayText = ""; // Solo mostrar iconos.
        }

        return ConstrainedBox(
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
        );
      },
    );
  }
}
