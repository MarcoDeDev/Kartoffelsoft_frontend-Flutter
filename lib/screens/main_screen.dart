// lib/screens/main_screen.dart

import 'package:flutter/material.dart';
import 'package:kartofelsoft_frontend/screens/abteilung_management_screen.dart';
import 'package:kartofelsoft_frontend/screens/artikel_management_screen.dart';
import 'grosskunde_management_screen.dart';
import 'lieferant_management_screen.dart';
import 'mitarbeiter_management_screen.dart';
import 'mitarbeiter_search_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});


  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 10,

      child: Scaffold(

        appBar: AppBar(
          title: Text('Kartoffelsoft'),
          bottom: TabBar(
            isScrollable: true,

            tabs: [

              Tab(text: 'Artikelverwaltung'),
              Tab(text: 'Artikelsuche'),

              Tab(text: 'Lieferantverwaltung'),
              Tab(text: 'Lieferantsuche'),

              Tab(text: 'Groß-Kundenverwaltung'),
              Tab(text: 'Groß-Kundensuche'),

              Tab(text: 'Abteilungsverwaltung'),
              Tab(text: 'Abteilungssuche'),

              Tab(text: 'Mitarbeiterverwaltung'),
              Tab(text: 'Mitarbeitersuche'),
            ],
          ),
        ),

        body: TabBarView(

          children: [

            // Artikel-Tabs
            ArtikelManagementScreen(),
            Center(child: Text('Artikelsuche')),

            // Lieferant-Tabs
            LieferantManagementScreen(),
            Center(child: Text('Lieferantsuche')),

            // Kunden-Tabs
            GrossKundeManagementScreen(),
            Center(child: Text('Groß_Kundensuche')),

            // Abteilung-Tabs
            AbteilungManagementScreen(),
            Center(child: Text('Abteilungsuche')),

            // Mitarbeiter-Tabs
            MitarbeiterManagementScreen(),
            Center(child: Text('Mitarbeitersuche')),

          ],
        ),
      ),
    );
  }
}