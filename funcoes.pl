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

% -------------       Funções auxiliares       ----------------------

% remove repetidos

takeOutReps([],E).
takeOutReps([A|B],E) :- add(A,E), takeOutReps(B,E).


% adiciona a uma lista de elementos um elemento que esta não tem

add(A,[]) :- (A,[]).
add(A,[A|E]).
add(A,[B|E]) :- add(A,E).

% -------------       Funções auxiliares       ----------------------

% -------------       1º Tópico       ----------------------
% -------------       1º Tópico       ----------------------


% -------------       2º Tópico       ----------------------



% -------------       2º Tópico       ----------------------


% -------------       3º Tópico       ----------------------


% dá todos os serviços existentes

lerServicos(X,E) :- servicos(X,L),
                    findall((C),member(servico(_,C,_,_),L),D), takeOutReps(D,E).


% -------------       3º Tópico       ----------------------


% -------------       4º Tópico       ----------------------


% dá todos os utentes existentes:

% por Nome:

clienteNome(Nome,D) :- utentes(L), findall((Nome,Idade,Cidade), member(utente(_,Nome,Idade,Cidade),L),D).


% por Local:

clienteLocal(Cidade,D) :- utentes(L), findall((Nome,Idade,Cidade), member(utente(_,Nome,Idade,Cidade),L),D).



% dá todos os serviços existentes: ------------------------------------------------------

% por Nome:

servicoNome(Nome,D) :- servicos(L), findall((Id,Nome), member(servico(Id,Nome,_,_),L),D).


% por Id:

servicoId(Id,D) :-  servicos(L), findall((Id,Nome), member(servico(Id,Nome,_,_),L),D).


% por Instituição:

servicoInstituicao(Inst,D) :- servicos(L), findall((Id,Nome), member(servico(Id,Nome,Inst,_),L),D).


% por Local:

servicoLocal(Local,D) :- servicos(L), findall((Id,Nome), member(servico(Id,Nome,_,Local),L),D).



% dá todas as consultas existentes: -----------------------------------------------------

% por id de Utente:

consultaUtente(IdUtente,D) :- consultas(L), findall((Data,IdUtente,IdInstituicao,Custo), member(consulta(Data,IdUtente,IdInstituicao,Custo),L),D).


% por id de Instituição:

consultaInstituicao(IdInstituicao,D) :- consultas(L), findall((Data,IdUtente,IdInstituicao,Custo), member(consulta(Data,IdUtente,IdInstituicao,Custo),L),D).

% por data:

consultaData(data(D,M,A),D) :- consultas(L), findall((data(D,M,A),IdUtente,IdInstituicao,Custo), member(consulta(data(D,M,A),IdUtente,IdInstituicao,Custo),L),D).


% com preço inferior a X: (ainda não funciona)

consultaCustosInferiores(CustoMax,D) :- consultas(L), menores(CustoMax,L,D).


menores(A,[],G).
menores(A,[consulta(C,D,E,F)|B],G) :- A >= F, menores(A,B,(consulta(C,D,E,F),G)).
menores(A,[consulta(C,D,E,F)|B],G) :- A < F, menores(A,B,G).

% -------------       4º Tópico       ----------------------

% -------------       5º Tópico       ----------------------
% -------------       5º Tópico       ----------------------


% -------------       6º Tópico       ----------------------
% -------------       6º Tópico       ----------------------


% -------------       7º Tópico       ----------------------
% -------------       7º Tópico       ----------------------


% -------------       8º Tópico       ----------------------
% -------------       8º Tópico       ----------------------
