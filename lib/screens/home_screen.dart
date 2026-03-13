import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // O fundo do app (aquele cinza bem clarinho que combinamos)
      backgroundColor: const Color(0xFFF8FAFC),

      // SafeArea evita que o conteúdo fique "escondido" atrás da câmera ou entalhe do celular
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0), // Margem nas laterais
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Alinha tudo à esquerda
            children: [
              // --- SEÇÃO DE SAUDAÇÃO ---
              const Text(
                "Bom dia,",
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
              const Text(
                "João Silva", // Nome fixo por enquanto, depois mudamos
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B), // Azul bem escuro para contraste
                ),
              ),

              const SizedBox(height: 30), // Espaço entre os blocos
              // --- CARD DE RESUMO (O "AZUL SERENO") ---
              Container(
                width: double.infinity, // Ocupa toda a largura disponível
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF4A90E2), // Nosso Azul Sereno
                  borderRadius: BorderRadius.circular(
                    24,
                  ), // Bordas bem arredondadas
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4A90E2).withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Seu progresso de hoje",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "75%", // Exemplo de porcentagem
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Uma barrinha de progresso branca
                    LinearProgressIndicator(
                      value: 0.75,
                      backgroundColor: Colors.white24,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // --- PRÓXIMO REMÉDIO ---
              const Text(
                "Próximo remédio",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),

              // Um card simples para o remédio
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.black12,
                  ), // Uma bordinha sutil
                ),
                child: const Row(
                  children: [
                    Icon(Icons.medication, color: Color(0xFF4A90E2), size: 40),
                    SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Amoxicilina",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "500mg - 08:00",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
