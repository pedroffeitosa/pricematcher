:- consult('sistema.pl').

menu_principal :-
    writeln('Bem-vindo ao PriceMatcher - Sistema de Gerenciamento de Desenvolvedores e Projetos'),
    repeat,
    writeln('Escolha uma opção:'),
    writeln('1. Adicionar Desenvolvedor'),
    writeln('2. Adicionar Especialização a um Desenvolvedor'),
    writeln('3. Adicionar Experiência a um Desenvolvedor'),
    writeln('4. Adicionar Projeto'),
    writeln('5. Listar Projetos (Histórico de Projetos)'),
    writeln('6. Sair'),
    read(Opcao),
    executar_opcao(Opcao),
    Opcao == 6,
    writeln('Saindo...').

executar_opcao(1) :-
    writeln('Adicionar Desenvolvedor'),
    console_adc_desenv,
    menu_principal.
executar_opcao(2) :-
    writeln('Adicionar Especialização a um Desenvolvedor'),
    console_adc_espec,
    menu_principal.
executar_opcao(3) :-
    writeln('Adicionar Experiência a um Desenvolvedor'),
    console_adc_experiencia,
    menu_principal.
executar_opcao(4) :-
    writeln('Adicionar Projeto'),
    console_adc_projeto,
    menu_principal.
executar_opcao(5) :-
    writeln('Listar Projetos (Histórico de Projetos)'),
    listar_projetos, % Você deve implementar a lógica para listar os projetos aqui
    menu_principal.
executar_opcao(6).

:- menu_principal.
