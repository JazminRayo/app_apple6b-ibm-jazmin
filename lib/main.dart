// Página para mostrar la lista de Sexo (sin Scaffold)
class SexoPage extends StatefulWidget {
  @override
  _SexoPageState createState() => _SexoPageState();
}

class _SexoPageState extends State<SexoPage> {
  List<Sexo> _sexoList = [];
  List<Sexo> _filteredSexoList = [];
  String _searchText = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSexoData();
  }

  Future<void> _fetchSexoData() async {
    setState(() => _isLoading = true);
    try {
      final response = await http.get(Uri.parse(
          'https://educaysoft.org/apple6b/app/controllers/SexoController.php?action=api'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List<dynamic>;
        setState(() {
          _sexoList = data.map((item) => Sexo.fromJson(item)).toList();
          _filteredSexoList = _sexoList;
        });
      } else {
        debugPrint('Error Sexo: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Excepción Sexo: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _filterSearch(String query) {
    setState(() {
      _searchText = query;
      _filteredSexoList = _sexoList
          .where((item) =>
              item.nombre.toLowerCase().contains(query.toLowerCase()) ||
              item.idsexo.contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _filterSearch,
              decoration: InputDecoration(
                labelText: 'Buscar Sexo',
                hintText: 'Ingrese nombre o ID',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredSexoList.isEmpty
                    ? const Center(child: Text("No hay datos de Sexo disponibles"))
                    : ListView.builder(
                        itemCount: _filteredSexoList.length,
                        itemBuilder: (context, index) {
                          final sexo = _filteredSexoList[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            elevation: 2,
                            child: ListTile(
                              leading: const Icon(Icons.people, color: Colors.blueAccent),
                              title: Text(sexo.nombre, style: const TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text("ID: ${sexo.idsexo}"),
                              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Sexo seleccionado: ${sexo.nombre}'), duration: const Duration(seconds: 1)),
                                );
                              },
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}


// Página para mostrar la lista de Telefono (sin Scaffold)
class TelefonoPage extends StatefulWidget {
  @override
  _TelefonoPageState createState() => _TelefonoPageState();
}

class _TelefonoPageState extends State<TelefonoPage> {
  List<Telefono> _telefonoList = [];
  List<Telefono> _filteredTelefonoList = [];
  String _searchText = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTelefonoData();
  }

  Future<void> _fetchTelefonoData() async {
    setState(() => _isLoading = true);
    try {
      final response = await http.get(Uri.parse(
          'https://educaysoft.org/apple6b/app/controllers/TelefonoController.php?action=api'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List<dynamic>;
        setState(() {
          _telefonoList = data.map((item) => Telefono.fromJson(item)).toList();
          _filteredTelefonoList = _telefonoList;
        });
      } else {
        debugPrint('Error Teléfono: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Excepción Teléfono: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _filterSearch(String query) {
    setState(() {
      _searchText = query;
      _filteredTelefonoList = _telefonoList
          .where((item) =>
              item.numero.toLowerCase().contains(query.toLowerCase()) ||
              item.idtelefono.contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _filterSearch,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Buscar Teléfono',
                hintText: 'Ingrese número o ID',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredTelefonoList.isEmpty
                    ? const Center(child: Text("No hay datos de Teléfono disponibles"))
                    : ListView.builder(
                        itemCount: _filteredTelefonoList.length,
                        itemBuilder: (context, index) {
                          final telefono = _filteredTelefonoList[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                            elevation: 2,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              leading: const Icon(Icons.phone, color: Colors.blueAccent),
                              title: Text(telefono.numero, style: const TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text("ID: ${telefono.idtelefono}"),
                              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Teléfono seleccionado: ${telefono.numero}'), duration: const Duration(seconds: 1)),
                                );
                              },
                            ),
                          );
                        },
                      ),
          )
        ],
      ),
    );
  }
}


// Página para mostrar la lista de Persona (sin Scaffold)
class PersonaPage extends StatefulWidget {
  @override
  _PersonaPageState createState() => _PersonaPageState();
}

class _PersonaPageState extends State<PersonaPage> {
  List<Persona> _personaList = [];
  List<Persona> _filteredPersonaList = [];
  String _searchText = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPersonaData();
  }

  Future<void> _fetchPersonaData() async {
    setState(() => _isLoading = true);
    try {
      final response = await http.get(Uri.parse(
          'https://educaysoft.org/apple6b/app/controllers/PersonaController.php?action=api'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List<dynamic>;
        setState(() {
          _personaList = data.map((item) => Persona.fromJson(item)).toList();
          _filteredPersonaList = _personaList;
        });
      } else {
        debugPrint('Error Persona: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Excepción Persona: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _filterSearch(String query) {
    setState(() {
      _searchText = query;
      _filteredPersonaList = _personaList
          .where((item) =>
              item.nombres.toLowerCase().contains(query.toLowerCase()) ||
              item.apellidos.toLowerCase().contains(query.toLowerCase()) ||
              item.idpersona.contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _filterSearch,
              decoration: InputDecoration(
                labelText: 'Buscar Persona',
                hintText: 'Ingrese nombres o apellidos',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredPersonaList.isEmpty
                    ? const Center(child: Text("No hay datos de Persona disponibles"))
                    : ListView.builder(
                        itemCount: _filteredPersonaList.length,
                        itemBuilder: (context, index) {
                          final persona = _filteredPersonaList[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                            elevation: 2,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              leading: const Icon(Icons.person, color: Colors.green),
                              title: Text("${persona.nombres} ${persona.apellidos}", style: const TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Sexo: ${persona.elsexo}"),
                                  Text("Estado civil: ${persona.elestadocivil}"),
                                  Text("Fecha Nacimiento: ${persona.fechanacimiento}"),
                                ],
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Persona: ${persona.nombres} ${persona.apellidos}'), duration: const Duration(seconds: 1)),
                                );
                              },
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
