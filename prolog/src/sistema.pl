:- consult('desenvolvedor.pl').
:- consult('projeto.pl').

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
        write("Desenvolvedor nao cadastrado!")).

% Adiciona uma experiencia no Desenvolvedor em questão, a experiencia é uma lista contendo uma descrição, data de inicio e data final respectivamente
adc_experiencia(Desenvolvedor, Experiencia, Meses) :-
    (desenvolvedor(nome(Desenvolvedor), Esp, experiencia(ListaXp), Vh, multiplicador(Mult)) ->
        append(ListaXp, [Experiencia], Resultante),
        MultAux is (Mult+(0.01*Meses)),
        retract(desenvolvedor(nome(Desenvolvedor), Esp, experiencia(ListaXp), Vh, multiplicador(Mult))),
        assert(desenvolvedor(nome(Desenvolvedor), Esp, experiencia(Resultante), Vh, multiplicador(MultAux))),
        salvar_desenv
    ;
        write("Desenvolvedor nao cadastrado!")).

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
