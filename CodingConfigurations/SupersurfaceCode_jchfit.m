%function ������Դ���Ͳ�����Ŀ�겨������λ���������λ����㳬������루1bit���룩

function[actual,code,const,listbb] =SupersurfaceCode_jchfit(u,D)
% global Nx Ny lambda
Nx = 16;
Ny = 16;
f=5.32*1e9;           %��Ԫ�����ź�Ƶ��
c=3*1e8;           %����
lambda=c/f;  
%%
%�������벹����λ���벢ʵ�ʲ���
code=zeros(Ny,Nx);
% comphi=zeros(Ny,Nx);
actual=zeros(Ny,Nx);
list1  = [];
list2  = [];
list3  = [];
list4  = [];
for i=1:Ny %%�ѵ���
    for j=1:Nx
        if abs(u(i,j))<pi/2
            list1 = [list1;i,j];
        elseif abs(u(i,j))<pi && abs(u(i,j))>pi/2
            list2 = [list2;i,j];
        elseif abs(u(i,j))<3/2*pi && abs(u(i,j))>pi
            list3 = [list3;i,j];
        else abs(u(i,j))> 3/2*pi
            list4 = [list4;i,j];
        end
    end
end
    listbb = {list1 list2 list3 list4}  ;      
        
for m = 1:1:length(list1)
    indexi = list1(m,:);
    i = indexi(1);
    j = indexi(2);
    if abs(abs(u(i,j)) - 0)<abs(abs(u(i,j)) - pi/2)
        code(i,j)=1; 
        actual(i,j)=D(i,j) + deg2rad(0);
        const(i,j) = D(i,j) + u(i,j);
    else
        code(i,j)=0;
        actual(i,j)=D(i,j)+deg2rad(90);
        const(i,j) = D(i,j) + u(i,j);    
    end
end

for n = 1:1:length(list2)
    indexi = list2(n,:);
    i = indexi(1);
    j = indexi(2);
    if abs(abs(u(i,j)) - pi/2)<abs(abs(u(i,j)) - pi)
        code(i,j)=0; 
        actual(i,j)=D(i,j)+deg2rad(90);
        const(i,j) = D(i,j) + u(i,j);
    else
        code(i,j)=3;
        actual(i,j)=D(i,j)+deg2rad(180);
        const(i,j) = D(i,j) + u(i,j);    
    end
end

for o = 1:1:length(list3)
    indexi = list3(o,:);
    i = indexi(1);
    j = indexi(2);
    if abs(abs(u(i,j)) - pi)<abs(abs(u(i,j)) - 3*pi/2)
        code(i,j)=3; 
        actual(i,j)=D(i,j)+deg2rad(180);
        const(i,j) = D(i,j) + u(i,j);
    else
        code(i,j)=2;
        actual(i,j)=D(i,j)+deg2rad(270);
        const(i,j) = D(i,j) + u(i,j);    
    end
end

for ppp = 1:1:length(list4)
    indexi = list4(ppp,:);
    i = indexi(1);
    j = indexi(2);
    if abs(abs(u(i,j)) - 3*pi/2)<abs(abs(u(i,j)) - 2*pi)
        code(i,j)=2; 
        actual(i,j)=D(i,j)+deg2rad(270);
        const(i,j) = D(i,j) + u(i,j);
    else
        code(i,j)=1;
        actual(i,j)=D(i,j)+deg2rad(0);
        const(i,j) = D(i,j) + u(i,j);    
    end
end








        



actual=mod(actual,2*pi);
% const = mod(const,2*pi);
% u_mod=mod(comphi,2*pi);
%disp(actual')
%imagesc(uu_mod)
%colormap('jet');
%colorbar;
actual=actual*lambda/(2*pi);
const = const*lambda/(2*pi);



end