%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Base de Conhecimento com informacao .

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).


% funções base para trabalho

% lê predicados da linha

ler(Filename) :- see(Filename), repeat, read(Q), file_to_list(Q,L), seen, print(L).

file_to_list(end_of_file,[]).
file_to_list(Q,[Q|L]) :- read(N), file_to_list(N,L).



% abre ficheiro e apaga o que está dentro -> escreve lista -> fecha saida para ficheiro

write_on_file(FileName,Lista) :- tell(FileName), writeList(Lista), told, print(Lista).


writeList([]) :- write('.').
writeList([A|B]) :- write(A), writeList(B).

regista(File,X) :- see(File), repeat, read(Q), file_to_list(Q,L), seen, inserir_final(X,L), write_on_file(File,L).

inserir_final([], Y, [Y]).         % Se a lista estava vazia, o resultado é [Y]
inserir_final([I|R], Y, [I|R1]) :- inserir_final(R, Y, R1).       % Inserindo o elemento Y no final do antigo resto

()

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado registarUtente: Id,Nome,Idade,Cidade -> {V,F}

registarUtente(Id,N,I,C).

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

removerConsulta(D,IU,IS).
