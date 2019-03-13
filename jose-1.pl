%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Base de Conhecimento com informacao .

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

:- op( 900,xfy,'::' ).
:- dynamic(utente/4).
:- dynamic(servico/4).
:- dynamic(consulta/4).

% Extenção do predicado utente:  IdUt, Nome, Idade, Cidade -> { V, F }

utente(1,joao,22,lisboa).
utente(2,carlos,15,beja).
utente(3,alfredo,45,braga).
utente(4,dario,72,lisboa).
utente(5,quim,25,braga).

% Extenção do predicado servico: IdServ, Descrição, Instituição, Cidade -> { V, F }

servico(1,urgencias,sos1,braga).
servico(2,autopsias,sos2,braga).
servico(3,geral,sos2,braga).
servico(4,especialidade,sos3,braga).

% Extenção do predicado consulta: ID, Data, IdUt, IdServ, Custo -> { V, F }

consulta(1, data(10,10,98),1,4,60).
consulta(2, data(24,10,98),1,1,23).
consulta(3, data(10,10,98),2,2,40).
consulta(4, data(10,10,98),3,2,40).
consulta(5, data(10,10,98),4,3,30).

%	funções auxiliares:

comprimento([],0).
comprimento([H|T], R) :- comprimento(T,N), R is N + 1.

% Invariante Estrutural:  nao permitir a insercao de conhecimento repetido
%

+utente(ID,_,_,_) :: (solucoes( (ID,_,_,_), (utente(ID,_,_,_)), S),
					 comprimento( S,N ),
					 N == 1
					 ).
+consulta(ID,_,_,_,_) :: (solucoes( (ID,_,_,_,_), (consulta(ID,_,_,_,_)), S),
						comprimento( S,N ),
						N == 1
						).

+servico(ID,_,_,_) :: (solucoes( (ID,_,_,_), (servico(ID,_,_,_)), S),
						comprimento( S,N ),
						N == 1
						).


comprimento([],0).
comprimento([H|T], R) :- comprimento(T,N), R is N + 1.

teste([]).
teste([I|L]) :- I,teste(L).

insercao(T) :- assert(T).
insercao(T) :- retract(T), !, fail.

remocao(T) :- retract(T).
remocao(T) :- assert(T), !, fail.

nao(T) :- T,insucesso.
nao(T).

solucoes(N,Condicao,S) :- findall(N,Condicao,S).

evolucao( Termo ) :- solucoes(Invariante, +Termo::Invariante, Lista),
					insercao(Termo),
					teste(Lista).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado registarUtente: Id,Nome,Idade,Cidade -> {V,F}

registarUtente(ID,N,I,C) :- evolucao(utente(ID,N,I,C)).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado registarServiço: Id,Descrição,Instituição,Cidade -> {V,F}

registarServico(IDS,D,I,C) :- evolucao(servico(IDS,D,I,C)).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado registarConsulta: Data,IdU,IdS,Custo -> {V,F}

registarConsulta(ID,D,IU,IS,C) :- evolucao(consulta(ID,D,IU,IS,C)).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado removerCliente: Id -> {V,F}

removerCliente(Id).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado removerServiço: Id -> {V,F}

removerServico(Id).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado removerConsulta: Data,IdU,IdS -> {V,F}

removerConsulta(D,IU,IS,C).

