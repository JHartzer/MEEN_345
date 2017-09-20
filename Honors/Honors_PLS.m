% Import data from Mukherjee's paper
X = csvread('Example_data.csv');
Y = Honors_De('Example_data.csv');

[XL,YL,XS,YS,BETA,PCTVAR,MSE,stats] = plsregress(X,Y,3);

plot(0:3,[0,cumsum(100*PCTVAR(2,:))],'-bo');
xlabel('Number of PLS components');
ylabel('Percent Variance Explained in y');
axis([0 3 0 100]);
xticks([0:3]);