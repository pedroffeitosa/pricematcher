:- consult('desenvolvedor.pl').
:- consult('projeto.pl').
:- consult('historico.pl').

% Adiciona um desenvolvedor com nome, sem especializacoes/experiencias, com valor_hora e multiplicador padrao
adc_desenv(Nome) :-
    assert(desenvolvedor(nome(Nome), especializacoes([]), experiencia([]), valor_hora(16.93), multiplicador(1.0))),
    salvar_desenv.

% Adiciona um projeto com Descricao, Prazo de Entrega, Complexidade (Facil, Intermediario, Difícil), e uma lista de requisitos
adc_projeto(Descricao, Prazo, Complexidade, Requisitos) :-
    complexidade(Complexidade, ComplAux, Horas),
    assert(projeto(descricao(Descricao), prazo(Prazo), complexidade(ComplAux), requisitos(Requisitos), horas(Horas))),
    salvar_projeto.

% Define as horas recomendadas dependendo da complexidade
complexidade("f", "Facil", 80).
complexidade("i", "Intermediario", 160).
complexidade("d", "Dificil", 240).

% Adiciona uma especialização no Desenvolvedor em questão
adc_especializacao(Desenvolvedor, Especializacao) :-
    (desenvolvedor(nome(Desenvolvedor), especializacoes(ListaEsp), Xp, Vh, multiplicador(Mult)) ->
        append(ListaEsp, [Especializacao], Resultante),
        MultAux is Mult+0.2,
        retract(desenvolvedor(nome(Desenvolvedor), especializacoes(ListaEsp), Xp, Vh, multiplicador(Mult))),
        assert(desenvolvedor(nome(Desenvolvedor), especializacoes(Resultante), Xp, Vh, multiplicador(MultAux))),
        salvar_desenv
    ;
        write("Desenvolvedor nao cadastrado!"),nl).

% Adiciona uma experiencia no Desenvolvedor em questão, a experiencia é uma lista contendo uma descrição, data de inicio e data final respectivamente
adc_experiencia(Desenvolvedor, Experiencia, Meses) :-
    (desenvolvedor(nome(Desenvolvedor), Esp, experiencia(ListaXp), Vh, multiplicador(Mult)) ->
        append(ListaXp, [Experiencia], Resultante),
        MultAux is (Mult+(0.01*Meses)),
        retract(desenvolvedor(nome(Desenvolvedor), Esp, experiencia(ListaXp), Vh, multiplicador(Mult))),
        assert(desenvolvedor(nome(Desenvolvedor), Esp, experiencia(Resultante), Vh, multiplicador(MultAux))),
        salvar_desenv
    ;
        write("Desenvolvedor nao cadastrado!"),nl).

% Calcula o número de meses de experiencia dadas uma data de inicio e uma data final
tempo_de_servico([MesInicio, AnoInicio], [MesInicio, AnoFim], R) :- R is (AnoFim - AnoInicio) * 12,!.
tempo_de_servico([MesInicio, AnoInicio], [MesFim, AnoInicio], R) :- R is MesFim - MesInicio,!.
tempo_de_servico([MesInicio, AnoInicio], [MesFim, AnoFim], R) :-
    Mes is ((12 - MesInicio) + (MesFim)),
    Ano is ((AnoFim - AnoInicio) * 12),
    R is (Mes + Ano).

% salva as modificações dos fatos dinamicos sobre desenvolvedor no banco de dados
salvar_desenv :-
    telling(OutputStream),
    tell('desenvolvedor.pl'),
    listing(desenvolvedor),
    told,
    tell(OutputStream).

% salva as modificações dos fatos dinamicos sobre projeto no banco de dados
salvar_projeto :-
    telling(OutputStream),
    tell('projeto.pl'),
    listing(projeto),
    told,
    tell(OutputStream).

% salva as modificações dos fatos dinamicos sobre historico no banco de dados
salvar_historico :-
    telling(OutputStream),
    tell('historico.pl'),
    listing(historico),
    told,
    tell(OutputStream).

% Consulta para listar os projetos
listar_projetos :-
    findall(Projeto, projeto(descricao(Projeto), _, _, _, _), Projetos),
    writeln('Projetos Cadastrados:'),
    writeln("--------------------"),
    listar_projetos(Projetos).

% Lista todos os projetos existentes no banco de dados
listar_projetos([]).
listar_projetos([Projeto | Projetos]) :-
    projeto(descricao(Projeto), prazo(Prazo), complexidade(Complexidade), requisitos(Requisitos), horas(Horas)),
    write("Descricao: "), writeln(Projeto),
    write("Prazo: "), writeln(Prazo),
    write("Complexidade: "), writeln(Complexidade),
    write("Requisitos: "), writeln(Requisitos),
    write("Horas: "), writeln(Horas),
    writeln("--------------------"),
    listar_projetos(Projetos).

% Lista um Projeto expecifico
listar_projeto(Projeto) :-
    projeto(descricao(Projeto), prazo(Prazo), complexidade(Complexidade), requisitos(Requisitos), horas(Horas)),
    write("Descricao: "), writeln(Projeto),
    write("Prazo: "), writeln(Prazo),
    write("Complexidade: "), writeln(Complexidade),
    write("Requisitos: "), writeln(Requisitos),
    write("Horas: "), writeln(Horas),
    writeln("--------------------").

% lista o historico de projetos de um desenvolvedor
listar_historico(Desenvolvedor) :-
    (desenvolvedor(nome(Desenvolvedor), _, _, _, _) ->
        findall(Projeto, historico(desenvolvedor(Desenvolvedor), projeto(Projeto), _), Projetos),
        writeln('Historico: '),
        listar_proj_historico(Projetos)
    ;
        writeln("Desenvolvedor nao cadastrado!")
    ).

% Lista todos os projetos de uma lista
listar_proj_historico([]).
listar_proj_historico([Projeto | Projetos]) :-
    listar_projeto(Projeto),
    listar_proj_historico(Projetos).

% Lista informacoes de um dado desenvolvedor caso exista, caso contrario, uma mensagem informa que nao esta cadastrado
listar_desenvolvedor(Desenvolvedor) :-
    (desenvolvedor(nome(Desenvolvedor), especializacoes(Esp), experiencia(Xp), valor_hora(VH), _) ->
        write("Especializacoes: "), writeln(Esp),
        writeln("Experiencia: "), listar_experiencia(Xp),
        write("Valor/Hora: "), writeln(VH)
    ;
        writeln("Desenvolvedor nao cadastrado!")).

% Lista todas as experiencias de um desenvolvedor mostrando descricao, data de inicio e data final
listar_experiencia([]).
listar_experiencia([Xp | Xps]) :-
    Xp = [Instituicao, DataInicio, DataFinal],
    write("Instituicao/Curso: "), write(Instituicao), write(" | Data Inicio: "), write(DataInicio), write(" | Data Final: "), writeln(DataFinal),
    listar_experiencia(Xps).

% verifica existencia de Desenvolvedor e Projeto e cria historico, caso os dois existam, e o Desenvolvedor atenda aos requisitos
optar_projeto(Desenvolvedor, Projeto) :-
    (desenvolvedor(nome(Desenvolvedor), especializacoes(Esp), _, valor_hora(VH), multiplicador(Mult)) ->
        (projeto(descricao(Projeto), _, _, requisitos(Req), horas(Horas)) ->
            Custo is VH * Mult * Horas,
            (checar_requisitos(Req, Esp) ->
                assert(historico(desenvolvedor(Desenvolvedor), projeto(Projeto), custo(Custo))),
                salvar_historico,
                write('O desenvolvedor '), write(Desenvolvedor), write(' optou por desenvolver o projeto '), writeln(Projeto),
                write('Valor a ser cobrado: '), writeln(Custo)
            ;
                writeln('O desenvolvedor nao atende aos requisitos do projeto!')
            )
        ;
            writeln('Projeto nao cadastrado!')
        )
    ;
        writeln('Desenvolvedor nao cadastrado!')
    ).

% Verifica se todos os elementos de uma lista estao contidos em outra
checar_requisitos([Requisito | []], Especializacoes) :- elem_lista(Requisito, Especializacoes).
checar_requisitos([Requisito | Requisitos], Especializacoes) :-
    elem_lista(Requisito, Especializacoes),
    checar_requisitos(Requisitos, Especializacoes).

% Verifica se elemento esta na lista
elem_lista(Elem, [Elem | _]) :- !.
elem_lista(Elem, [_ | Cauda]) :- elem_lista(Elem, Cauda).
