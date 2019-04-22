%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Base de Conhecimento com informação sobre centro de saúde.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Trabalho Prático

	% Henrique José Faria Carvalho A82200
	% João Paulo Oliveira de Andrade Marques A81826
	% José André Martins Pereira A82880
	% Ricardo André Gomes Petronilho A81744

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
:- dynamic(excecao/1).

:- op(900,xfy,'::').
%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Funções auxiliares

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Extensão do predicado de teste: Lista -> {V,F}
%testa todos os elementos da Lista
teste([]).
teste([I|L]) :- I, teste(L).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Extensão do predicado de insercao: Termo -> {V,F}
%insere um elemento na base de conhecimento
insercao(T) :- assert(T).
insercao(T) :- retract(T), !, fail.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Extensão do predicado de remocao: Termo -> {V,F}
%remove um elemento da base de conhecimento
remocao(T) :- retract(T).
remocao(T) :- assert(T), !, fail.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Extensão do predicado de comprimento: Lista,Tamanho -> {V,F}
%calcula o comprimento de uma Lista
comprimento([],0).
comprimento([H|T],N) :- comprimento(T,X), N is X+1.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Extensão do predicado de solucoes: Tipo,Condicao,Lista -> {V,F}
%utiliza o findall para encontrar todo o conhecimento que corresponda à condição
solucoes(T,C,S) :- findall(T,C,S).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Extensão do predicado de involucao: Termo -> {V,F}
involucao(Termo) :- solucoes(I, -Termo::I,Lista),
					remocao(Termo),
					teste(Lista).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado demo: Questao , Resposta -> {V,F}
%                            Resposta = {verdadeiro,falso,desconhecido}
demo(Questao,verdadeiro) :- Questao.
demo(Questao,falso) :- -Questao.
demo(Questao,desconhecido) :- nao(Questao), nao(-Questao).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}
nao(Questao) :- Questao, !, fail.
nao(Questao).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Tópico 1 -> Conhecimento Positivo e Negativo

% Conhecimento Positivo
%Extenção do predicado utente: IdUt,Nome,Idade,Cidade -> {V,F}
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

%Extenção do predicado servico: IdServ,Descrição,Instituição,Cidade -> {V,F}
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

%Extenção do predicado consulta: Id,Data,IdUt,IdServ,IdMedico, Custo -> {V,F}
consulta(1,data(11,2,2019),1,1,1,15).
consulta(2,data(12,3,2018),2,2,4,20).
consulta(3,data(13,1,2019),3,3,1,25).
consulta(4,data(25,8,2017),4,1,4,15).
consulta(5,data(2,10,2007),5,15,1,30).
consulta(6,data(17,5,2018),9,8,2,30).

%Extenção do predicado medico: Id,Nome, Idade, Especialidade, Instituição -> {V,F}
medico(1,jose,30,pediatria,hospital_braga).
medico(2,joao,35,radiologia,hospital_porto).
medico(3,pedro,50,ginecologia,hospital_coimbra).
medico(4,joaquim, 44,cirurgia,hospital_braga).

% Conhecimento Negativo
%Extenção do predicado utente: IdUt,Nome,Idade,Cidade -> {V,F}
-utente(11,nuno,33,porto).
-utente(12,pedro,70,coimbra).

%Extenção do predicado servico: IdServ,Descrição,Instituição,Cidade -> {V,F}
-servico(15,dermatologia,hospital_coimbra,coimbra).
-servico(16,rinoplastia, hospital_lisboa, lisboa).

%Extenção do predicado consulta: Id,Data,IdUt,IdServ,IdMedico, Custo -> {V,F}
-consulta(7,data(15,8,2019),11,15,6,45).
-consulta(8,data(1,12,2017),12,16,5,50).

%Extenção do predicado medico: Id,Nome, Idade, Especialidade, Instituição -> {V,F}
-medico(5,joana,50,radiografia,hospital_trofa_1).
-medico(6,miguel, 44,cirurgia,hospital_porto).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Tópico 2 -> Conhecimento Imperfeito

% -------------------------------------------------------------------------------------------------------------------------------
% Conhecimento Desconhecido

% utente: IdUt,Nome,Idade,Cidade
% possíveis valores desconhecidos : Idade,Cidade

excecao(utente(A,B,C,D)) :- utente(A,B,X,D),
                            nulo(X).

excecao(utente(A,B,C,D)) :- utente(A,B,C,X),
                            nulo(X).

excecao(utente(A,B,C,D)) :- utente(A,B,X,Y),
                            nulo(X),
                            nulo(Y).


% servico: IdServ,Descrição,Instituição,Cidade
% possíveis valores desconhecidos : Descrição,Instituição

excecao(servico(A,B,C,D)) :- servico(A,X,C,D),
                             nulo(X).

excecao(servico(A,B,C,D)) :- servico(A,B,X,D),
                             nulo(X).

excecao(servico(A,B,C,D)) :- servico(A,X,Y,D),
                             nulo(X),
                             nulo(Y).


% consulta: Id,Data,IdUt,IdServ,IdMedico,Custo
% possíveis valores desconhecidos: Data,IdUt,IdMedico

excecao(consulta(A,B,C,D,E,F)) :- consulta(A,X,C,D,E,F),
                                  nulo(X).

excecao(consulta(A,B,C,D,E,F)) :- consulta(A,B,X,D,E,F),
                                  nulo(X).

excecao(consulta(A,B,C,D,E,F)) :- consulta(A,B,C,D,X,F),
                                  nulo(X).

excecao(consulta(A,B,C,D,E,F)) :- consulta(A,X,Y,D,E,F),
                                  nulo(X).

excecao(consulta(A,B,C,D,E,F)) :- consulta(A,X,C,D,E,F),
                                  nulo(X).

excecao(consulta(A,B,C,D,E,F)) :- consulta(A,X,Y,D,E,F),
                                  nulo(X),
                                  nulo(Y).

excecao(consulta(A,B,C,D,E,F)) :- consulta(A,X,C,D,Y,F),
                                  nulo(X),
                                  nulo(Y).

excecao(consulta(A,B,C,D,E,F)) :- consulta(A,B,X,D,Y,F),
                                  nulo(X),
                                  nulo(Y).


% medico: Id,Nome, Idade, Especialidade, Instituição
%possíveis valores desconhecidos: Idade,Especialidade

excecao(medico(A,B,C,D,E)) :- medico(A,B,X,D,E),
                              nulo(X).

excecao(medico(A,B,C,D,E)) :- medico(A,B,C,X,E),
                              nulo(X).

excecao(medico(A,B,C,D,E)) :- medico(A,B,X,Y,E),
                              nulo(X),
                              nulo(Y).


% -------------------------------------------------------------------------------------------------------------------------------
% Conhecimento  imperfeito incerto

%Para o utente de id 15, ninguém sabe a idade, mas sabe-se que não tem 20 anos
utente(15,anabela,xIdade,guimaraes).
-utente(15,anabela,20,guimaraes).

% para o servico de id 20, ninguém sabe a a descrição, mas sabe-se que não é fisioterapia
servico(20,xDescricao,hospital_braga, braga).
-servico(20,fisioterapia,hospital_braga, braga).

% ninguém sabe, para a consulta de id 10, a data em que foi realizada, mas sabe-se que não foi a 10-10-1998
consulta(10,data(xDia,xMes,xAno),1,1,1,15).
-consulta(10,data(10,10,1998),1,1,1,15).

% para o medico de id 10, ninguém sabe a especialidade , mas sabe-se que não é radiografia
medico(10,Jusue,30,xEspecialidade,hospital_braga).
-medico(10,Jusue,30,radiografia,hospital_braga).

% -------------------------------------------------------------------------------------------------------------------------------
% Conhecimento  Impreciso -------------------------------------------------------------

% não se sabe se o utente de id 20 se chama mauricio ou anacleto
excecao(utente(20,mauricio,20,braga)).
excecao(utente(20,anacleto,20,braga)).

% não se sabe se o servico de id 25 é disponibilizado no hospital_trofa_1 ou no hospital_trofa_2
excecao(servico(25,tumografia,hospital_trofa_1,braga)).
excecao(servico(25,tumografia,hospital_trofa_2,porto)).

% não se sabe se a consulta de id 15 foi feita ao paciente 1 ou 2
excecao(consulta(15,data(1,1,2019),1,15,1,30)). 
excecao(consulta(15,data(1,1,2019),2,15,1,30)). 

% não se sabe se o medico de id 15 tem 21 ou 22 anos
excecao(medico(15,goncalo,21,fisioterapia,hospital_trofa_2)).
excecao(medico(15,goncalo,22,fisioterapia,hospital_trofa_2)).

% -------------------------------------------------------------------------------------------------------------------------------
%Conhecimento Interdito -------------------------------------------------------------

% utente: IdUt,Nome,Idade,Cidade
% o utente de id 25 mora numa cidade que ninguém pode saber qual é.

utente(25,ana,23,xCidade).

+utente(A,B,C,D)::(solucoes(utente(A,B,C,D),utente(A,B,C,xCidade),L),
                  comprimento(L,S),
                  S == 0).

% servico: IdServ,Descrição,Instituição,Cidade
%não é possível saber qual a Instituicao que prestou o servico de id 30

servico(30,tumografia,xInstituicao,braga).

+servico(A,B,C,D)::(solucoes(servico(A,B,C,D),servico(A,B,xInstituicao,D),L),
                  comprimento(L,S),
                  S == 0).

% consulta: Id,Data,IdUt,IdServ,IdMedico,Custo
% não é possivel saber o id do médico que prestou a consulta de id 20

consulta(20,data(1,1,2019),2,15,xIdMedico,30). 

+consulta(A,B,C,D,E,F)::(solucoes(consulta(A,B,C,D,E,F),consulta(A,B,C,D,xMedico,F),L),
                        comprimento(L,S),
                        S == 0).

% medico: Id,Nome, Idade, Especialidade, Instituição
% não é possível saber a instituicao onde trabalha o médico de id 20

medico(20,marco,47,oncologia,xInstituicao).

+medico(A,B,C,D)::(solucoes(medico(A,B,C,D),medico(A,B,C,xInstituicao),L),
                  comprimento(L,S),
                  S == 0).

%--------------------------------------------------------------------------------------------------------------------------------
%Representação do meta-predicado nulo : valor -> {V,F}
nulo(xIdade).
nulo(data(xDia,xMes,xAno)).
nulo(xDia).
nulo(xMes).
nulo(xAno).
nulo(xEspecialidade).
nulo(xDescricao).
nulo(xCidade).
nulo(xMedico).
nulo(xInstituicao).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Tópico 3 -> Invariantes Estruturais e Referenciais

%Invariantes Estruturais:

% Observação: os invarientes Estruturais relacionados com a adição de conhecimento 
%             interdito já se encontram desenvolvidos em cima juntamente com a respetiva
%             demonstração de tentativa de adição desse conhecimento, que deverá ser 
%             impossível neste caso.

% nao permitir a insercao de uma excecao repetida
+excecao(T) :: ( solucoes(excecao(T),excecao(T),S),
                 comprimento(S,N),
                 N == 1 ).

% nao permitir a remoção de uma excecao
-excecao(T) :: ( no ).

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
%Invariantes Referenciais:

%para verificar se já existe o Utente e/ou Serviço
+consulta(ID,_,IDU,IDS,IM,_) :: (solucoes(ID, (utente(IDU,_,_,_), servico(IDS,_,I,_), medico(IM,_,_,_,I)), S),
                comprimento(S,N),
                N == 1
                ).

%Apenas se pode involucao utentes caso não tenham consultas associadas
-utente(Id,_,_,_) :: (solucoes( Id,(consulta(_,_,Id,_,_,_)),S ),
            comprimento( S,N ), 
            N == 0
                      ).

%Apenas se pode involucao médicos caso não tenham consultas associadas
-medico(Id,_,_,_) :: (solucoes( Id,(consulta(_,_,_,_,Id,_)),S ),
            comprimento( S,N ), 
            N == 0
                      ).

%Apenas se pode involucao serviços caso não tenham consultas associadas
-servico(Id,_,_,_) :: (solucoes( Id,(consulta(_,_,_,Id,_,_)),S ),
             comprimento( S,N ), 
             N == 0
                       ).

%Não convêm involucao consultas por isso não o permitimos com este Invariante
-consulta(_,_,_,_,_,_) :: (no).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Tópico 4

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado remove : Lista -> {V,F}

removeBC([H]) :- retract(H).
removeBC([H|T]) :- retract(H), removeBC(T).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% evolucao do conhecimento
%Extensao do predicado evolucao: Termo -> {V, F, D}

evolucao( utente(A, B, C, D) ) :-  demo(utente(A, B, _, _), R),
			                       R = desconhecido,
								   solucoes(utente(A, E, F, G), utente(A, E, F, G), L),
								   comprimento(L, S),
								   S == 0,
								   registar( excecao(utente(A, B, C, D)) ).
% atualização dos dados
evolucao( utente(A, B, C, D) ) :-  demo(utente(A, B, C, D),R),
								   R = desconhecido,
								   solucoes(utente(A, H, I, J), utente(A, H, I, J), L),
								   comprimento(L, S),
								   S > 0,
								   registar(utente(A, B, C, D)),
								   removeBC(L).

evolucao( utente(A, B, C, D) ) :-  demo(utente(A, B, C, D), R),
								   R = falso,										 
								   registar(utente(A, B, C, D)).

evolucao( servico(A, B, C, D) ) :-  demo(servico(A, B, _, D), R),
									R = desconhecido,
									solucoes(servico(A, E, F, G), servico(A, E, F, G), L),
									comprimento(L, S),
									S == 0,
									registar( excecao(servico(A, B, C, D)) ).

evolucao( servico(A, B, C, D) ) :-  demo(servico(A, B, C, D), R),
								    R = desconhecido,
									solucoes(servico(A, E, F, G), servico(A, E, F, G), L),
									comprimento(L, S),
									S > 0,
								    registar(servico(A, B, C, D)),
									removeBC(L).

evolucao( servico(A, B, C, D) ) :-  demo(servico(A, B, C, D), R),
									R = falso,										 
									registar(servico(A, B, C, D)).

evolucao( consulta(A, B, C, D, E, F) ) :-  demo(consulta(A, B, C, D, _, F), R),
									  	   R = desconhecido,
										   solucoes(consulta(A, G, H, I, J, K), consulta(A, G, H, I, J, K), L),
										   comprimento(L, S),
										   S == 0,
										   registar( excecao(utente(A, B, C, D, E, F)) ).

evolucao( consulta(A, B, C, D, E, F) ) :-  demo(consulta(A, B, C, D, E, F), R),
										   R = desconhecido,
									  	   solucoes(consulta(A, G, H, I, J, K), consulta(A, G, H, I, J, K), L),
										   comprimento(L, S),
										   S > 0,
										   registar(consulta(A, B, C, D, E, F)),
										   removeBC(L).

evolucao( consulta(A, B, C, D, E, F) ) :-  demo(consulta(A, B, C, D, E, F), R),
										   R = falso,										 
										   registar(consulta(A, B, C, D, E, F)).

evolucao( excecao(Termo) ) :- registar(excecao(Termo)).

-evolucao(T) :- demo(T,verdadeiro).

% Extensao do predicado registar: #T -> {V,F}   
registar( Termo ) :- (solucoes(Invariante, +Termo::Invariante,Lista),
					 insercao(Termo),
					 teste(Lista)).

%PMF para o predicado registar
-registar(Termo).


% involucao utentes, servicos, medicos e consultas
% Extensao do predicado involucao: T -> {V,F,D}   

involucao( Termo ) :-	(solucoes(Invariante, -Termo::Invariante,Lista),
					    teste(Lista)),
					    remocao(Termo).

-involucao(Termo) :- excecao( Termo ),
			    	 nao( Termo ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Tópico 5 sistema de inferencia

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado demoConjunto: Questao,Resposta -> {V,F}
demoConjunto(Q1/\Q2, R):- demoConjunto(Q2,R1),  % conjunção
           demoConjunto(Q1,R2),
           conjuncao(R1,R2,R).  % faz a conjunção das respostas anteriores

demoConjunto(Q1\/Q2, R):- demoConjunto(Q2,R1),  % disjunção
           demoConjunto(Q1,R2),
           disjuncao(R1,R2,R).  % faz a disjunção das respostas anteriores

demoConjunto(Q1+Q2, R):- demoConjunto(Q2,R1),  % disjunção explicíta
           demoConjunto(Q1,R2),
           disjuncaoExplicita(R1,R2,R).

demoConjunto(Q1\Q2, R):- demoConjunto(Q2,R1),  % implicacao
           demoConjunto(Q1,R2),
           implicacao(R1,R2,R).

demoConjunto(Q, R):- demo(Q,R).               %caso normal, uma questão

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado disjuncao: A , B , Resposta -> {V,F}
% soluções possíveis entre o desconhecido e o verdadeiro
disjuncao(desconhecido, verdadeiro, verdadeiro).
disjuncao(verdadeiro, desconhecido, verdadeiro).

% soluções possíveis entre o desconhecido e o falso
disjuncao(falso, desconhecido, desconhecido).
disjuncao(desconhecido, falso, desconhecido).

% tabela de verdade tradicional para a disjunção
disjuncao(verdadeiro, verdadeiro, verdadeiro).
disjuncao(verdadeiro, falso, verdadeiro).
disjuncao(falso, verdadeiro, verdadeiro).
disjuncao(falso, falso, falso).

% disjuncao do desconhecido
disjuncao(desconhecido, desconhecido, desconhecido).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado conjuncao: A , B , Resposta -> {V,F}
% soluções possíveis entre o desconhecido e o verdadeiro
conjuncao(verdadeiro, desconhecido, desconhecido). 
conjuncao(desconhecido, verdadeiro, desconhecido).

% soluções possíveis entre o desconhecido e o falso
conjuncao(falso, desconhecido, falso).
conjuncao(desconhecido, falso, falso).

% tabela de verdade tradicional para a conjunção
conjuncao(verdadeiro, verdadeiro, verdadeiro).
conjuncao(falso, falso, falso).
conjuncao(falso, verdadeiro, falso).
conjuncao(verdadeiro, falso, falso).

% conjuncao do desconhecido
conjuncao(desconhecido, desconhecido, desconhecido).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado implicacao: A, B, Resposta -> {V,F}
% tabela de verdade tradicional para a implicação
implicacao(verdadeiro, verdadeiro, verdadeiro).
implicacao(falso, falso, verdadeiro).
implicacao(falso, verdadeiro, verdadeiro).
implicacao(verdadeiro, falso, falso).

% soluções possíveis entre o desconhecido e o verdadeiro
implicacao(verdadeiro, desconhecido, desconhecido). 
implicacao(desconhecido, verdadeiro, verdadeiro).

% soluções possíveis entre o desconhecido e o falso
implicacao(falso, desconhecido, verdadeiro).
implicacao(desconhecido, falso, desconhecido).

% implicacao do desconhecido
implicacao(desconhecido,desconhecido,desconhecido).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado disjuncaoExplicita: A, B, Resposta -> {V,F}
% tabela de verdade tradicional para a implicação
disjuncaoExplicita(verdadeiro, verdadeiro, falso).
disjuncaoExplicita(falso, falso, falso).
disjuncaoExplicita(falso, verdadeiro, verdadeiro).
disjuncaoExplicita(verdadeiro, falso, verdadeiro).

% soluções possíveis entre o desconhecido e o verdadeiro
disjuncaoExplicita(verdadeiro,desconhecido,desconhecido).
disjuncaoExplicita(desconhecido,verdadeiro,desconhecido).

% soluções possíveis entre o desconhecido e o falso
disjuncaoExplicita(falso,desconhecido,desconhecido).
disjuncaoExplicita(desconhecido,falso,desconhecido).

% implicacao do desconhecido
disjuncaoExplicita(desconhecido,desconhecido,desconhecido).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -