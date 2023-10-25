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
    %consult('desenvolvedor.pl'),
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
    %consult('desenvolvedor.pl'),
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
tempo_de_servico([MesInicio, AnoInicio], [MesInicio, AnoFim], R) :- R is MesInicio - MesInicio,!.
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

% Lê os dados do console para adicionar um desenvolvedor
console_adc_desenv :-
    %consult('desenvolvedor.pl'),
    write("Nome: "),
    read_line_to_string(user_input, Nome),
    (desenvolvedor(nome(Nome), _, _, _, _) ->
        write("Desenvolvedor ja cadastrado!")
    ;
        adc_desenv(Nome)).

% Lê os dados do console para adicionar uma especialização em um desenvolvedor
console_adc_espec :-
    %consult('desenvolvedor.pl'),
    write("Nome: "), nl,
    read_line_to_string(user_input, Nome),
    write("Especializacao: "), nl,
    read_line_to_string(user_input, Espec),
    (desenvolvedor(nome(Nome), _, _, _, _) ->
        adc_especializacao(Nome, Espec)
    ;
        write("Desenvolvedor nao cadastrado!")).

% Lê os dados do console para adicionar uma experiencia em um desenvolvedor
console_adc_experiencia :-
    %consult('desenvolvedor.pl'),
    write("Nome: "), nl,
    read_line_to_string(user_input, Nome),
    write("Instituicao/Curso: "), nl,
    read_line_to_string(user_input, Descricao), nl,
    write("Data de inicio (Formato: MM/AAAA): "),
    read_line_to_string(user_input, DataInicio),
    write("Data Final (Formato: MM/AAAA): "),
    read_line_to_string(user_input, DataFinal),
    split_string(DataInicio, '/', ' ', DataInicioAux),
    split_string(DataFinal, '/', ' ', DataFinalAux),
    DataInicioAux = [MI,AI], DataFinalAux = [MF,AF],
    number_string(MIAux, MI), number_string(MFAux, MF), number_string(AIAux, AI), number_string(AFAux, AF),
    tempo_de_servico([MIAux,AIAux], [MFAux,AFAux], R),
    Experiencia = [Descricao, DataInicio, DataFinal],
    adc_experiencia(Nome, Experiencia, R).

% Lê os dados do console para adicionar um projeto ao banco de dados
console_adc_projeto :-
    %consult('projeto.pl'),
    write("Descricao: "), nl,
    read_line_to_string(user_input, Descricao),
    write("Prazo: "), nl,
    read_line_to_string(user_input, Prazo),
    write("Complexidade (f = Facil; i = Intermediario; d = Dificil): "), nl,
    read_line_to_string(user_input, Complexidade),
    write("Requisitos (separados por virgulas): "), nl,
    read_line_to_string(user_input, Requisitos),
    split_string(Requisitos, ',', ' ', ReqAux),
    (projeto(descricao(Descricao), _, _, _, _) ->
        write("Projeto ja cadastrado!")
    ;
        adc_projeto(Descricao, Prazo, Complexidade, ReqAux)).
