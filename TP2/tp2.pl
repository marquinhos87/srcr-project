%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Base de Conhecimento com informação sobre centro de saúde.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%SICStus PROLOG: Declarações iniciais
:- set_prolog_flag(discontiguous_warnings,off).
:- set_prolog_flag(single_var_warnings,off).
:- set_prolog_flag(unknown,fail).
%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Tipos de factos
:- dynamic(utente/4).
:- dynamic(servico/4).
:- dynamic(consulta/6).
:- dynamic(data/3).
:- dynamic(medico/5).

:- op(900,xfy,'::').
%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Extenção do predicado utente: IdUt,Nome,Idade,Cidade -> {V,F,D}
utente(1,joao,22,lisboa).
utente(2,carlos,15,beja).
utente(3,alfredo,45,braga).
utente(4,dario,72,lisboa).
utente(5,joaquim,25,braga).
utente(6,henrique,20,braga).
utente(7,ricardo,20,braga).
utente(8,bruno,44,aveiro).
utente(9,nuno,33,porto).
utente(10,pedro,70,coimbra).
%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Extenção do predicado servico: IdServ,Descrição,Instituição,Cidade -> {V,F,D}
servico(1,urgencias,hospital_braga,braga).
servico(2,autopsias,hospital_braga,braga).
servico(3,geral,hospital_braga,braga).
servico(4,analises,hospital_trofa_1,braga).
servico(5,radiografia,hospital_lisboa,lisboa).
servico(6,dentista,hospital_coimbra,coimbra).
servico(7,ecografia,hospital_aveiro,aveiro).
servico(8,fisioterapia,hospital_trofa_2,porto).
servico(9,urgencias,hospital_aveiro,aveiro).
servico(10,urgencias, hospital_porto,porto).
servico(11,radiografia,hospital_braga,braga).
servico(12,tumografia,hospital_braga, braga).
servico(13,dermatologia,hospital_coimbra,coimbra).
servico(14,rinoplastia, hospital_lisboa, lisboa).
%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Extenção do predicado consulta: Id,Data,IdUt,IdServ,IdMedico, Custo -> {V,F,D}
consulta(1,data(11,2,2019),1,1,1,15).
consulta(2,data(12,3,2018),2,2,4,20).
consulta(3,data(13,1,2019),3,3,1,25).
consulta(4,data(25,8,2017),4,1,4,15).
consulta(5,data(2,10,2007),5,15,1,30).
consulta(6,data(17,5,2018),9,8,2,30).
%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Extenção do predicado medico: Id,Nome, Idade, Especialidade, Instituição -> {V,F,D}
medico(1,jose,30,pediatria,hospital_braga).
medico(2,joao,35,radiologia,hospital_porto).
medico(3,pedro,50,ginecologia,hospital_coimbra).
medico(4,joaquim, 44,cirurgia,hospital_braga).
%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%PODEM NAO SER NECESSARIAS ALGUMAS
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Funções auxiliares

%Extensão do predicado de sum: Lista,Resultado -> {V,F}
%calcula o comprimento de uma lista
sum([],0).
sum([H|T],R) :- sum(T, S), R is S + H.

%Extensão do predicado de entre: Numero,Numero,Numero -> {V,F}
%compara se o ultimo inteiro está entre os dois primeiros
entre(A,B,C) :- A =< C, B >= C.

%Extensão do predicado de teste: Lista -> {V,F}
%testa todos os elementos da Lista
teste([]).
teste([I|L]) :- I, teste(L).

%Extensão do predicado de insercao: Termo -> {V,F}
%insere um elemento na base de conhecimento
insercao(T) :- assert(T).
insercao(T) :- retract(T), !, fail.

%Extensão do predicado de remocao: Termo -> {V,F}
%remove um elemento da base de conhecimento
remocao(T) :- retract(T).
remocao(T) :- assert(T), !, fail.

%Extensão do predicado de comprimento: Lista,Tamanho -> {V,F}
%calcula o comprimento de uma Lista
comprimento([],0).
comprimento([H|T],N) :- comprimento(T,X), N is X+1.

%Extensão do predicado de solucoes: Tipo,Condicao,Lista -> {V,F}
%utiliza o findall para encontrar todo o conhecimento que corresponda à condição
solucoes(T,C,S) :- findall(T,C,S).

%Extensão do predicado de evolucao: Termo -> {V,F}
evolucao(Termo) :- solucoes(I, +Termo::I,Lista),
				   insercao(Termo),
				   teste(Lista).

%Extensão do predicado de involucao: Termo -> {V,F}
involucao(Termo) :- solucoes(I, -Termo::I,Lista),
					remocao(Termo),
					teste(Lista).

% Extensao do meta-predicado si: Questao,Resposta -> {V,F}
%                            Resposta = {verdadeiro,falso,desconhecido}
si(Questao,verdadeiro) :- Questao.
si(Questao,falso) :- -Questao.
si(Questao,desconhecido) :- nao(Questao), nao(-Questao).
%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Invariantes Estruturais: nao permitir a insercao de conhecimento repetido

%para Utente
+utente(ID,_,_,_) :: (solucoes(ID,utente(ID,_,_,_),S),
					  comprimento(S,N),
					  N == 1
					  ).

%para Servico
+servico(ID,_,_,_) :: (solucoes(ID,servico(ID,_,_,_),S),
					   comprimento(S,N),
					   N == 1
					   ).

%para Medico
+medico(ID,_,_,_,_) :: (solucoes(ID,medico(ID,_,_,_,_),S),
					   comprimento(S,N),
					   N == 1
					   ).

%para verificar se já existe um Id de Consulta igual
+consulta(ID,_,_,_,_,_) :: (solucoes(ID,(consulta(ID,_,_,_,_,_)), S),
						   comprimento(S,N),
					       N == 1
						   ).
%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Invariantes Referenciais:

%para verificar se já existe o Utente e/ou Serviço
+consulta(ID,_,IDU,IDS,IM,_) :: (solucoes(ID, (utente(IDU,_,_,_), servico(IDS,_,I,_), medico(IM,_,_,_,I)), S),
								comprimento(S,N),
								N == 1
								).

%Apenas se pode remover utentes caso não tenham consultas associadas
-utente(Id,_,_,_) :: (solucoes( Id,(consulta(_,_,Id,_,_,_)),S ),
					  comprimento( S,N ), 
					  N == 0
                      ).

%Apenas se pode remover médicos caso não tenham consultas associadas
-medico(Id,_,_,_) :: (solucoes( Id,(consulta(_,_,_,_,Id,_)),S ),
					  comprimento( S,N ), 
					  N == 0
                      ).

%Apenas se pode remover serviços caso não tenham consultas associadas
-servico(Id,_,_,_) :: (solucoes( Id,(consulta(_,_,_,Id,_,_)),S ),
					   comprimento( S,N ), 
					   N == 0
                  	   ).

%Não convêm remover consultas por isso não o permitimos com este Invariante
-consulta(_,_,_,_,_,_) :: (no).
%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Tópico 1

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Tópico 2

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Tópico 3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Tópico 4

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Tópico 5

%--------------------------------- - - - - - - - - - -  -  -  -  -   -