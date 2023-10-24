:- consult('desenvolvedor.pl').
:- dynamic desenvolvedor/5.
:- consult('projeto.pl').

adc_desenv(Nome) :-
    open('desenvolvedor.pl', append, Stream),
    write(Stream, 'desenvolvedor(nome(\''),
    write(Stream, Nome),
    write(Stream, '\'), especializacoes([]), experiencia([]), valor_hora(16.93), multiplicador(1.0)).'),
    nl(Stream),
    close(Stream).

adc_projeto(Descricao, Prazo, Complexidade, Requisitos) :-
    complexidade(Complexidade, ComplAux, Horas),
    open('projeto.pl', append, Stream),
    write(Stream, 'projeto(descricao(\''), write(Stream, Descricao), write(Stream, '\'), '),
    write(Stream, 'prazo(\''), write(Stream, Prazo), write(Stream, '\'), '),
    write(Stream, 'complexidade(\''), write(Stream, ComplAux), write(Stream, '\'), '),
    write(Stream, 'requisitos('), write(Stream, Requisitos), write(Stream, '), '),
    write(Stream, 'horas('), write(Stream, Horas), write(Stream, ')'),
    write(Stream, ').'), nl(Stream),
    close(Stream).

complexidade(f, 'Facil', 80).
complexidade(i, 'Intermediario', 160).
complexidade(d, 'Dificil', 240).

adc_especializacao(Desenvolvedor, Especializacao) :-
    consult('desenvolvedor.pl'),
    (desenvolvedor(nome(Desenvolvedor), especializacoes(ListaEsp), Xp, Vh, multiplicador(Mult)) ->
        append(ListaEsp, [Especializacao], Resultante),
        MultAux is Mult+0.2,
        retract(desenvolvedor(nome(Desenvolvedor), especializacoes(ListaEsp), Xp, Vh, multiplicador(Mult))),
        assert(desenvolvedor(nome(Desenvolvedor), especializacoes(Resultante), Xp, Vh, multiplicador(MultAux))),
        salvar_desenv
    ;
        write('Desenvolvedor nao cadastrado!')).

adc_experiencia(Desenvolvedor, Experiencia, Meses) :-
    consult('desenvolvedor.pl'),
    (desenvolvedor(nome(Desenvolvedor), Esp, experiencia(ListaXp), Vh, multiplicador(Mult)) ->
        append(ListaXp, [Experiencia], Resultante),
        MultAux is (Mult+(0.01*Meses)),
        retract(desenvolvedor(nome(Desenvolvedor), Esp, experiencia(ListaXp), Vh, multiplicador(Mult))),
        assert(desenvolvedor(nome(Desenvolvedor), Esp, experiencia(Resultante), Vh, multiplicador(MultAux))),
        salvar_desenv
    ;
        write('Desenvolvedor nao cadastrado')).

tempo_de_servico([MesInicio, AnoInicio], [MesInicio, AnoFim], R) :- R is (AnoFim - AnoInicio) * 12,!.
tempo_de_servico([MesInicio, AnoInicio], [MesFim, AnoInicio], R) :- R is MesFim - MesInicio,!.
tempo_de_servico([MesInicio, AnoInicio], [MesFim, AnoFim], R) :-
    Mes is ((12 - MesInicio) + (MesFim)),
    Ano is ((AnoFim - AnoInicio) * 12),
    R is (Mes + Ano).

salvar_desenv :-
    telling(OutputStream),
    tell('desenvolvedor.pl'),
    listing(desenvolvedor),
    told,
    tell(OutputStream).

console_adc_desenv :-
    consult('desenvolvedor.pl'),
    write('Nome: '),
    read(Nome),
    (desenvolvedor(nome(Nome), _, _, _, _) ->
        write('Desenvolvedor ja cadastrado!')
    ;
        adc_desenv(Nome)).

console_adc_espec :-
    consult('desenvolvedor.pl'),
    write('Nome (entre aspas simples): '), nl,
    read(Nome),
    write('Especializacao (entre aspas simples): '), nl,
    read(Espec),
    (desenvolvedor(nome(Nome), _, _, _, _) ->
        adc_especializacao(Nome, Espec)
    ;
        write('Desenvolvedor nao cadastrado!')).

console_adc_experiencia :-
    consult('desenvolvedor.pl'),
    write('Nome (entre aspas simples): '), nl,
    read(Nome),
    write('Instituicao/Curso (entre aspas simples): '), nl,
    read(Descricao), nl,
    write('Data de inicio (Formato: MM/AAAA) (entre aspas simples): '),
    read(DataInicio),
    write('Data Final (Formato: MM/AAAA) (entre aspas simples): '),
    read(DataFinal),
    split_string(DataInicio, '/', ' ', DataInicioAux),
    split_string(DataFinal, '/', ' ', DataFinalAux),
    DataInicioAux = [MI,AI], DataFinalAux = [MF,AF],
    number_string(MIAux, MI), number_string(MFAux, MF), number_string(AIAux, AI), number_string(AFAux, AF),
    tempo_de_servico([MIAux,AIAux], [MFAux,AFAux], R),
    Experiencia = [Descricao, DataInicio, DataFinal],
    adc_experiencia(Nome, Experiencia, R).

console_adc_projeto :-
    consult('projeto.pl'),
    write('Descricao (entre aspas simples):'), nl, read(Descricao),
    write('Prazo (entre aspas simples): '), nl, read(Prazo),
    write('Complexidade (f = Facil; i = Intermediario; d = Dificil): '), nl, read(Complexidade),
    write('Requisitos (entre aspas simples e separados por virgulas): '), nl, read(Requisitos),
    split_string(Requisitos, ',', ' ', ReqAux),
    (projeto(descricao(Descricao), _, _, _, _) ->
        write('Projeto ja cadastrado!')
    ;
        adc_projeto(Descricao, Prazo, Complexidade, ReqAux)).
