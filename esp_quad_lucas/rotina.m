Arq = load('h_1_6_p_5_d_3_5_w_0_1.txt');


freq = Arq(:,1); 
FSS = Arq(:,2);

vetEsc = []; %Vetor Dinâmico.
Dados = []; %Vetor Dinâmico (Fr e BW].
Dif = FSS + 10; % Artifício para auxiliar no Cálculo de BW.

%---------------------- Lógica para Cálculo de BW e FR --------------------
for i = 1:(length(FSS)-1)
AvSinal = Dif(i)*Dif(i+1); %Avalia o sinal resultante da multiplicação.
if AvSinal < 0
    FSSs = [Dif(i) Dif(i+1)];
    vAbs = abs(FSSs);
    pos = find(vAbs==min(vAbs));
    pDifEsc = find(Dif==FSSs(pos));
    vEsc = FSS(pDifEsc);
    
    vetEsc = [vetEsc vEsc];

end
end

for t = 1:(length(vetEsc))
    if t==1
    vCoeff = min(FSS(1:find(FSS==vetEsc(t))));
    if vCoeff ~= vetEsc(t)
    fr = freq(FSS==vCoeff);
    BW = abs(freq(FSS==vetEsc(t))-fr);
    Dados = [Dados; fr BW];
    end
    end
    
    if t==(length(vetEsc)) && length(Dados)~=0 
    vCoeff = min(FSS(find(FSS==vetEsc(t)):end));
    if vCoeff ~= vetEsc(t)
    fr = freq(FSS==vCoeff);
    if freq(FSS==vetEsc(t)) > fr
    
        BW = abs(freq(FSS==vetEsc(t))-freq(FSS==vetEsc(t-1)));
    
    else
        BW = abs(freq(FSS==vetEsc(t))-freq(end));
        
    end
    Dados = [Dados; fr BW];
%     end
    end
    
    end
    
    if t==(length(vetEsc)) && length(Dados)==0 
    vCoeff = min(FSS(1:find(FSS==vetEsc(t))));
    if vCoeff ~= vetEsc(t)
    fr = freq(FSS==vCoeff);
    if freq(FSS==vetEsc(t)) > fr
    
        BW = abs(freq(FSS==vetEsc(t))-freq(FSS==vetEsc(t-1)));
    
    else
        BW = abs(freq(FSS==vetEsc(t))-freq(end));
        
    end
    Dados = [Dados; fr BW];
        else
    vCoeff = min(FSS(find(FSS==vetEsc(t)):end));    
    fr = freq(FSS==vCoeff);
    if freq(FSS==vetEsc(t)) > fr
    
        BW = abs(freq(FSS==vetEsc(t))-freq(FSS==vetEsc(t-1)));
    
    else
        BW = abs(freq(FSS==vetEsc(t))-freq(end));
        
    end
    Dados = [Dados; fr BW];
    end
        
    end
    
       
    
    if t~=1 && t~=length(vetEsc)
    vCoeff = min([min(FSS(find(FSS==vetEsc(t)):find(FSS==vetEsc(t+1)))) min(FSS(find(FSS==vetEsc(t-1)):find(FSS==vetEsc(t))))]);      
    fr = freq(FSS==vCoeff);
    if freq(FSS==vetEsc(t)) > fr
    BW = abs(freq(FSS==vetEsc(t))-freq(FSS==vetEsc(t-1)));
    else
    BW = abs(freq(FSS==vetEsc(t))-freq(FSS==vetEsc(t+1)));    
    end
        if isempty(Dados) || isempty(find(Dados==fr, 1))
    Dados = [Dados; fr BW];
    end
    end
   
end
