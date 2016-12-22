%Questa funzione riceve in ingresso una matrice in cui ogni riga contiene
%il numero dell'immagine considerata (ad esempio subject(2) = 01,
%subject(3)= 01, subject(100)=2). Restituisce una matrice in cui è presente
%il valore 1 solo in una immagine della stessa classe(quindi per ogni
%classe sceglie solo una immagine).
%Quindi, dato subjects di questo tipo:
%subject(2)  = 01
%subject(3)  = 01
%subject(4)  = 01
%subject(5)  = 01
%subject(80) = 02
%subject(81) = 02
%subject(82) = 02
%subject(83) = 02



function [testIdx, trainIdx] = tenfoldvalidation(subjects)
[m,n]=size(subjects); %prendiamo la dimensione di subjects
trainIdx=false(m,10); %Inizializziamo trainIdx a false, e metteremo true solo ad una immagine riguardante lo stesso soggetto


% eseguiamo il ten fold validation, quindi ripetiamo 10 volte il processo (facendo in modo da scegliere)
% sempre una immagine non ancora scelta
for k=1:10 
    j=1;
    while j<m
        subject = str2double(subjects(j,1:2));

        indiceInferiore=j;

        while(str2double(subjects(j,1:2))==subject && j<m)

           j=j+1;
        end      
        indiceSuperiore=j;
        
        scelta = randi([indiceInferiore indiceSuperiore], 1);
        
        %continua a generare indici finche' non viene scelto uno non scelto
        %in precendenza (serve per generare fold disgiunti)
        while(any(trainIdx(28, 1:k)))
            scelta = randi([indiceInferiore indiceSuperiore], 1);
        end
        
        %fprintf('Inf: %d   Sup: %d  Subject: %d Scelta: %d\n',indiceInferiore,indiceSuperiore,subject,random);
        trainIdx(scelta, k)=1;   

        j=j+1;
    end 
end

testIdx = ~trainIdx; 

end


       