%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Base de Conhecimento com informacao sobre centro de saude.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag(discontiguous_warnings,off).
:- set_prolog_flag(single_var_warnings,off).
:- set_prolog_flag(unknown,fail).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% tipos de factos

:- dynamic(utentes/4).
:- dynamic(servicos/4).
:- dynamic(consultas/5).
:- dynamic(data/3).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extenção do predicado utente: IdUt,Nome,Idade,Cidade -> {V,F}
utente(1,joao,22,lisboa).
utente(2,carlos,15,beja).
utente(3,alfredo,45,braga).
utente(4,dario,72,lisboa).
utente(5,quim,25,braga).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extenção do predicado servico: IdServ,Descrição,Instituição,Cidade -> {V,F}
servico(1,urgencias,sos1,braga).
servico(2,autopsias,sos2,braga).
servico(3,geral,sos2,braga).
servico(4,especialidade,sos3,braga).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extenção do predicado consulta: Id,Data,IdUt,IdServ,Custo -> {V,F}
consulta(1,data(10,10,98),1,4,60).
consulta(2,data(24,10,98),1,1,23).
consulta(3,data(10,10,98),2,2,40).
consulta(4,data(10,10,98),3,2,40).
consulta(5,data(10,10,98),4,3,30).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%funcoes auxiliares

%Extensão do predicado de aad: Termo,Lista -> {V,F}
%adiciona a uma lista de elementos um elemento que esta não tem
add(A,[]) :- (A,[]).
add(A,[A|_]).
add(A,[_|E]) :- add(A,E).

%Extensão do predicado de takeOutReps: Lista,Termo -> {V,F}
%remove repetidos
takeOutReps([],_).
takeOutReps([A|B],E) :- add(A,[A|B],E), takeOutReps(B,E).

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
solucoes(Tipo,Condicao,S) :- findall(Tipo,Condicao,S).

%Extensão do predicado de evolucao: Termo -> {V,F}
evolucao(Termo) :- solucoes(Invariante, +Termo::Invariante,Lista),
				   insercao(Termo),
				   teste(Lista).

%Extensão do predicado de involucao: Termo -> {V,F}
involucao(Termo) :- solucoes(Invariante, -Termo::Invariante,Lista),
					remocao(Termo),
					teste(Lista).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Invariantes Estruturais: nao permitir a insercao de conhecimento repetido
%Invariante Estrutural para Utente
+utente(ID,_,_,_) :: (solucoes( (ID,_,_,_), (utente(ID,_,_,_)), S),
					  comprimento( S,N ),
					  N == 1
					  ).

%Invariante Estrutural para Consulta
+consulta(ID,_,_,_,_) :: (solucoes( (ID,_,_,_,_), (consulta(ID,_,_,_,_)), S),
						  comprimento( S,N ),
					      N == 1
						  ).

%Invariante Estrutural para Servico
+servico(ID,_,_,_) :: (solucoes( (ID,_,_,_), (servico(ID,_,_,_)), S),
					   comprimento( S,N ),
					   N == 1
					   ).

%Invariantes Referenciais: nao permitir a remocao de conhecimento 



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Topico 1
% Extensao do predicado registarUtente: Id,Nome,Idade,Cidade -> {V,F}
registarUtente(ID,N,I,C) :- evolucao(utente(ID,N,I,C)).

% Extensao do predicado registarServiço: Id,Descrição,Instituição,Cidade -> {V,F}
registarServico(IDS,D,I,C) :- evolucao(servico(IDS,D,I,C)).

% Extensao do predicado registarConsulta: Data,IdU,IdS,Custo -> {V,F}
registarConsulta(ID,D,IU,IS,C) :- evolucao(consulta(ID,D,IU,IS,C)).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Topico 2


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Topico 3
%Extensão do predicado de lerServicos: Lista -> {V,F}
lerServicos(E) :- solucoes((C),(servico(_,_,C,_),D)), takeOutReps(D,E).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Topico 4
%Extensão do predicado de clienteNome: Nome,Lista -> {V,F}
clienteNome(Nome,D) :- solucoes((Nome,Idade,Cidade),utente(_,Nome,Idade,Cidade),D).

%Extensão do predicado de clienteLocal: Cidade,Lista -> {V,F}
clienteLocal(Cidade,D) :- solucoes((Nome,Idade,Cidade), utente(_,Nome,Idade,Cidade), D).

%Extensão do predicado de servicoNome: Nome,Lista -> {V,F}
servicoNome(Nome,D) :- solucoes((Id,Nome), servico(Id,Nome,_,_),D).

%Extensão do predicado de servicoId: Id,Lista -> {V,F}
servicoId(Id,D) :- solucoes((Id,Nome), servico(Id,Nome,_,_),D).

%Extensão do predicado de servicoInstituicao: Instituicao,Lista -> {V,F}
servicoInstituicao(Inst,D) :- solucoes((Id,Nome),servico(Id,Nome,Inst,_),D).

%Extensão do predicado de servicoLocal: Cidade,Lista -> {V,F}
servicoLocal(Local,D) :- solucoes((Id,Nome), servico(Id,Nome,_,Local),D).

%Extensão do predicado de consultaCustosSuperiores: CustoMax,Lista -> {V,F}
consultaID(Id,D) :- solucoes((Id,Data,IdUtente,IdServ,Custo), consulta(Id,Data,IdUtente,IdServ,Custo),D).

%Extensão do predicado de consultaUtente: Utente,Lista -> {V,F}
consultaUtente(IdUtente,D) :- solucoes((Id,Data,IdUtente,IdServ,Custo), consulta(Id,Data,IdUtente,IdServ,Custo),D).

%Extensão do predicado de consultaInstituicao: Instituicao,Lista -> {V,F}
consultaInstituicao(IdInstituicao,D) :- solucoes((Id,Data,IdUt,IdInstituicao,Custo), consulta(Id,Data,IdUt,IdInstituicao,Custo),D).

%Extensão do predicado de consultaData: Data,Lista -> {V,F}
consultaData(data(D,M,A),E) :- solucoes((Id,data(D2,M2,A2),IdUt,IdServ,Custo), (consulta(Id,data(D2,M2,A2),IdUt,IdServ,Custo),D2 == D,M2 == M, A2 == A),E).

%Extensão do predicado de consultaDatas: Data,Data,Lista -> {V,F}
consultaDatas(data(D1,M1,A1),data(D2,M2,A2),E) :- solucoes((Id,data(D3,M3,A3),IdUt,IdServ,Custo), (consulta(Id,data(D3,M3,A3),IdUt,IdServ,Custo),entre(A1*365+M1*30+D1,A2*365+M2*30+D2,A3*365+M3*30+D3)),E).

%Extensão do predicado de consultaCustosInferiores: CustoMax,Lista -> {V,F}
consultaCustosInferiores(CustoMax,D) :- solucoes((Id,Data,IdUt,IdServ,Custo),(consulta(Id,Data,IdUt,IdServ,Custo),Custo =< CustoMax),D).

%Extensão do predicado de consultaCustosSuperiores: CustoMax,Lista -> {V,F}
consultaCustosSuperiores(CustoMax,D) :- solucoes((Id,Data,IdUt,IdServ,Custo),(consulta(Id,Data,IdUt,IdServ,Custo),Custo >= CustoMax),D).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Topico 5


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Topico 6
%Extensão do predicado de identificarUtentesServico: Servico,Lista -> {V,F}
identificarUtentesServico(Serv,D) :- solucoes((Uten,Serv,Data),(consulta(_,Data,A,Serv,_),utente(A,Uten,_,_)),D).

%Extensão do predicado de identificarUtentesInstituicao: Cidade,Lista -> {V,F}
identificarUtentesInstituicao(Inst,D) :- solucoes((Uten,Inst,Data),(consulta(_,Data,A,G,_),servico(G,_,Inst,_),utente(A,Uten,_,_)),D).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Topico 7
%Extensão do predicado de identificarServicosUtente: Utente,Lista -> {V,F}
identificarServicosUtente(Uten,D) :- solucoes((Serv,Uten,Data),(consulta(_,Data,Uten,A,_),servico(A,Serv,_,_)),D).

%Extensão do predicado de identificarServicosInstituicao: Instituicao,Lista -> {V,F}
identificarServicosInstituicao(Inst,D) :- solucoes((Serv,Inst,Data),(consulta(_,Data,_,A,_),servico(A,Serv,Inst,_)),D).

%Extensão do predicado de identificarServicosCidade: Cidade,Lista -> {V,F}
identificarServicosCidade(Loca,D) :- solucoes((Serv,Loca,Data),(consulta(_,Data,_,A,_),servico(A,Serv,_,Loca)),D).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Topico 8
