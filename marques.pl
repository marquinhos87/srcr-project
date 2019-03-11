% tipos de factos

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

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Tópico 7
%Extensão do predicado de identificarServiços: Tipo,Nome,Lista -> {V,F}

identificarServiços("U",Uten,D) :- consultas(L),
									findall(IdServ,member(consulta(_,Uten,IdServ,_),L),X),
									servicos(T),
									findall((IdServ,D,I,C),member(servico(IdServ,_,_,_),T),D).
identificarServiços("I",Inst,D) :- servicos(L),
									findall((IdServ,D,Inst,C),member(servico(_,_,Inst,_),L),D).
identificarServiços("C",Local,D) :- servicos(L),
									findall((IdServ,D,I,Local),member(servico(_,_,_,Local),L),D).
identificarServiços(X,_,_) :- !, fail.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Tópico 6
%Extensão do predicado de identificarUtentes: Tipo,Nome,Lista -> {V,F}

identificarUtentes("S",Serv,D) :- consultas(L),
								findall((IdU,Serv),member(consulta(_,IdU,Serv,_),L),_),
								utentes(T),
								findall((IdU,N,I,L),member(utente(IdU,_,_,_),T),D).
identificarUtentes("I",Inst,D) :- consultas(L),
								findall((IdU,IdS),member(consulta(_,IdU,IdS,_),L),_),
								servicos(Z),
								findall(Inst,member(servico(IdS,_,Inst,_),Z),_),
								utentes(T),
								findall((IdU,N,I,L),member(utente(IdU,_,_,_),T),D).
identificarUtentes(X,_,_) :- !, fail.