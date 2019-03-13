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

servico(1,urgencias,sos1,Braga).
servico(2,autopsias,sos2,Braga).
servico(3,geral,sos2,Braga).
servico(4,especialidade,sos3,Braga).


% Extenção do predicado consulta: Data, IdUt, IdServ, Custo -> { V, F }

consulta(data(10,10,98),1,4,60).
consulta(data(24,10,98),1,1,23).
consulta(data(10,10,98),2,2,40).
consulta(data(10,10,98),3,2,40).
consulta(data(10,10,98),4,3,30).


%	funções auxiliares:

comprimento([],0).
comprimento([H|T], R) :- comprimento(T,N), R is N + 1.

% Invariante Estrutural:  nao permitir a insercao de conhecimento repetido
%

+utente(ID,N,I,C) :: (solucoes( (ID,N,I,C), (utente(ID,N,I,C)), S),
					 comprimento( S,N ),
					 N == 1
					 ).

+filho( F,P ) :: (solucoes( (F,P),(filho( F,P )),S ),
                  comprimento( S,N ), 
				  N == 1
                  ).


comprimento([],0).
comprimento([H|T], R) :- comprimento(T,N), R is N + 1.

teste([]).
teste([I|L]) :- I,teste(L).

insercao(T) :- assert(T).
insercao(T) :- retract(T), !, fail.

solucoes(N,Condicao,S) :- findall(N,Condicao,S).

evolucao( Termo ) :- solucoes(Invariante, +Termo::Invariante, Lista),
					 insercao(Termo),
					 teste(Lista).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado registarUtente: Id,Nome,Idade,Cidade -> {V,F}

registarUtente(ID,N,I,C) = evolucao(utente(ID,N,I,C)).

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

removerConsulta(D,IU,IS,C).

