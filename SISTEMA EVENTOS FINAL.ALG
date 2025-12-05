Algoritmo "Sistema_Eventos_FINAL_PLANO"
// Data: 05/12/2025
// Estrutura simplificada, usando apenas SE em sequência para máxima estabilidade.

Var
// Limites do sistema
  MAX_ENTIDADES: inteiro

// Estrutura do Usuário (Vetores paralelos)
  UsuarioID: vetor[1..10] de inteiro
  UsuarioNome: vetor[1..10] de caractere
  UsuarioOrganizador: vetor[1..10] de logico

// Estrutura do Evento (Vetores paralelos)
  EventoID: vetor[1..10] de inteiro
  EventoNome: vetor[1..10] de caractere
  EventoLimitePublico: vetor[1..10] de inteiro
  EventoPreco: vetor[1..10] de real
  EventoVendidos: vetor[1..10] de inteiro
  EventoOrganizadorID: vetor[1..10] de inteiro

// Variáveis de controle e auxiliares
  qtd_usuarios: inteiro
  qtd_eventos: inteiro
  id_comprador: inteiro
  opcao_menu: inteiro
  i: inteiro
  idx_evento: inteiro
  id_evento_venda: inteiro
  novo_id: inteiro
  nome_lido: caractere
  preco_lido: real
  limite_lido: inteiro
  quantidade_compra: inteiro
  ingressos_disponiveis: inteiro
  valor_total_venda: real
  total_arrecadado_evento: real
  total_publico_vendido: inteiro
  logado: logico // Variável para controlar o loop de login


Inicio
  // 1. CONFIGURAÇÃO E DADOS INICIAIS
  MAX_ENTIDADES <- 10
  qtd_usuarios <- 0
  qtd_eventos <- 0
  id_comprador <- 0

  // Usuários Pré-cadastrados (Apenas 2)
  qtd_usuarios <- 2
  UsuarioID[1] <- 1
  UsuarioNome[1] <- "Cliente Padrao"
  UsuarioOrganizador[1] <- falso
  UsuarioID[2] <- 2
  UsuarioNome[2] <- "Organizador Admin"
  UsuarioOrganizador[2] <- verdadeiro

  // Evento 1
  qtd_eventos <- 1
  EventoID[1] <- 1
  EventoNome[1] <- "Show Rock"
  EventoPreco[1] <- 100.00
  EventoLimitePublico[1] <- 50
  EventoVendidos[1] <- 0
  EventoOrganizadorID[1] <- 2

  logado <- falso

  // 2. LOOP PRINCIPAL DE LOGIN (Tela Inicial)
  repita
    limpatela
    escreval("=========================================")
    escreval("        BEM-VINDO AO SISTEMA         ")
    escreval("=========================================")
    escreval("Escolha o seu perfil de acesso:")
    escreval("1 - Cliente Padrao")
    escreval("2 - Organizador Admin")
    escreval("0 - SAIR DO PROGRAMA")
    escreval("-----------------------------------------")
    escreva("Digite a opção: ")
    leia(id_comprador)
    limpatela

    // Se a opção for 0 (Sair)
    se id_comprador = 0 entao
        escreval("Programa encerrado pelo usuário. Obrigado!")
        interrompa // Sai do loop principal e encerra o algoritmo
    fimse

    // Validação do perfil
    se (id_comprador >= 1) e (id_comprador <= qtd_usuarios) entao
        logado <- verdadeiro // Entra no sistema
    senao
        escreval("Opção de perfil inválida. Tente novamente.")
        logado <- falso
    fimse

    // 3. LOOP DO MENU PRINCIPAL (Executa se o usuário estiver logado)
    enquanto logado faca
      escreval("Bem-vindo(a) ao Sistema, ", UsuarioNome[id_comprador], "!")
      escreval("")
      escreval("=========================================")
      escreval("             MENU PRINCIPAL              ")
      escreval("=========================================")
      escreval("Usuário Logado: ", UsuarioNome[id_comprador])
      escreval("1 - Ver Eventos e Comprar Ingresso")
      escreval("2 - Relatório de Vendas")

      // Opção de Organizador
      se UsuarioOrganizador[id_comprador] entao
        escreval("3 - Criar Novo Evento (ORGANIZADOR)")
      fimse

      escreval("0 - Voltar à Tela de Login") // Opção Voltar
      escreval("-----------------------------------------")
      escreva("Escolha uma opção: ")
      leia(opcao_menu)
      limpatela

      // --- Lógica do Menu Principal (SEÇÕES PLANAS) ---

      // OPÇÃO 1: Venda
      se opcao_menu = 1 entao
        escreva("ID do Evento para compra: ")
        leia(id_evento_venda)

        idx_evento <- 0
        para i de 1 ate qtd_eventos faca
          se EventoID[i] = id_evento_venda entao
            idx_evento <- i
            interrompa
          fimse
        fimpara

        se idx_evento = 0 entao
          escreval("Evento não encontrado.")
        senao
          ingressos_disponiveis <- EventoLimitePublico[idx_evento] - EventoVendidos[idx_evento]
          escreval("Evento: ", EventoNome[idx_evento], " | Preço: R$", EventoPreco[idx_evento]:2:2, " | Disponíveis: ", ingressos_disponiveis)

          se ingressos_disponiveis <= 0 entao
            escreval("Ingressos esgotados!")
          senao
            escreva("Quantidade de ingressos a comprar: ")
            leia(quantidade_compra)

            se (quantidade_compra > 0) e (quantidade_compra <= ingressos_disponiveis) entao
              valor_total_venda <- quantidade_compra * EventoPreco[idx_evento]
              EventoVendidos[idx_evento] <- EventoVendidos[idx_evento] + quantidade_compra

              escreval("Venda Confirmada!")
              escreval("Total: R$", valor_total_venda:2:2)
            senao
              escreval("Quantidade inválida ou superior à disponibilidade.")
            fimse
          fimse
        fimse
      fimse // Fim da Opção 1

      // OPÇÃO 2: Relatório
      se opcao_menu = 2 entao
        total_publico_vendido <- 0
        escreval("--- RELATÓRIO DE VENDAS ---")

        para i de 1 ate qtd_eventos faca
          escreval("Evento ID ", EventoID[i], " (", EventoNome[i], "):")
          escreval("  Ingressos Vendidos: ", EventoVendidos[i])
          total_arrecadado_evento <- EventoVendidos[i] * EventoPreco[i]
          escreval("  Arrecadado: R$", total_arrecadado_evento:2:2)
          total_publico_vendido <- total_publico_vendido + EventoVendidos[i]
        fimpara

        escreval("-----------------------------------------")
        escreval("Total de Ingressos Vendidos no Sistema: ", total_publico_vendido)
      fimse // Fim da Opção 2

      // OPÇÃO 3: Criar Evento
      se opcao_menu = 3 entao
        se UsuarioOrganizador[id_comprador] entao
          se qtd_eventos < MAX_ENTIDADES entao
            qtd_eventos <- qtd_eventos + 1
            novo_id <- qtd_eventos
            EventoID[novo_id] <- novo_id
            EventoOrganizadorID[novo_id] <- id_comprador
            escreval("--- CRIAÇÃO DE NOVO EVENTO (ID: ", novo_id, ") ---")
            escreva("Nome: ")
            leia(nome_lido)
            EventoNome[novo_id] <- nome_lido
            escreva("Preço Padrão do Ingresso: ")
            leia(preco_lido)
            EventoPreco[novo_id] <- preco_lido
            escreva("Capacidade Máxima de Público: ")
            leia(limite_lido)
            EventoLimitePublico[novo_id] <- limite_lido
            EventoVendidos[novo_id] <- 0
            escreval("Evento '", EventoNome[novo_id], "' criado com sucesso!")
          senao
            escreval("Limite máximo de eventos atingido.")
          fimse
        senao
          escreval("Opção disponível apenas para organizadores.")
        fimse
      fimse // Fim da Opção 3

      // OPÇÃO 0: Voltar
      se opcao_menu = 0 entao
        logado <- falso // Sai do loop 'enquanto logado' e volta para a tela de Login
        escreval("Voltando para a tela de login...")
      fimse // Fim da Opção 0

      // OPÇÃO INVÁLIDA (apenas se nenhuma das válidas foi ativada)
      se (opcao_menu <> 1) e (opcao_menu <> 2) e (opcao_menu <> 3) e (opcao_menu <> 0) entao
        escreval("Opção inválida. Tente novamente.")
      fimse

    fimenquanto // Fim do loop do Menu Principal

  ate falso // Loop de login é infinito, só é interrompido pela opção 0 (Sair)
Fimalgoritmo
