clc;
clear;

% Define timing intervals for traffic lights (seconds)
greenTime = 15;   % Green light duration
yellowTime = 5;   % Yellow light duration
redTime = greenTime + yellowTime; % Total cycle time for one configuration

% Define simulation time (total time in seconds)
cycleTime = 4 * (greenTime + yellowTime); % One full cycle for all directions
simulationTime = 2 * cycleTime; % Simulate 2 complete cycles

% Initialize figure for visualization
figure;
axis([0 14 0 14]);
hold on;

% Draw intersection layout
rectangle('Position', [5, 5, 4, 4], 'FaceColor', [0.9 0.9 0.9]); % Intersection
text(6.5, 13, 'North', 'FontSize', 12);
text(6.5, 1, 'South', 'FontSize', 12);
text(1, 7, 'West', 'FontSize', 12);
text(13, 7, 'East', 'FontSize', 12);

% Traffic light positions (with dividing line offsets)
% North
NL = [8, 10.5];  % North Left
NR = [6, 10.5];  % North Right
% South
SL = [6, 3.5];   % South Left
SR = [8, 3.5];   % South Right
% East
EL = [10.5, 6];  % East Left
ER = [10.5, 8];  % East Right
% West
WL = [3.5, 8];   % West Left
WR = [3.5, 6];   % West Right

% Simulation loop
currentTime = 0;
while currentTime < simulationTime
    % Determine which lights are green based on the cycle
    cyclePhase = mod(currentTime, cycleTime);

    % Initialize all lights as red
    NL_Color = 'red'; NR_Color = 'red';
    SL_Color = 'red'; SR_Color = 'red';
    EL_Color = 'red'; ER_Color = 'red';
    WL_Color = 'red'; WR_Color = 'red';
    activeLight = []; % To store the currently active light for highlighting

    if cyclePhase < greenTime % Phase 1: EL Green
        EL_Color = 'green'; SR_Color = 'green'; WR_Color = 'green'; NR_Color = 'green';
        activeLight = EL; % Highlight EL
    elseif cyclePhase < greenTime + yellowTime % Phase 1: Yellow transition
        EL_Color = 'yellow'; SR_Color = 'yellow'; WR_Color = 'yellow'; NR_Color = 'yellow';
        activeLight = EL; % Highlight EL
    elseif cyclePhase < 2 * greenTime + yellowTime % Phase 2: SL Green
        SL_Color = 'green'; WR_Color = 'green'; NR_Color = 'green'; ER_Color = 'green';
        activeLight = SL; % Highlight SL
    elseif cyclePhase < 2 * (greenTime + yellowTime) % Phase 2: Yellow transition
        SL_Color = 'yellow'; WR_Color = 'yellow'; NR_Color = 'yellow'; ER_Color = 'yellow';
        activeLight = SL; % Highlight SL
    elseif cyclePhase < 3 * greenTime + 2 * yellowTime % Phase 3: WL Green
        WL_Color = 'green'; NR_Color = 'green'; ER_Color = 'green'; SR_Color = 'green';
        activeLight = WL; % Highlight WL
    elseif cyclePhase < 3 * (greenTime + yellowTime) % Phase 3: Yellow transition
        WL_Color = 'yellow'; NR_Color = 'yellow'; ER_Color = 'yellow'; SR_Color = 'yellow';
        activeLight = WL; % Highlight WL
    else % Phase 4: NL Green
        NL_Color = 'green'; ER_Color = 'green'; SR_Color = 'green'; WR_Color = 'green';
        activeLight = NL; % Highlight NL
    end

    % Update lights and visuals
    cla;
    rectangle('Position', [5, 5, 4, 4], 'FaceColor', [0.9 0.9 0.9]); % Intersection
    hold on;

    % Draw divider lines for Left and Right lights
    line([7, 7], [0, 14], 'Color', 'black', 'LineStyle', '--'); % Vertical divider
    line([0, 14], [7, 7], 'Color', 'black', 'LineStyle', '--'); % Horizontal divider

    % Highlight the active light with a black outline
    if ~isempty(activeLight)
        plot(activeLight(1), activeLight(2), 'o', 'MarkerSize', 24, 'MarkerFaceColor', 'black', 'MarkerEdgeColor', 'black');
    end

    % Plot traffic lights
    plot(NL(1), NL(2), 'o', 'MarkerSize', 20, 'MarkerFaceColor', NL_Color);
    plot(NR(1), NR(2), 'o', 'MarkerSize', 20, 'MarkerFaceColor', NR_Color);
    plot(SL(1), SL(2), 'o', 'MarkerSize', 20, 'MarkerFaceColor', SL_Color);
    plot(SR(1), SR(2), 'o', 'MarkerSize', 20, 'MarkerFaceColor', SR_Color);
    plot(EL(1), EL(2), 'o', 'MarkerSize', 20, 'MarkerFaceColor', EL_Color);
    plot(ER(1), ER(2), 'o', 'MarkerSize', 20, 'MarkerFaceColor', ER_Color);
    plot(WL(1), WL(2), 'o', 'MarkerSize', 20, 'MarkerFaceColor', WL_Color);
    plot(WR(1), WR(2), 'o', 'MarkerSize', 20, 'MarkerFaceColor', WR_Color);

    % Display current time
    title(['Simulation Time: ' num2str(currentTime) ' seconds']);
    pause(1); % Simulate one second delay
    currentTime = currentTime + 1;
end
