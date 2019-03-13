% consult('cadinho.pl').

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Base de Conhecimento com informacao .

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

:- dynamic(utente/4).
:- dynamic(consulta/4).
:- dynamic(servico/4).

:- op( 900,xfy,'::' ).

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


% Extenção do predicado consulta: Data, IdUt, IdServ, Custo -> { V, F }
consulta(data(10,10,98),1,4,60).
consulta(data(24,10,98),1,1,23).
consulta(data(10,10,98),2,2,40).
consulta(data(10,10,98),3,2,40).
consulta(data(10,10,98),4,3,30).


% Invariante Estrutural:  nao permitir a insercao de conhecimento
%                         repetido

% Apenas se pode remover utentes caso não tenham consultas associadas
-utente(Id,_,_,_) :: (
					solucoes( Id,(consulta(_,Id,_,_)),S ),
					comprimento( S,N ), 
					N == 0
                  ).

% Apenas se pode remover serviços caso não tenham consultas associadas
-servico(Id,_,_,_) :: (
					solucoes( Id,(consulta(_,_,Id,_)),S ),
					comprimento( S,N ), 
					N == 0
                  ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que permite a involucao do conhecimento

solucoes(I,C, S) :- findall(I,C,S).

remocao(T) :- retract(T).
remocao(T) :- assert(T), !, fail.

teste([]).
teste([H|T]) :- H, teste(T).

comprimento([],0).
comprimento([H|T],N) :- comprimento(T,X), N is X+1.

involucao( Termo ) :-
	solucoes(Invariante, -Termo :: Invariante, L),
	remocao(Termo),
	teste(L).


%  Identificar serviços prestados por instituição/cidade/datas/custo;
servPrestPorInst(Inst, S) :- solucoes(servico(IdServ, Desc, Inst, Cid),(servico(IdServ, Desc, Inst, Cid)),S).
servPrestPorCidade(Cid, S) :- solucoes(servico(IdServ, Desc, Inst, Cid),(servico(IdServ, Desc, Inst, Cid)),S).

entre(A,B,C) :- A =< C, B >= C.

servPrestPorDatas(data(D1,M1,A1), data(D2,M2,A2), S) :- solucoes(servico(IdServ, Desc, Inst, Cid),(servico(IdServ, Desc, Inst, Cid),consulta(data(D3,M3,A3),_,IdServ,_),entre(A1*365+M1*30+D1,A2*365+M2*30+D2,A3*365+M3*30+D3)),S).
servPrestPorCusto(Custo, S) :- solucoes(servico(IdServ, Desc, Inst, Cid),(servico(IdServ, Desc, Inst, Cid), consulta(_,_,IdServ,Custo)),S).
