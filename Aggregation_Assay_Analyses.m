% Load the 16-bit TIFF image
image = imread('/Users/elena_1/Desktop/PHD/Gfi1ab/aggregationAssay/07092023/RFP-agg1.2_w1Red.TIF');

% Define thresholds
contrast_threshold = 300; % Contrast threshold for detecting structures - should be based on specificc threshold you set with controls!!
maximalradius = 100;       % Maximum radius for visualizing circles
min_area_threshold = 40;   % Minimum area threshold for filtering small structures

% Normalize the image to the range [0, 1]
normalized_image = double(image) / double(intmax(class(image)));

% Apply a contrast threshold to detect structures
binary_image = normalized_image >= (contrast_threshold / double(intmax(class(image))));

% Find connected components (structures) in the binary image
cc = bwconncomp(binary_image);

% Create a labeled image with different labels for each structure
labeled_image = labelmatrix(cc);

% Count the number of structures
num_structures = cc.NumObjects;
fprintf('Number of structures detected: %d\n', num_structures);

% Get properties of the structures
stats = regionprops(cc, 'Centroid', 'MajorAxisLength', 'Area');

% Display the result image with colored circles
imagesc(binary_image);
colormap(gray); % Apply the custom colormap.
title('Detected Structures');

% Loop through the structures and draw circles around those that meet the size criteria
for structure_id = 1:num_structures
    % Get the area of the current structure
    area = stats(structure_id).Area;
    
    % Filter out structures that are too small
    if area >= min_area_threshold
        center = stats(structure_id).Centroid;
        radius = stats(structure_id).MajorAxisLength / 2;
        
        % Draw a circle using the rectangle function
        rectangle('Position', [center(1) - radius, center(2) - radius, 2 * radius, 2 * radius], ...
                  'Curvature', [1, 1],  'LineWidth', 2);
        viscircles(center, radius, 'EdgeColor', [radius/maximalradius 0 1], 'LineWidth', 2);
    end
end
