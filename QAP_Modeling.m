function [  ] = QAP_Modeling( ~ )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
cnd=input(' Enter the matrix of candidates information: ');
W=input(' Enter the weight of relation for F-F,M-M and F-M: ');
F=input(' Enter the matrix of interaction between positions: ');
p=size(F,1);
gnd=permn(cnd(1,:),p);
gnd1=unique(gnd,'rows');
gnd1(any(diff(sort(gnd1,2),[],2)==0,2),:)=[];
gnd1(:,p+1)=0;
g=size(gnd1,1);
for n=1:g
    gnd1(n,p+1)=sum(cnd(3,gnd1(n,1:p)));
end   
a=zeros(p+1);
for m=1:g
    a(1,2:p+1)=gnd1(m,1:p);
    a(2:p+1,1)=gnd1(m,1:p);
    for i=2:p
        for j=i+1:p+1
        if cnd(2,a(i,1))==0 && cnd(2,a(1,j))==0
       a(i,j)=W(1);
        elseif cnd(2,a(i,1))==1 && cnd(2,a(1,j))==1
             a(i,j)=W(2);
        else
         a(i,j)=W(3);
        end
        end
    end
    a(1,:)=[];
    a(:,1)=[];
    gnd1(m,p+1)=gnd1(m,p+1)+sum(sum(a.*F));
end
E=sortrows(gnd1,p+1);
[row,~]=find(E==(max(gnd1(:,p+1))),1);
G=E(row:g,1:p);
H=max(gnd1(:,p+1));
disp(' Best Team Compositions: ')
disp(G)
disp(' Assignment score for Team is: ')
disp (H)
end


