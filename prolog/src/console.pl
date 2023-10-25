:- consult('sistema.pl').

% Lê os dados do console para adicionar um desenvolvedor
console_adc_desenv :-
    write("Nome: "),
    read_line_to_string(user_input, Nome),
    (desenvolvedor(nome(Nome), _, _, _, _) ->
        write("Desenvolvedor ja cadastrado!")
    ;
        adc_desenv(Nome)).

% Lê os dados do console para adicionar uma especialização em um desenvolvedor
console_adc_espec :-
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
