import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Controla a aba selecionada no menu inferior

  // Dados de exemplo - no futuro, virão do Firebase
  final List<Map<String, String>> pets = [
    {'name': 'Rex', 'image': 'assets/dog_icon.png'},
    {'name': 'Mila', 'image': 'assets/cat_icon.png'},
    {'name': 'Loro', 'image': 'assets/bird_icon.png'},
  ];

  final List<Map<String, String>> lembretes = [
    {'title': 'Vacina V10 para Rex', 'subtitle': 'Amanhã, 10:00h'},
    {'title': 'Consulta de rotina - Mila', 'subtitle': 'Quarta-feira, 15:30h'},
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Aqui você pode adicionar a lógica para navegar para outras telas
  }

  @override
  Widget build(BuildContext context) {
    // Definindo algumas cores para o tema
    final Color primaryColor = Color(0xFF899670); // Verde sálvia que você escolheu
    final Color backgroundColor = Color(0xFFF7F7F5); // Off-white

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text('UltraVet JP', style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: primaryColor),
            onPressed: () {
              // Ação para notificações
            },
          ),
        ],
      ),
      body: SingleChildScrollView( // Permite que a tela role se o conteúdo for grande
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Seção de Boas-vindas
              Text(
                'Olá, Allan!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3A3A3A),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Como seus pets estão hoje?',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              const SizedBox(height: 32),

              // Seção de Pets
              _buildSectionTitle('Seus Pets'),
              const SizedBox(height: 16),
              Container(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: pets.length + 1, // +1 para o botão de adicionar
                  itemBuilder: (context, index) {
                    if (index == pets.length) {
                      return _buildAddPetCard();
                    }
                    return _buildPetCard(pets[index]['name']!);
                  },
                ),
              ),
              const SizedBox(height: 32),
              
              // Botão de Ação Principal
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.calendar_month, color: Colors.white),
                  label: const Text('Agendar Consulta', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Seção de Lembretes
              _buildSectionTitle('Próximos Lembretes'),
              const SizedBox(height: 16),
              ...lembretes.map((lembrete) => _buildReminderTile(lembrete['title']!, lembrete['subtitle']!)).toList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Agendamentos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  // Widget auxiliar para os títulos das seções
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF3A3A3A),
      ),
    );
  }

  // Widget auxiliar para o card de cada pet
  Widget _buildPetCard(String name) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Color(0xFFEAE7DC),
            child: Icon(Icons.pets, size: 30, color: Color(0xFF899670)), // Substitua pelo ícone ou imagem do pet
          ),
          const SizedBox(height: 8),
          Text(name, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  // Widget auxiliar para o card de adicionar pet
  Widget _buildAddPetCard() {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.grey[200],
            child: Icon(Icons.add, size: 30, color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Text('Adicionar', style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    );
  }

  // Widget auxiliar para os lembretes
  Widget _buildReminderTile(String title, String subtitle) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(Icons.notifications_active, color: Color(0xFF899670)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
      ),
    );
  }
}