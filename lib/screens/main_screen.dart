// lib/screens/main_screen.dart

import 'package:flutter/material.dart';
import 'mitarbeiter_management_screen.dart';
import 'mitarbeiter_search_screen.dart';

class MainScreen extends StatelessWidget {

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
              Tab(text: 'Mitarbeiterverwaltung'),
              Tab(text: 'Mitarbeitersuche'),
              Tab(text: 'Abteilungsverwaltung'),
              Tab(text: 'Abteilungssuche'),
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

            // Mitarbeiter-Tabs
            MitarbeiterManagementScreen(),
            Center(child: Text('Mitarbeitersuche')),

          ],
        ),
      ),
    );
  }
}