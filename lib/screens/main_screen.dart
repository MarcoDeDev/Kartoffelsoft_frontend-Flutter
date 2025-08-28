// lib/screens/main_screen.dart

import 'package:flutter/material.dart';
import 'package:kartofelsoft_frontend/screens/abteilung_management_screen.dart';
import 'mitarbeiter_management_screen.dart';
import 'mitarbeiter_search_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});


  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 8,

      child: Scaffold(

        appBar: AppBar(
          title: Text('Kartoffelsoft'),
          bottom: TabBar(
            isScrollable: true,

            tabs: [
              Tab(text: 'Artikelverwaltung'),
              Tab(text: 'Artikelsuche'),
              Tab(text: 'Kundenverwaltung'),
              Tab(text: 'Kundensuche'),
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
            Center(child: Text('Artikelverwaltung')),
            Center(child: Text('Artikelsuche')),

            // Kunden-Tabs
            Center(child: Text('Kundenverwaltung')),
            Center(child: Text('Kundensuche')),

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