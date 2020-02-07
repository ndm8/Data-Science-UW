
pelt_data = [1845 20 32;
    1847 20 50;
    1849 52 12;
    1851 83 10;
    1853 64 13;
    1855 68 36;
    1857 83 15;
    1859 12 12;
    1861 36 6;
    1863 150 6;
    1865 110 65;
    1867 60 70;
    1869 7 40;
    1871 10 9;
    1873 70 20;
    1875 100 34;
    1877 92 45;
    1879 70 40; 
    1881 10 15;
    1883 11 15;
    1885 137 60;
    1887 137 80;
    1889 18 26;
    1891 22 18;
    1893 52 37;
    1895 83 50;
    1897 18 35;
    1899 10 12;
    1901 9 12;
    1903 65 25];

scatter(pelt_data(:, 2), pelt_data(:,3), 'filled');

XEDGES = linspace(0,150,3);
YEDGES = linspace(0,80,3);
dxedges = XEDGES(2)-XEDGES(1);
dyedges = YEDGES(2)-YEDGES(1);

%{
[Counts_True,XEDGES,YEDGES] = histcounts2(x1,x2,XEDGES,YEDGES);
[Counts_Model,XEDGES,YEDGES] = histcounts2(Y_Model(:,1),Y_Model(:,2),XEDGES,YEDGES);
KL = sum(sum(Counts_True.* log((Counts_True./sum(Counts_True))./ (Counts_Model./sum(Counts_Model))))) .* dxedges.*dyedges;
%}

