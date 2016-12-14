%Questa funzione riceve in ingresso una matrice in cui ogni riga contiene
%il numero della immagine considerata ad esempio subject(2) = 01,
%subject(3)= 01, subject(100)=2. Restituisce una matrice in cui è presente
%il valore 1 solo in una immagine della stessa classe(quindi per ogni
%classe sceglie solo una immagine).

function matrix=scegliImmagine(subject)
[m,n]=size(subject);
matrix=zeros(m,1);
indiceSuperiore=1;
for i=1:m   
    val = str2num(subject(i,1:2));
    indiceInferiore=indiceSuperiore;
    while(str2num(subject(i,1:2))==val && i<m)
       
       i=i+1;
    end      
    indiceSuperiore=i;
    
    fprintf('Inf-%d   Sup-%d  Val-%d \n',indiceInferiore,indiceSuperiore,val);
    
    random= randi([indiceInferiore indiceSuperiore],1);
    matrix(random,1)=1;       
     
end

       