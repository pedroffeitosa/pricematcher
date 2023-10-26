:- consult('console.pl').

menu_principal :-
    writeln("------------------------------------------------------------"),
    writeln('Bem-vindo ao PriceMatcher - Sistema de Gerenciamento de Desenvolvedores e Projetos'),
    repeat,
    writeln('Escolha uma opcao:'),
    writeln('1. Adicionar Desenvolvedor'),
    writeln('2. Verificar Desenvolvedor'),
    writeln('3. Adicionar Especializacao a um Desenvolvedor'),
    writeln('4. Adicionar Experiencia a um Desenvolvedor'),
    writeln('5. Adicionar Projeto'),
    writeln('6. Listar Projetos Cadastrados'),
    writeln('7. Listar Historico de um Desenvolvedor'),
    writeln('8. Sair'),
    read_line_to_string(user_input, Opcao),
    executar_opcao(Opcao).

executar_opcao("1") :-
    writeln("------------------------------------------------------------"),
    writeln('Adicionar Desenvolvedor'),
    console_adc_desenv,
    menu_principal.
executar_opcao("2") :-
    writeln("------------------------------------------------------------"),
    write('Nome: '),
    read_line_to_string(user_input, Nome),
    listar_desenvolvedor(Nome),
    menu_principal.
executar_opcao("3") :-
    writeln("------------------------------------------------------------"),
    writeln('Adicionar Especializacao a um Desenvolvedor'),
    console_adc_espec,
    menu_principal.
executar_opcao("4") :-
    writeln("------------------------------------------------------------"),
    writeln('Adicionar Experiencia a um Desenvolvedor'),
    console_adc_experiencia,
    menu_principal.
executar_opcao("5") :-
    writeln("------------------------------------------------------------"),
    writeln('Adicionar Projeto'),
    console_adc_projeto,
    menu_principal.
executar_opcao("6") :-
    writeln("------------------------------------------------------------"),
    writeln('Listar Projetos'),
    listar_projetos,
    writeln('Deseja optar por um Projeto?'),
    writeln('1. Sim'),
    writeln('2. Nao'),
    read_line_to_string(user_input, Opcao),
    (Opcao == "1" ->
        writeln('Digite seu nome: '),
        read_line_to_string(user_input, Desenvolvedor),
        writeln('Digite o nome do projeto: '),
        read_line_to_string(user_input, Projeto),
        optar_projeto(Desenvolvedor, Projeto)
    ;
        writeln('Retornando ao menu principal')),
    menu_principal.
executar_opcao("7") :-
    writeln("------------------------------------------------------------"),
    write('Digite seu nome: '),
    read_line_to_string(user_input, Nome),
    listar_historico(Nome),
    menu_principal.
executar_opcao("8") :- writeln('Saindo...'),halt.

:- menu_principal.
