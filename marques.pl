% tipos de factos

:- dynamic(utentes/1).
:- dynamic(servicos/1).
:- dynamic(consultas/1).

% Extenção do predicado utente:  IdUt, Nome, Idade, Cidade -> { V, F }

utente(1,joao,22,lisboa),
utente(2,carlos,15,beja),
utente(3,alfredo,45,braga),
utente(4,dario,72,lisboa),
utente(5,quim,25,braga)

% Extenção do predicado servico: IdServ, Descrição, Instituição, Cidade -> { V, F }

servico(1,urgencias,sos1,Braga),
servico(2,autopsias,sos2,Braga),
servico(3,geral,sos2,Braga),
servico(4,especialidade,sos3,Braga)

% Extenção do predicado consulta: Data, IdUt, IdServ, Custo -> { V, F }

consulta(data(10,10,98),1,4,60),
consulta(data(24,10,98),1,1,23),
consulta(data(10,10,98),2,2,40),
consulta(data(10,10,98),3,2,40),
consulta(data(10,10,98),4,3,30)

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Tópico 6
%Extensão do predicado de identificarUtentes: Tipo,Nome,Lista -> {V,F}

identificarUtentes(Serv,L) :- findall(utente(A,B,C,D),(consulta(_,A,G,_),Serv =:= G),L).
identificarUtentes(Inst,L) :- findall(utente(A,B,C,D),(consulta(_,F,G,_),servico(G,_,K,_),K =:= Inst),L).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Tópico 7
%Extensão do predicado de identificarServiços: Tipo,Nome,Lista -> {V,F}

identificarServiços(Uten,L) :- findall(servico(A,B,C,D),(consulta(_,F,G,_),Uten =:= F,G =:= A),L). 
identificarServiços(Inst,L) :- findall(servico(A,B,C,D),(servico(_,_,G,_),Inst =:= G),L).
identificarServiços(Local,L) :- findall(servico(A,B,C,D),(servico(_,_,_,H),Local =:= H),L).