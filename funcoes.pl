% tipos de factos


% :- use_module(library(apply)).
:- dynamic(utente/4).
:- dynamic(servico/4).
:- dynamic(consulta/4).
:- dynamic(data/3).

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

consulta(data(13,23,10,10,98),1,4,60).
consulta(data(24,10,98),1,1,23).
consulta(data(10,10,98),2,2,40).
consulta(data(10,10,98),3,2,40).
consulta(data(10,10,98),4,3,30).

% -------------       Funções auxiliares       ----------------------

% remove repetidos

takeOutReps([],_).
takeOutReps([A|B],E) :- add(A,[A|B],E), takeOutReps(B,E).


% adiciona a uma lista de elementos um elemento que esta não tem

add(A,[]) :- (A,[]).
add(A,[A|_]).
add(A,[_|E]) :- add(A,E).

% -------------       Funções auxiliares       ----------------------

% -------------       1º Tópico       ----------------------
% -------------       1º Tópico       ----------------------


% -------------       2º Tópico       ----------------------


% -------------       2º Tópico       ----------------------


% -------------       3º Tópico       ----------------------


% dá todos os serviços existentes

lerServicos(E) :- findall((C),(servico(_,_,C,_),D)), takeOutReps(D,E).


% -------------       3º Tópico       ----------------------


% -------------       4º Tópico       ----------------------


% dá todos os utentes existentes:

% por Nome:

clienteNome(Nome,D) :- findall((Nome,Idade,Cidade),utente(_,Nome,Idade,Cidade),D).


% por Local:

clienteLocal(Cidade,D) :- findall((Nome,Idade,Cidade), utente(_,Nome,Idade,Cidade), D).



% dá todos os serviços existentes: ------------------------------------------------------

% por Nome:

servicoNome(Nome,D) :- findall((Id,Nome), servico(Id,Nome,_,_),D).


% por Id:

servicoId(Id,D) :- findall((Id,Nome), servico(Id,Nome,_,_),D).


% por Instituição:

servicoInstituicao(Inst,D) :- findall((Id,Nome),servico(Id,Nome,Inst,_),D).


% por Local:

servicoLocal(Local,D) :- findall((Id,Nome), servico(Id,Nome,_,Local),D).



% dá todas as consultas existentes: -----------------------------------------------------

% por id de Utente:

consultaUtente(IdUtente,D) :- findall((Data,IdUtente,IdInstituicao,Custo), consulta(Data,IdUtente,IdInstituicao,Custo),D).


% por id de Instituição:

consultaInstituicao(IdInstituicao,D) :- findall((Data,IdUtente,IdInstituicao,Custo), consulta(Data,IdUtente,IdInstituicao,Custo),D).

% por data:

consultaData(data(D,M,A),E) :- findall((data(D2,M2,A2),IdUtente,IdInstituicao,Custo), (consulta(data(D2,M2,A2),IdUtente,IdInstituicao,Custo),D2 == D,M2 == M, A2 == A),E).

% entre 2 datas:

% consultaDatas(data(D1,M1,A1),data(D2,M2,A2),E) :- findall((data(D3,M3,A3),IdUtente,IdInstituicao,Custo), (consulta(data(D3,M3,A3),IdUtente,IdInstituicao,Custo),(A3 < A2, A3 > A1; A3 == A1, M3 > M1; A3 == A2 , M3 < M2;A3 == A1, M3 == M1 , D3 >= D1; A3 == A2 , M3 == M2, D3 =< D2)),E).

% com preço inferior ou igual a X:

consultaCustosInferiores(CustoMax,D) :- findall((Data, IdUt, IdServ, Custo),(consulta(Data, IdUt, IdServ, Custo),Custo =< CustoMax),D).

% com preço superior ou igual a X:

consultaCustossUPeriores(CustoMax,D) :- findall((Data, IdUt, IdServ, Custo),(consulta(Data, IdUt, IdServ, Custo),Custo >= CustoMax),D).



% -------------       4º Tópico       ----------------------

% -------------       5º Tópico       ----------------------
% -------------       5º Tópico       ----------------------


% -------------       6º Tópico       ----------------------
% -------------       6º Tópico       ----------------------


% -------------       7º Tópico       ----------------------
% -------------       7º Tópico       ----------------------


% -------------       8º Tópico       ----------------------
% -------------       8º Tópico       ----------------------
