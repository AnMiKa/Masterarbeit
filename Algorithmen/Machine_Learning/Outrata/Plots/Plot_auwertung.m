% Plotting Script Reseults

%% Auswertung 1

% Cmin

figure
hold on 
box on



for i = 1:5
    stem(x+(i-1)*.15,log_f_h0(1:5,i), 'LineStyle',':','Color','b','Marker','+','LineWidth',0.9)
    stem(x+(i-1)*.15,log_f_n10(1:5,i), 'p:c','filled')
    stem(x+(i-1)*.15,log_f_n40(1:5,i), 'x:m','filled')
end