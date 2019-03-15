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


:- op( 900,xfy,'::' ).
%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Extenção do predicado utente: IdUt,Nome,Idade,Cidade -> {V,F}
utente(1,joao,22,lisboa).
utente(2,carlos,15,beja).
utente(3,alfredo,45,braga).
utente(4,dario,72,lisboa).
utente(5,quim,25,braga).
utente(6,henrique,20,braga).
utente(7,ricardo,20,braga).
utente(8,bruno,44,aveiro).
utente(9,nuno,33,porto).
utente(10,pedro,70,coimbra).
%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Extenção do predicado servico: IdServ,Descrição,Instituição,Cidade -> {V,F}
servico(1,urgencias,hospital_braga,braga).
servico(2,autopsias,hospital_braga,braga).
servico(3,geral,hospital_braga,braga).
servico(4,analises,hospital_trofa_1,braga).
servico(5,radio_grafia,hospital_lisboa,lisboa).
servico(6,dentista,hospital_coimbra,coimbra).
servico(7,ecografia,hospital_aveiro,aveiro).
servico(8,fisioterapia,hospital_trofa_2,porto).
servico(9,urgencias,hospital_aveiro,aveiro).
servico(10,urgencias, hospital_porto,porto).
servico(11,radio_grafia,hospital_braga, braga).
servico(12,tumografia,hospital_braga, braga).
servico(13,dermatologia,hospital_coimbra,coimbra).
servico(14,rinoplastia, hospital_lisboa, lisboa).
servico(15,radio_grafia,hospital_braga,braga).
%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Extenção do predicado consulta: Id,Data,IdUt,IdServ,IdMedico, Custo -> {V,F}
consulta(1,data(11,2,2019),1,1,1,15).
consulta(2,data(12,3,2018),2,2,4,20).
consulta(3,data(13,1,2019),3,3,1,25).
consulta(4,data(25,8,2017),4,1,4,15).
consulta(5,data(2,10,2007),5,15,1,30).
consulta(6,data(17,5,2018),9,8,2,30).
%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Extenção do predicado medico: Id,Nome, Idade, Especialidade, Instituição -> {V,F}
medico(1,jose,30,pediatria,hospital_braga).
medico(2,joao,35,radiologia,hospital_porto).
medico(3,pedro,50,ginecologista,hospital_coimbra).
medico(4,joaquim, 44, cirugia, hospital_braga).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Funções auxiliares

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
%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Invariantes Estruturais: nao permitir a insercao de conhecimento repetido
%Invariante Estrutural para Utente
+utente(ID,_,_,_) :: (solucoes(ID,utente(ID,_,_,_),S),
					  comprimento(S,N),
					  N == 1
					  ).

%Invariante Estrutural para Servico
+servico(ID,_,_,_) :: (solucoes(ID,servico(ID,_,_,_),S),
					   comprimento(S,N),
					   N == 1
					   ).

%Invariante Estrutural para verificar se já existe um Id de Consulta igual
+consulta(ID,_,_,_,_) :: (solucoes(ID,(consulta(ID,_,_,_,_)), S),
						  comprimento(S,N),
					      N == 1
						  ).

%Invariante Estrutural para verificar se já existe um Id de Medico igual
+medico(ID,_,_,_,_) :: (solucoes(ID,medico(ID,_,_,_,_),S),
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

%Apenas se pode remover utentes caso não tenham consultas associadas
-utente(Id,_,_,_) :: (solucoes( Id,(consulta(_,Id,_,_)),S ),
					  comprimento( S,N ), 
					  N == 0
                      ).

%Apenas se pode remover serviços caso não tenham consultas associadas
-servico(Id,_,_,_) :: (solucoes( Id,(consulta(_,_,Id,_)),S ),
					   comprimento( S,N ), 
					   N == 0
                  	   ).

-consulta(_,_,_,_,_) :: (no).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Topico 1
% Extensao do predicado registarUtente: Id,Nome,Idade,Cidade -> {V,F}
registarUtente(ID,N,I,C) :- evolucao(utente(ID,N,I,C)).

% Extensao do predicado registarServiço: Id,Descrição,Instituição,Cidade -> {V,F}
registarServico(ID,D,I,C) :- evolucao(servico(ID,D,I,C)).

% Extensao do predicado registarConsulta: Data,IdU,IdS,IdMedico, Custo -> {V,F}
registarConsulta(ID,D,IU,IS,IM,C) :- evolucao(consulta(ID,D,IU,IS,IM,C)).

% Extensao do predicado registarMedico: Id,Nome, Idade, Especialidade, Instituição -> {V,F}
registarMedico(ID,N,I,E,IN) :- evolucao(medico(ID,N,I,E,IN)).
%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Topico 2
%Extensão do predicado de removerUtente: IdUten -> {V,F}
removerUtente(ID) :- involucao(utente(ID,_,_,_)).

%Extensão do predicado de removerServico: IdServ -> {V,F}
removerServico(ID) :- involucao(servico(ID,_,_,_)).

%Extensão do predicado de removerConsulta: IdCons -> {V,F}
removerConsulta(ID) :- involucao(consulta(ID,_,_,_,_)).
%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Topico 3
%Extensão do predicado de lerServicos: Lista -> {V,F}
lerServicos(D) :- solucoes((C),servico(_,_,C,_),E), setof((C),member((C),E),D).
%--------------------------------- - - - - - - - - - -  -  -  -  -   -

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
consultaID(Id,D) :- solucoes((Id,Data,IdUtente,IdServ,IdMed,Custo), consulta(Id,Data,IdUtente,IdServ,IdMed,Custo),D).

%Extensão do predicado de consultaUtente: Utente,Lista -> {V,F}
consultaUtente(IdUtente,D) :- solucoes((Id,Data,IdUtente,IdServ,IdMed,Custo), consulta(Id,Data,IdUtente,IdServ,IdMed,Custo),D).

%Extensão do predicado de consultaInstituicao: Instituicao,Lista -> {V,F}
consultaInstituicao(IdInstituicao,D) :- solucoes((Id,Data,IdUt,IdInstituicao,IdMed,Custo), consulta(Id,Data,IdUt,IdInstituicao,IdMed,Custo),D).

%Extensão do predicado de consultaData: Data,Lista -> {V,F}
consultaData(data(D,M,A),E) :- solucoes((Id,data(D2,M2,A2),IdUt,IdServ,IdMed,Custo), (consulta(Id,data(D2,M2,A2),IdUt,IdServ,IdMed,Custo),D2 == D,M2 == M, A2 == A),E).

%Extensão do predicado de consultaDatas: Data,Data,Lista -> {V,F}
consultaDatas(data(D1,M1,A1),data(D2,M2,A2),E) :- solucoes((Id,data(D3,M3,A3),IdUt,IdServ,IdMed,Custo), (consulta(Id,data(D3,M3,A3),IdUt,IdServ,IdMed,Custo),entre(A1*365+M1*30+D1,A2*365+M2*30+D2,A3*365+M3*30+D3)),E).

%Extensão do predicado de consultaCustosInferiores: CustoMax,Lista -> {V,F}
consultaCustosInferiores(CustoMax,D) :- solucoes((Id,Data,IdUt,IdServ,IdMed,Custo),(consulta(Id,Data,IdUt,IdServ,IdMed,Custo),Custo =< CustoMax),D).

%Extensão do predicado de consultaCustosSuperiores: CustoMax,Lista -> {V,F}
consultaCustosSuperiores(CustoMax,D) :- solucoes((Id,Data,IdUt,IdServ,IdMed,Custo),(consulta(Id,Data,IdUt,IdServ,IdMed,Custo),Custo >= CustoMax),D).
%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Topico 5
%Extensão do predicado de servPrestPorInst: Instituicao,Lista -> {V,F}
servPrestPorInst(Inst, S) :- solucoes(servico(IdServ, Desc, Inst, Cid),(servico(IdServ, Desc, Inst, Cid)),S).

%Extensão do predicado de servPrestPorCidade: Cidade,Lista -> {V,F}
servPrestPorCidade(Cid, S) :- solucoes(servico(IdServ, Desc, Inst, Cid),(servico(IdServ, Desc, Inst, Cid)),S).

%Extensão do predicado de servPrestPorDatas: Data,Data,Lista -> {V,F}
servPrestPorDatas(data(D1,M1,A1),data(D2,M2,A2), S) :- solucoes(servico(IdServ, Desc, Inst, Cid),(servico(IdServ, Desc, Inst, Cid),consulta(data(D3,M3,A3),_,IdServ,_,_),entre(A1*365+M1*30+D1,A2*365+M2*30+D2,A3*365+M3*30+D3)),S).

%Extensão do predicado de servPrestPorCusto: Custo,Lista -> {V,F}
servPrestPorCusto(Custo, S) :- solucoes(servico(IdServ, Desc, Inst, Cid),(servico(IdServ, Desc, Inst, Cid), consulta(_,_,IdServ,_,Custo)),S).
%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Topico 6
%Extensão do predicado de identificarUtentesServico: Servico,Lista -> {V,F}
identificarUtentesServico(Serv,D) :- solucoes((Uten,Serv,Data),(consulta(_,Data,A,Serv,_),utente(A,Uten,_,_)),D).

%Extensão do predicado de identificarUtentesInstituicao: Cidade,Lista -> {V,F}
identificarUtentesInstituicao(Inst,D) :- solucoes((Uten,Inst,Data),(consulta(_,Data,A,G,_),servico(G,_,Inst,_),utente(A,Uten,_,_)),D).
%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Topico 7
%Extensão do predicado de identificarServicosUtente: Utente,Lista -> {V,F}
identificarServicosUtente(Uten,D) :- solucoes((Serv,Uten,Data),(consulta(_,Data,Uten,A,_),servico(A,Serv,_,_)),D).

%Extensão do predicado de identificarServicosInstituicao: Instituicao,Lista -> {V,F}
identificarServicosInstituicao(Inst,D) :- solucoes((Serv,Inst,Data),(consulta(_,Data,_,A,_),servico(A,Serv,Inst,_)),D).

%Extensão do predicado de identificarServicosCidade: Cidade,Lista -> {V,F}
identificarServicosCidade(Loca,D) :- solucoes((Serv,Loca,Data),(consulta(_,Data,_,A,_),servico(A,Serv,_,Loca)),D).
%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Topico 8 

%Extensao do predicado custoCuidadosPorUtente: IdUten,Lista -> {V,F}
custoCuidadosPorUtente(ID, R) :- solucoes(C,(consulta(_,_,ID,_,_,C)), S),sum(S,R).

%Extensao do predicado custoCuidadosPorServico: IdServ,Lista -> {V,F}
custoCuidadosPorServico(ID, R) :- solucoes(C,(consulta(_,_,_,ID,_,C)), S), sum(S,R).

%Extensao do predicado custoCuidadosPorServico: Inst,Lista -> {V,F}
custoCuidadosPorInstituicao(I,R) :- solucoes(C,(servico(IDV,_,I,_), consulta(_,_,_,IDV,_,C)), S), sum(S,R).

%Extensao do predicado custoCuidadosPorData: Data,Lista -> {V,F}
custoCuidadosPorData(data(D,M,A),R) :- solucoes(C,(consulta(_,data(D,M,A),_,_,_,C)),S), sum(S,R).
%--------------------------------- - - - - - - - - - -  -  -  -  -   -



