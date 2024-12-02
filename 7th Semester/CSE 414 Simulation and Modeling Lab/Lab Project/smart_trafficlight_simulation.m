clc;
clear;

greenTime = 15;   
yellowTime = 5;  
redTime = greenTime + yellowTime; 

cycleTime = 4 * (greenTime + yellowTime); 
simulationTime = 2 * cycleTime; 

figure;
axis([0 14 0 14]);
hold on;

rectangle('Position', [5, 5, 4, 4], 'FaceColor', [0.9 0.9 0.9]);
text(6.5, 13, 'North', 'FontSize', 12);
text(6.5, 1, 'South', 'FontSize', 12);
text(1, 7, 'West', 'FontSize', 12);
text(13, 7, 'East', 'FontSize', 12);

NL = [8, 10.5];  
NR = [6, 10.5];  

SL = [6, 3.5];  
SR = [8, 3.5]; 

EL = [10.5, 6];  
ER = [10.5, 8];  

WL = [3.5, 8];   
WR = [3.5, 6];  

currentTime = 0;
while currentTime < simulationTime
    cyclePhase = mod(currentTime, cycleTime);

    NL_Color = 'red'; NR_Color = 'red';
    SL_Color = 'red'; SR_Color = 'red';
    EL_Color = 'red'; ER_Color = 'red';
    WL_Color = 'red'; WR_Color = 'red';
    activeLight = []; 

    if cyclePhase < greenTime
        EL_Color = 'green'; SR_Color = 'green'; WR_Color = 'green'; NR_Color = 'green';
        activeLight = EL; 
    elseif cyclePhase < greenTime + yellowTime 
        EL_Color = 'yellow'; SR_Color = 'yellow'; WR_Color = 'yellow'; NR_Color = 'yellow';
        activeLight = EL;
    elseif cyclePhase < 2 * greenTime + yellowTime 
        SL_Color = 'green'; WR_Color = 'green'; NR_Color = 'green'; ER_Color = 'green';
        activeLight = SL;
    elseif cyclePhase < 2 * (greenTime + yellowTime)
        SL_Color = 'yellow'; WR_Color = 'yellow'; NR_Color = 'yellow'; ER_Color = 'yellow';
        activeLight = SL; 
    elseif cyclePhase < 3 * greenTime + 2 * yellowTime 
        WL_Color = 'green'; NR_Color = 'green'; ER_Color = 'green'; SR_Color = 'green';
        activeLight = WL; 
    elseif cyclePhase < 3 * (greenTime + yellowTime) 
        WL_Color = 'yellow'; NR_Color = 'yellow'; ER_Color = 'yellow'; SR_Color = 'yellow';
        activeLight = WL; 
    else 
        NL_Color = 'green'; ER_Color = 'green'; SR_Color = 'green'; WR_Color = 'green';
        activeLight = NL; 
    end

    cla;
    rectangle('Position', [5, 5, 4, 4], 'FaceColor', [0.9 0.9 0.9]); 
    hold on;

    line([7, 7], [0, 14], 'Color', 'black', 'LineStyle', '--'); 
    line([0, 14], [7, 7], 'Color', 'black', 'LineStyle', '--'); 

    if ~isempty(activeLight)
        plot(activeLight(1), activeLight(2), 'o', 'MarkerSize', 24, 'MarkerFaceColor', 'black', 'MarkerEdgeColor', 'black');
    end

    plot(NL(1), NL(2), 'o', 'MarkerSize', 20, 'MarkerFaceColor', NL_Color);
    plot(NR(1), NR(2), 'o', 'MarkerSize', 20, 'MarkerFaceColor', NR_Color);
    plot(SL(1), SL(2), 'o', 'MarkerSize', 20, 'MarkerFaceColor', SL_Color);
    plot(SR(1), SR(2), 'o', 'MarkerSize', 20, 'MarkerFaceColor', SR_Color);
    plot(EL(1), EL(2), 'o', 'MarkerSize', 20, 'MarkerFaceColor', EL_Color);
    plot(ER(1), ER(2), 'o', 'MarkerSize', 20, 'MarkerFaceColor', ER_Color);
    plot(WL(1), WL(2), 'o', 'MarkerSize', 20, 'MarkerFaceColor', WL_Color);
    plot(WR(1), WR(2), 'o', 'MarkerSize', 20, 'MarkerFaceColor', WR_Color);

    title(['Simulation Time: ' num2str(currentTime) ' seconds']);
    pause(1); 
    currentTime = currentTime + 1;
end