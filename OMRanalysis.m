close all


%% COMMENTED VERSION
% Upload Behavior and video time files and plot (X, Y) coordinates 
%From stytra manual: the x axis increases to the right and the y axis increases downward, with (0,0) being the upper right corner.

% Load fish behavior data for both fish
fish_data_f = readtable('/Users/elena_1/Downloads/165955_behavior_log.csv', 'Delimiter', ';');

% Load video start time
video_times = readtable('/Users/elena_1/Downloads/165955_video_times.csv', 'Delimiter', ';');

% Specify the directory to save the output files
save_directory = '/Users/elena_1/Downloads/250123_f0/W5';  % Replace with the desired directory path

% Extract the start time from the second column of video_times
start_time_str = video_times{1, 2};  % Access the first row of the second column directly
start_time = datetime(start_time_str, 'InputFormat', 'yyyy-MM-dd HH:mm:ss.SSS');

% Define time columns for both fish
fish_time_column = 't';

% Calculate the time difference in seconds and add it to the start_time
fish_data_f.Time = start_time + seconds(fish_data_f.(fish_time_column));

% Convert pixel positions to millimeters
resolution_px_mm = 13.333;  % 13.333 px/mm resolution

fish_data_f.f0_x_mm = fish_data_f.f0_x / resolution_px_mm;
fish_data_f.f0_y_mm = fish_data_f.f0_y / resolution_px_mm;
%fish_data_f.f1_x_mm = fish_data_f.f1_x / resolution_px_mm;
%fish_data_f.f1_y_mm = fish_data_f.f1_y / resolution_px_mm;

%From stytra manual: the x axis increases to the right and the y axis increases downward, with (0,0) being the upper right corner.
% Plot both trajectories in millimeters
figure;
plot(fish_data_f.f0_x_mm, fish_data_f.f0_y_mm * -1, 'Color', 'red', 'DisplayName', 'Fish Trajectory');
hold on
%plot(fish_data_f.f1_y_mm, fish_data_f.f1_x_mm, 'Color', 'blue');
xlim([0, 800 / resolution_px_mm]);  % Set x-axis limits in millimeters
ylim([ -800 / resolution_px_mm, 0]);  % Set y-axis limits in millimeters
ylabel('Y Position (mm)');
xlabel('X Position (mm)');
title('Fish Trajectories (mm)');
legend;
% saveas(gcf, 'FishTrajectories.png');


%% Generate gratings

% Define the duration of each phase in seconds and number of repetitions
phase_duration = 20;
repetitions = 3;

% Initialize empty arrays to store time and movement colors
time = [];
movement_colors = [];

% Define the movement colors
colors.not_moving = [0.5, 0.5, 0.5];  % Gray
colors.moving_right = [1, 0, 0];      % Red
colors.moving_left = [0, 0, 1];       % Blue

% Repeat the stimulus pattern three times
for rep = 1:repetitions
    % Append time values and movement colors for each phase
    time_not_moving = length(time) + (1:phase_duration);
    time = [time, time_not_moving];
    movement_colors = [movement_colors; repmat(colors.not_moving, phase_duration, 1)];
    
    time_moving_right = length(time) + (1:phase_duration);
    time = [time, time_moving_right];
    movement_colors = [movement_colors; repmat(colors.moving_right, phase_duration, 1)];
    
    time_not_moving_2 = length(time) + (1:phase_duration);
    time = [time, time_not_moving_2];
    movement_colors = [movement_colors; repmat(colors.not_moving, phase_duration, 1)];
    
    time_moving_left = length(time) + (1:phase_duration);
    time = [time, time_moving_left];
    movement_colors = [movement_colors; repmat(colors.moving_left, phase_duration, 1)];
end

time_not_moving = length(time) + (1:phase_duration);
time = [time, time_not_moving];
movement_colors = [movement_colors; repmat(colors.not_moving, phase_duration, 1)];

% Plot movement of gratings over time
figure;
scatter(time, zeros(size(time)), 50, movement_colors, 'filled');
xlabel('Time (seconds)');
title('Movement of Gratings Over Time');
yticks([]);

%% Fish Speed and Tail speed calculation and plot


% FILTERING OUT WRONG FRAMES

% Compute differences in x and y positions
fish_data_f.f0_dx = [0; diff(fish_data_f.f0_x_mm)];
fish_data_f.f0_dy = [0; diff(fish_data_f.f0_y_mm)];
%fish_data_f.f1_dx = [0; diff(fish_data_f.f1_x_mm)];
%fish_data_f.f1_dy = [0; diff(fish_data_f.f1_y_mm)];

% Compute distance between consecutive positions
fish_data_f.f0_distance = sqrt(fish_data_f.f0_dx.^2 + fish_data_f.f0_dy.^2);
%fish_data_f.f1_distance = sqrt(fish_data_f.f1_dx.^2 + fish_data_f.f1_dy.^2);

% Define threshold for maximum allowable change in position (in mm)
position_threshold = 0.3;  % Adjust this threshold according to your specific case

% Filter out frames where the change in position exceeds the threshold
fish_data_f0_filtered = fish_data_f(fish_data_f.f0_distance <= position_threshold, :);
%fish_data_f1_filtered = fish_data_f(fish_data_f.f1_distance <= position_threshold, :);

framerate = 100; % Hz or fps which is 0.01 ms between each frame

% Plot fish speed
figure('Position', [100, 100, 1500, 300]);
fish_data_f0_filtered.speed_mm_per_sec = sqrt(fish_data_f0_filtered.f0_vx.^2 + fish_data_f0_filtered.f0_vy.^2) * framerate / resolution_px_mm;
%fish_data_f1_filtered.speed_mm_per_sec = sqrt(fish_data_f1_filtered.f1_vx.^2 + fish_data_f1_filtered.f1_vy.^2) * framerate / resolution_px_mm;
plot(fish_data_f0_filtered.Time, fish_data_f0_filtered.speed_mm_per_sec, 'Color', 'green', 'DisplayName', 'Fish 0 Trajectory');
hold on
%plot(fish_data_f1_filtered.Time, fish_data_f1_filtered.speed_mm_per_sec, 'Color', 'blue', 'DisplayName', 'Fish 1 Trajectory');
xlabel('Time');
ylabel('Speed (mm/sec)');
title('Fish Speed');
legend;

% Plot speed along y-axis
figure('Position', [100, 100, 1500, 300]);
plot(fish_data_f0_filtered.Time, -1 * fish_data_f0_filtered.f0_vy * framerate / resolution_px_mm, 'Color', 'green', 'DisplayName', 'Fish 0 Trajectory');
hold on
%plot(fish_data_f1_filtered.Time, -1 * fish_data_f1_filtered.f1_vy * framerate / resolution_px_mm, 'Color', 'blue', 'DisplayName', 'Fish 1 Trajectory');
xlabel('Time');
ylabel('Speed Vy (mm/sec)');
title('Fish Speed along Y-axis');
legend;

% Plot tail angle
figure('Position', [100, 100, 1500, 300]);
plot(fish_data_f0_filtered.Time, fish_data_f0_filtered.f0_vtheta, 'Color', 'green', 'DisplayName', 'Fish 0 Trajectory');
hold on
%plot(fish_data_f1_filtered.Time, fish_data_f1_filtered.f1_vtheta, 'Color', 'blue', 'DisplayName', 'Fish 1 Trajectory');
xlabel('Time');
ylabel('Tail angle');
title('Fish Tail angle');
legend;

% Set minimal threshold to remove the frames where the fish is not moving
threshold_speed = 1.5;

speed_f0_positive = fish_data_f0_filtered.speed_mm_per_sec(fish_data_f0_filtered.speed_mm_per_sec > threshold_speed);
%speed_f1_positive = fish_data_f1_filtered.speed_mm_per_sec(fish_data_f1_filtered.speed_mm_per_sec > threshold_speed);

% Calculation of mean and max speed
% CombinedSpeed = [speed_f0_positive; speed_f1_positive];
% meanSpeed = mean(CombinedSpeed);
% maxSpeed = max(CombinedSpeed);
meanSpeed = mean(speed_f0_positive);
maxSpeed = max(speed_f0_positive);

fprintf('Mean Speed (mm/sec): %.2f\n', meanSpeed);
fprintf('Max Speed (mm/sec): %.2f\n', maxSpeed);


%% Plotting of speed together with the gratings

% Calculate time in seconds for fish f0
fish_data_f0_filtered_seconds_A = fish_data_f0_filtered.Time.Minute * 60 + ...
                                  fish_data_f0_filtered.Time.Second;

% Calculate time in seconds for fish f1
%fish_data_f1_filtered_seconds_A = fish_data_f1_filtered.Time.Minute * 60 + ...
                                  %fish_data_f1_filtered.Time.Second;


% Plot gratings movement and fish speed
figure;
plot(fish_data_f0_filtered_seconds_A(3:end-1) - fish_data_f0_filtered_seconds_A(2), ...
    -1 * fish_data_f0_filtered.f0_vy(3:end-1) * framerate / resolution_px_mm, ...
    'g', 'LineWidth', 1.5);
hold on
%plot(fish_data_f1_filtered_seconds_A(3:end-1) - fish_data_f0_filtered_seconds_A(2), ...
    %-1 * fish_data_f1_filtered.f1_vy(3:end-1) * framerate / resolution_px_mm, ...
   % 'b', 'LineWidth', 1.5);
scatter(time, zeros(size(time)), 50, movement_colors, 'filled');
xlabel('Time (seconds)');
ylabel('Speed Vy');
xlim([0, 260]);
title('Gratings Movement and Fish Speed Over Time');
legend('Fish 0 Trajectory', 'Gratings Movement', 'Location', 'best');
grid on;
hold off;

% Save figure as PNG
% saveas(gcf, 'GratingsANDspeed.png');
%% Speed direction for each grating

% Define blue and red intervals for OMR
blue_intervals = [60 80; 140 160; 220 240];
red_intervals = [20 40; 100 120; 180 200];

% Initialize counters for positive and negative responses
amount_positive_f0 = 0;
amount_negative_f0 = 0;

% Convert time column to seconds and adjust to start from 0
fish_data_f.Time = fish_data_f.t ;

% Plot Vy vs. time during OMR stimulation with different colors for blue and red intervals
figure;
hold on;
for i = 1:size(blue_intervals, 1)
    start = blue_intervals(i, 1);
    end_time = blue_intervals(i, 2);
    
    % Filter data for blue interval
    omr_data = fish_data_f(fish_data_f.Time >= start & fish_data_f.Time <= end_time, :);
    omr_data_positive_f0 = omr_data(omr_data.f0_vy < 0, :); % Filter positive values
    
    % Calculate amount of time the fish spent responding well to OMR
    amount_positive_f0 = amount_positive_f0 + height(omr_data_positive_f0);
    
    % Plot positive responses for fish f0
    plot(omr_data_positive_f0.Time, -1 * omr_data_positive_f0.f0_vy * framerate / resolution_px_mm, 'b');
end

for i = 1:size(red_intervals, 1)
    start = red_intervals(i, 1);
    end_time = red_intervals(i, 2);
    
    % Filter data for red interval
    omr_data = fish_data_f(fish_data_f.Time >= start & fish_data_f.Time <= end_time, :);
    omr_data_negative_f0 = omr_data(omr_data.f0_vy > 0, :); % Filter negative values
    
    % Calculate amount of time the fish spent responding poorly to OMR
    amount_negative_f0 = amount_negative_f0 + height(omr_data_negative_f0);
    
    % Plot negative responses for fish f0
    plot(omr_data_negative_f0.Time, -1 * omr_data_negative_f0.f0_vy * framerate / resolution_px_mm, 'r');
end

% Plot gratings movement (assuming time and movement_colors are defined)
scatter(time, zeros(size(time)), 100, movement_colors, '_');

hold off;
xlabel('Time (s)');
ylabel('Fish speed (mm/s)');
title('Vy vs. Time during OMR Stimulation');
legend('Blue Interval (Fish 0)', 'Red Interval (Fish 0)', 'Gratings Movement');
grid on;
xlim([0 260]);

% Save figure as PNG
% saveas(gcf, 'SpeedPositiveOMR.png');

% Calculate total amount of time spent doing OMR
total_amount_OMR = (amount_positive_f0 + amount_negative_f0) / framerate;
percentage_total_OMR = (total_amount_OMR / 120) * 100;
fprintf('Time spent doing OMR (sec): %.2f\n', total_amount_OMR);
fprintf('Percentage of time spent doing OMR: %.2f%%\n', percentage_total_OMR);
    


%% Here the same calculation can be done for the Tail Angle

% Calculate fish tail angle as the mean of f1_theta_00, f1_theta_01, f1_theta_02, and f1_theta_03
fish_data_f.Tail_Angle_0 = mean((fish_data_f.f0_theta_03+fish_data_f.f0_theta_02)/2 - (fish_data_f.f0_theta_01+fish_data_f.f0_theta_00)/2, 2);
%fish_data_f.Tail_Angle_1 = mean((fish_data_f.f1_theta_03+fish_data_f.f1_theta_02)/2 - (fish_data_f.f1_theta_01+fish_data_f.f1_theta_00)/2, 2);

% omr_data_negative_f0.Tail_Angle_0 = mean((omr_data_negative_f0.f0_theta_03+omr_data_negative_f0.f0_theta_02)./2 - (omr_data_negative_f0.f0_theta_01+omr_data_negative_f0.f0_theta_00)./2, 2);
% omr_data_positive_f0.Tail_Angle_0 = mean((omr_data_negative_f0.f0_theta_03+omr_data_negative_f0.f0_theta_02)./2 - (omr_data_negative_f0.f0_theta_01+omr_data_negative_f0.f0_theta_00)./2, 2);

plot(fish_data_f.Tail_Angle_0)


% Convert tail angles from radians to degrees
fish_data_f.Tail_Angle_0 = rad2deg(fish_data_f.Tail_Angle_0);
%fish_data_f.Tail_Angle_1 = rad2deg(fish_data_f.Tail_Angle_1);

% Filter out tail angle values greater than anglemax (30) degrees and smaller than -anglemax (-50) degrees
    anglemax = 20; %maximal and minimal degrees to consider
fish_data_f.Tail_Angle_0(fish_data_f.Tail_Angle_0 > anglemax | fish_data_f.Tail_Angle_0 < -anglemax) = NaN;
%fish_data_f.Tail_Angle_1(fish_data_f.Tail_Angle_1 > anglemax | fish_data_f.Tail_Angle_1 < -anglemax) = NaN;

% Filter out tail angle values smaller than a certain noise of anglenoise (0.5) degrees
anglenoise = 0; %Noise values to remove
fish_data_f.Tail_Angle_0(abs(fish_data_f.Tail_Angle_0) < anglenoise) = NaN;
%fish_data_f.Tail_Angle_1(abs(fish_data_f.Tail_Angle_1) < anglenoise) = NaN;


% Plot tail angle vs. time during OMR stimulation with different colors for blue and red intervals
figure;
hold on;
for i = 1:size(blue_intervals, 1)
    start = blue_intervals(i, 1);
    end_time = blue_intervals(i, 2);
    
    % Filter data for blue interval
    omr_data = fish_data_f(fish_data_f.Time >= start & fish_data_f.Time <= end_time, :);
    
    % Plot tail angle for fish 0 and fish 1 during blue interval
    plot(omr_data.Time, omr_data.Tail_Angle_0, 'b');
    %plot(omr_data.Time, omr_data.Tail_Angle_1, 'b');
end

for i = 1:size(red_intervals, 1)
    start = red_intervals(i, 1);
    end_time = red_intervals(i, 2);
    
    % Filter data for red interval
    omr_data = fish_data_f(fish_data_f.Time >= start & fish_data_f.Time <= end_time, :);
    
    % Plot tail angle for fish 0 and fish 1 during red interval
    plot(omr_data.Time, omr_data.Tail_Angle_0, 'r');
    %plot(omr_data.Time, omr_data.Tail_Angle_1, 'r');
end

hold off;
xlabel('Time (s)');
ylabel('Tail Angle (degrees)');
title('Tail Angle vs. Time during OMR Stimulation');
legend('Blue Interval (Fish 0)', 'Blue Interval (Fish 1)', 'Red Interval (Fish 0)', 'Red Interval (Fish 1)', 'Location', 'best');
grid on;
xlim([0 260]);


% From stytra manual: the x axis increases to the right and the y axis increases downward, with (0,0) being the upper right corner.

% Define time columns for both fish
fish_time_column = 't';

% Calculate the time difference in seconds and add it to the start_time
fish_data_f.Time = start_time + seconds(fish_data_f.(fish_time_column));

% Convert pixel positions to millimeters
resolution_px_mm = 13.333;  % 13.333 px/mm resolution

fish_data_f.f0_x_mm = fish_data_f.f0_x / resolution_px_mm;
fish_data_f.f0_y_mm = fish_data_f.f0_y / resolution_px_mm;

% Compute differences in y positions
fish_data_f.f0_dy = [0; diff(fish_data_f.f0_y_mm)];

% Define blue and red intervals for OMR
blue_intervals = [60 80; 140 160; 220 240];
red_intervals = [20 40; 100 120; 180 200];
grey_intervals =  [0 20; 40 60; 80 100; 120 140; 160 180; 200 220];

% Initialize counters for distances
total_distance_blue = 0;
total_distance_red = 0;
total_distance_blue_negative = 0;
total_distance_red_negative = 0;
total_distance_grey = 0;
total_distance_greyright = 0;
total_distance_greyleft = 0;

% Convert time column to seconds and adjust to start from 0
fish_data_f.Time_Seconds = seconds(fish_data_f.Time - start_time);

% Calculate total distance moved during each blue interval
for i = 1:size(blue_intervals, 1)
    start = blue_intervals(i, 1);
    end_time = blue_intervals(i, 2);
    
    % Filter data for blue interval and ignore NaN values
    omr_data = fish_data_f(fish_data_f.Time_Seconds >= start & fish_data_f.Time_Seconds <= end_time, :);
    omr_data = omr_data(~isnan(omr_data.f0_dy), :); % Ignore NaN values
    
    % Calculate total distance moved in the blue direction
    total_distance_blue = total_distance_blue + sum(omr_data.f0_dy(omr_data.f0_dy < 0));
    total_distance_blue_negative = total_distance_blue_negative + sum(omr_data.f0_dy(omr_data.f0_dy > 0));
end

% Calculate total distance moved during each red interval
for i = 1:size(red_intervals, 1)
    start = red_intervals(i, 1);
    end_time = red_intervals(i, 2);
    
    % Filter data for red interval and ignore NaN values
    omr_data = fish_data_f(fish_data_f.Time_Seconds >= start & fish_data_f.Time_Seconds <= end_time, :);
    omr_data = omr_data(~isnan(omr_data.f0_dy), :); % Ignore NaN values

    % Calculate total distance moved in the red direction
    total_distance_red = total_distance_red + sum(omr_data.f0_dy(omr_data.f0_dy > 0));
    total_distance_red_negative = total_distance_red_negative + sum(omr_data.f0_dy(omr_data.f0_dy < 0));
end

% Calculate total distance moved during grey intervals
for i = 1:size(grey_intervals, 1)
    start = grey_intervals(i, 1);
    end_time = grey_intervals(i, 2);
    
    % Filter data for grey interval and ignore NaN values
    omr_data = fish_data_f(fish_data_f.Time_Seconds >= start & fish_data_f.Time_Seconds <= end_time, :);
    omr_data = omr_data(~isnan(omr_data.f0_dy), :); % Ignore NaN values
    
    % Calculate total distance moved during grey intervals
    total_distance_grey = total_distance_grey + sum(abs(omr_data.f0_dy)); % Absolute movement in both directions
    
    % Calculate total rightward and leftward movement
    total_distance_greyright = total_distance_greyright + sum(omr_data.f0_dy(omr_data.f0_dy > 0)); % Rightward movement (positive dy)
    total_distance_greyleft = total_distance_greyleft + sum(abs(omr_data.f0_dy(omr_data.f0_dy < 0))); % Leftward movement (negative dy)
end

% Display total distances
fprintf('Total distance moved in the direction of the gratings (blue): %.2f mm\n', total_distance_blue);
fprintf('Total distance moved in the opposite direction of the gratings (blue): %.2f mm\n', total_distance_blue_negative);
fprintf('Total distance moved in the direction of the gratings (red): %.2f mm\n', total_distance_red);
fprintf('Total distance moved in the opposite direction of the gratings (red): %.2f mm\n', total_distance_red_negative);
fprintf('Total distance moved when no stimulus: %.2f mm\n', total_distance_grey);
fprintf('Total distance moved in grey right: %.2f mm\n', total_distance_greyright);
fprintf('Total distance moved in grey left: %.2f mm\n', total_distance_greyleft);



%% Latency calculations

% Calculate latency for blue and red intervals
[latency_blue, avg_latency_blue] = calculate_latency(fish_data_f, blue_intervals, framerate, threshold_speed, -1, resolution_px_mm);
[latency_red, avg_latency_red] = calculate_latency(fish_data_f, red_intervals, framerate, threshold_speed, 1, resolution_px_mm);

% Convert duration to seconds for printing
avg_latency_blue_seconds = seconds(avg_latency_blue);
avg_latency_red_seconds = seconds(avg_latency_red);

% Display the average latencies
fprintf('Average Latency (Blue Intervals): %.2f seconds\n', avg_latency_blue_seconds);
fprintf('Average Latency (Red Intervals): %.2f seconds\n', avg_latency_red_seconds);

% Calculate combined latency for all intervals
combined_latencies = [latency_blue; latency_red];
avg_total = mean(combined_latencies, 'omitnan');

% Convert avg_total duration to seconds for printing
avg_total_seconds = seconds(avg_total);

% Display the total average latency
fprintf('Average Total Latency: %.2f seconds\n', avg_total_seconds);


function [latencies, avg_latency] = calculate_latency(data, intervals, framerate, threshold_speed, direction, resolution_px_mm)
    latencies = [];
    for i = 1:size(intervals, 1)
        start_time = intervals(i, 1);
        end_time = intervals(i, 2);
        
        % Convert start_time and end_time to datetime
        start_datetime = data.Time(1) + seconds(start_time);
        end_datetime = data.Time(1) + seconds(end_time);
        
        % Filter data within the specified interval
        omr_data = data(data.Time >= start_datetime & data.Time <= end_datetime, :);
        
        % Compute speed if not already computed
        omr_data.speed_mm_per_sec = sqrt(omr_data.f0_vx.^2 + omr_data.f0_vy.^2) * framerate / resolution_px_mm;
        
        if direction == -1
            omr_data_filtered = omr_data(omr_data.f0_vy < 0 & omr_data.speed_mm_per_sec > threshold_speed, :);
        else
            omr_data_filtered = omr_data(omr_data.f0_vy > 0 & omr_data.speed_mm_per_sec > threshold_speed, :);
        end
        
        if ~isempty(omr_data_filtered)
            latency = omr_data_filtered.Time(1) - start_datetime;
            latencies = [latencies; latency];
        else
            latencies = [latencies; NaN];
        end
    end
    
    avg_latency = mean(latencies, 'omitnan');  % Calculate average latency, ignoring NaNs
end


