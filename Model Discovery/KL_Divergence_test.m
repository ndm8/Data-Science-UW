n=10000;
x1=randn(n,1); % "truth" model (data)
x2=0.8*randn(n,1)+1; % model 1
x3=0.5*randn(n,1)-1; % model 3 components
x4=0.7*randn(n,1)-3;
x5=5*rand(n,1)-0.5;
x=-6:0.01:6; % range for data
f=hist(x1,x)+0.01; % generate PDFs
g1=hist(x2,x)+0.01;
g2a=hist(x3,x);
g2b=hist(x4,x);
g2=g2a+0.3*g2b+0.01;
g3=hist(x5,x)+0.01;
f=f/trapz(x,f); % normalize data
g1=g1/trapz(x,g1);
g2=g2/trapz(x,g2);
g3=g3/trapz(x,g3);
plot(x,f,x,g1,x,g2,x,g3,'Linewidth',[2])
Int1=f.*log(f./g1); % compute integrand
Int2=f.*log(f./g2);
Int3=f.*log(f./g3);
% use if needed
%Int1(isinf(Int1))=0; Int1(isnan(Int1))=0;
%Int2(isinf(Int2))=0; Int2(isnan(Int2))=0;
I1=trapz(x,Int1) % KL divergence
I2=trapz(x,Int2)
I3=trapz(x,Int3)