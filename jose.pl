%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Base de Conhecimento com informacao .

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

:- dynamic(utentes/1).
:- dynamic(servicos/1).
:- dynamic(consultas/1).

% Extenção do predicado utente:  IdUt, Nome, Idade, Cidade -> { V, F }

utentes([
	utente(1,joao,22,lisboa),
	utente(2,carlos,15,beja),
	utente(3,alfredo,45,braga),
	utente(4,dario,72,lisboa),
	utente(5,quim,25,braga)
	]).



% Extenção do predicado servico: IdServ, Descrição, Instituição, Cidade -> { V, F }

servicos([
	servico(1,urgencias,sos1,Braga),
    servico(2,autopsias,sos2,Braga),
    servico(3,geral,sos2,Braga),
    servico(4,especialidade,sos3,Braga)
	]).


% Extenção do predicado consulta: Data, IdUt, IdServ, Custo -> { V, F }

consultas([
consulta(data(10,10,98),1,4,60),
consulta(data(24,10,98),1,1,23),
consulta(data(10,10,98),2,2,40),
consulta(data(10,10,98),3,2,40),
consulta(data(10,10,98),4,3,30)
	]).


% funções base para trabalho

% lê predicados da linha

ler(Filename) :- see(Filename), repeat, read(Q), file_to_list(Q,L), seen, print(L).

file_to_list(end_of_file,[]).
file_to_list(Q,[Q|L]) :- read(N), file_to_list(N,L).



% abre ficheiro e apaga o que está dentro -> escreve lista -> fecha saida para ficheiro

write_on_file(FileName,Lista) :- tell(FileName), writeList(Lista), told, print(Lista).


writeList([]) :- write('.').
writeList([A|B]) :- write(A), writeList(B).

regista(File,X) :- see(File), repeat, read(Q), file_to_list(Q,L), seen, inserir_final(X,L), write_on_file(File,L).

inserir_final([], Y, [Y]).         % Se a lista estava vazia, o resultado é [Y]
inserir_final([I|R], Y, [I|R1]) :- inserir_final(R, Y, R1).       % Inserindo o elemento Y no final do antigo resto

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado registarUtente: Id,Nome,Idade,Cidade -> {V,F}

adicionar(A,[]) :- (A,[]).
adicionar(A,[A|_]).
adicionar(A,[_|E]) :- adicionar(A,E).

registarUtente(Id,N,I,C) :- utentes(L), adicionar(utente(Id,N,I,C), L), print(L).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado registarServiço: Id,Descrição,Instituição,Cidade -> {V,F}

registarServico(Id,D,I,C).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado registarConsulta: Data,IdU,IdS,Custo -> {V,F}

registarConsulta(D,IU,IS,C).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado removerCliente: Id -> {V,F}

removerCliente(Id).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado removerServiço: Id -> {V,F}

removerServico(Id).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado removerConsulta: Data,IdU,IdS -> {V,F}

removerConsulta(D,IU,IS,C) :- consultas(L), remover(consulta(D,IU,IS,C), L, R) , print(R), consultas(R).

remover(X,[X|T],[T]).
remover(X,[Y|T],[Y|R]) :- remover(X,T,R).

