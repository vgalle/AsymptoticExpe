function [reloc]=Casserta(B)

% Casserta is a function which solve the CRP problem with full information.
% Its only entry is a bay B and it returns reloc the number of relocations
% needed.

%Be careful, B is the initial bay as it is view in real life. But here for
%convinience we transform B in invB in order to keep indices as it is commonly
%used, e.g. invB(1,1) means first column at the bottom and corresponds to 
%B(size(B,1),1).
invB=zeros(size(B,1),size(B,2));
%m is the biggest container in the bay, we allow for gaps between
%containers.
m=max(B(B~=0));
%Pos record the position of each container in the Bay.
Pos=zeros(m,2);
%H gives the height of each column
H=zeros(1,size(B,2));
for j=1:size(B,2);
    for i=1:size(B,1);
        invB(size(B,1)-i+1,j)=B(i,j);
        if B(i,j)~=0;
            Pos(B(i,j),1)=size(B,1)-i+1;
            Pos(B(i,j),2)=j;
            if H(j)==0;
                H(j)=size(B,1)-i+1;
            end;
        end;
    end;
end;
%minimum is the vector of the smallest container in each column
minimum=(m+1)*ones(1,size(invB,2));
for j=1:size(invB,2);
    if H(j)~=0;
        for i=1:H(j);
            if minimum(j)>invB(i,j);
                minimum(j)=invB(i,j);
            end;
        end;
    end;
end;
% Initialize the outcome
reloc=0;
t=1;

for n=min(invB(invB~=0)):m;
% We iterate for each container n
% First we compute its position in the bay, I and J are its coordinates
    I=Pos(n,1);
    J=Pos(n,2);
    if I~=0;
        while invB(I,J)~=0;
    % We loop until container n is retrieved
            if I==H(J);
    % If it is available, we retrieve it and we update the bay and its feature 
    % such as height, position of n and minimum.
                invB(I,J)=0;
                %We update B to be able to follow the algorithm
                B(size(invB,1)-I+1,J)=0;
                %We update H, Pos and minimum.
                H(J)=H(J)-1;
                Pos(n,1)=0;
                Pos(n,2)=0;
                minimum(J)=m+1;
                if I>1;
                    for i=1:I-1;
                        if minimum(J)>invB(i,J);
                            minimum(J)=invB(i,J);
                        end;
                    end;
                end;
            else
    % We are goign to apply the heuristic of Casserta to choose on which column
    % to move the top of column J denoted by r. We note this column C.
                r=invB(H(J),J);
                q=0;
                Q=m+2;
                C=0;
                for j=1:size(invB,2);
                    if j~=J;
                        if H(j)~=size(invB,1);
                            if q<minimum(j) && minimum(j)<r;
                                C=j;
                                q=minimum(j);
                            end;
                            if r<minimum(j) && minimum(j)<Q;
                                C=j;
                                Q=minimum(j);
                                q=r;
                            end;
                        end;
                    end;
                end;         
                %We update the bays invB and B, H and minimum.
                if minimum(C)>r;
                    minimum(C)=r;
                end;
                H(C)=H(C)+1;
                invB(H(C),C)=r;
                B(size(invB,1)-H(C)+1,C)=r;
                Pos(r,1)=H(C);
                Pos(r,2)=C;
                invB(H(J),J)=0;
                B(size(invB,1)-H(J)+1,J)=0;
                H(J)=H(J)-1;
                %We increment reloc by one
                reloc=reloc+1;
            end;
        t=t+1;
        end;
    end;
end;