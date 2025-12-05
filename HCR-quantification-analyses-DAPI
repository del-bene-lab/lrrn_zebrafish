% File paths
hcr1Path = '/Users/elena_1/Desktop/PHD/Gfi1ab/REVISIONS/HCRquantifications/lrrn3bHCR/20240327-8us-1/lrrn2.csv';
hcr2Path = '/Users/elena_1/Desktop/PHD/Gfi1ab/REVISIONS/HCRquantifications/lrrn3bHCR/20240327-8us-1/lrrn3a.csv';
hcr3Path = '/Users/elena_1/Desktop/PHD/Gfi1ab/REVISIONS/HCRquantifications/lrrn3bHCR/20240327-8us-1/lrrn3b.csv';  % Replace with correct filename
dapiPath = '/Users/elena_1/Desktop/PHD/Gfi1ab/REVISIONS/HCRquantifications/gfiHCR/new/m7/dapi-mut7.csv';

% Read data
hcr1 = readtable(hcr1Path);
hcr2 = readtable(hcr2Path);
hcr3 = readtable(hcr3Path);
dapi = readtable(dapiPath);

% Setup presence flags for each DAPI ROI
containsHCR1 = false(height(dapi),1);
containsHCR2 = false(height(dapi),1);
containsHCR3 = false(height(dapi),1);

% Function to check if point is within a DAPI "cell"
isInsideDapi = @(x, y, dapiX, dapiY, dapiRadius) ...
    sqrt((x - dapiX).^2 + (y - dapiY).^2) <= dapiRadius;

% --- Assign HCR1 dots to DAPI cells ---
for i = 1:height(hcr1)
    x = hcr1.X(i);
    y = hcr1.Y(i);
    for j = 1:height(dapi)
        dapiX = dapi.X(j);
        dapiY = dapi.Y(j);
        r = sqrt(dapi.Area(j) / pi); % Circular assumption
        if isInsideDapi(x, y, dapiX, dapiY, r)
            containsHCR1(j) = true;
            break;
        end
    end
end

% --- HCR2 ---
for i = 1:height(hcr2)
    x = hcr2.X(i);
    y = hcr2.Y(i);
    for j = 1:height(dapi)
        dapiX = dapi.X(j);
        dapiY = dapi.Y(j);
        r = sqrt(dapi.Area(j) / pi);
        if isInsideDapi(x, y, dapiX, dapiY, r)
            containsHCR2(j) = true;
            break;
        end
    end
end

% % --- HCR3 ---
 for i = 1:height(hcr3)
     x = hcr3.X(i);
     y = hcr3.Y(i);
     for j = 1:height(dapi)
         dapiX = dapi.X(j);
         dapiY = dapi.Y(j);
         r = sqrt(dapi.Area(j) / pi);
         if isInsideDapi(x, y, dapiX, dapiY, r)
             containsHCR3(j) = true;
             break;
         end
     end
 end

% --- Coexpression categories ---
only1     = containsHCR1 & ~containsHCR2 & ~containsHCR3;
only2     = containsHCR2 & ~containsHCR1 & ~containsHCR3;
only3     = containsHCR3 & ~containsHCR1 & ~containsHCR2;
both12    = containsHCR1 & containsHCR2 & ~containsHCR3;
both13    = containsHCR1 & containsHCR3 & ~containsHCR2;
both23    = containsHCR2 & containsHCR3 & ~containsHCR1;
all123    = containsHCR1 & containsHCR2 & containsHCR3;

% --- Display results ---
fprintf('\n--- Cell-Level Coexpression Summary (Mutually Exclusive) ---\n');
fprintf('Total DAPI (cells): %d\n\n', height(dapi));

fprintf('Only HCR1: %d\n', sum(only1));
fprintf('Only HCR2: %d\n', sum(only2));
fprintf('Only HCR3: %d\n', sum(only3));
fprintf('HCR1 + HCR2 only: %d\n', sum(both12));
fprintf('HCR1 + HCR3 only: %d\n', sum(both13));
fprintf('HCR2 + HCR3 only: %d\n', sum(both23));
fprintf('HCR1 + HCR2 + HCR3: %d\n', sum(all123));

% Double check totals
fprintf('\nSanity Check:\n');
fprintf('Total classified cells: %d (should match DAPI count)\n', ...
    sum(only1 | only2 | only3 | both12 | both13 | both23 | all123));

% Percentages for each HCR individually
numCellsWithHCR1 = sum(containsHCR1);
numCellsWithHCR2 = sum(containsHCR2);
numCellsWithHCR3 = sum(containsHCR3);

fprintf('\n--- Presence of Each HCR (regardless of coexpression) ---\n');
fprintf('DAPI cells with HCR1: %d (%.1f%%)\n', numCellsWithHCR1, 100 * numCellsWithHCR1 / height(dapi));
fprintf('DAPI cells with HCR2: %d (%.1f%%)\n', numCellsWithHCR2, 100 * numCellsWithHCR2 / height(dapi));
fprintf('DAPI cells with HCR3: %d (%.1f%%)\n', numCellsWithHCR3, 100 * numCellsWithHCR3 / height(dapi));

%%
% File paths
hcr1Path = '/Users/elena_1/Downloads/eom2.csv';
hcr2Path = '/Users/elena_1/Downloads/lrrn2-2.csv';
hcr3Path = '/Users/elena_1/Downloads/lrrn3a-2.csv';  % Replace with correct filename
dapiPath = '/Users/elena_1/Downloads/dapi-2.csv';

% Read data
hcr1 = readtable(hcr1Path);
hcr2 = readtable(hcr2Path);
hcr3 = readtable(hcr3Path);
dapi = readtable(dapiPath);

% Setup presence flags for each DAPI ROI
containsHCR1 = false(height(dapi),1);
containsHCR2 = false(height(dapi),1);
containsHCR3 = false(height(dapi),1);

% Function to check if point is within a DAPI "cell"
isInsideDapi = @(x, y, dapiX, dapiY, dapiRadius) ...
    sqrt((x - dapiX).^2 + (y - dapiY).^2) <= dapiRadius;

% Helper function for circle overlap
circlesOverlap = @(x1,y1,r1,x2,y2,r2) sqrt((x1 - x2).^2 + (y1 - y2).^2) <= (r1 + r2);

% --- Assign HCR1 dots to DAPI cells with area overlap ---
for i = 1:height(hcr1)
    x = hcr1.X(i);
    y = hcr1.Y(i);
    r_hcr = sqrt(hcr1.Area(i) / pi);
    for j = 1:height(dapi)
        dapiX = dapi.X(j);
        dapiY = dapi.Y(j);
        r_dapi = sqrt(dapi.Area(j) / pi); % DAPI radius
        if circlesOverlap(x, y, r_hcr, dapiX, dapiY, r_dapi)
            containsHCR1(j) = true;
            break;
        end
    end
end

% --- HCR2 ---
for i = 1:height(hcr2)
    x = hcr2.X(i);
    y = hcr2.Y(i);
    r_hcr = sqrt(hcr2.Area(i) / pi);
    for j = 1:height(dapi)
        dapiX = dapi.X(j);
        dapiY = dapi.Y(j);
        r_dapi = sqrt(dapi.Area(j) / pi);
        if circlesOverlap(x, y, r_hcr, dapiX, dapiY, r_dapi)
            containsHCR2(j) = true;
            break;
        end
    end
end

% --- HCR3 ---
for i = 1:height(hcr3)
    x = hcr3.X(i);
    y = hcr3.Y(i);
    r_hcr = sqrt(hcr3.Area(i) / pi);
    for j = 1:height(dapi)
        dapiX = dapi.X(j);
        dapiY = dapi.Y(j);
        r_dapi = sqrt(dapi.Area(j) / pi);
        if circlesOverlap(x, y, r_hcr, dapiX, dapiY, r_dapi)
            containsHCR3(j) = true;
            break;
        end
    end
end


% --- Coexpression categories ---
only1     = containsHCR1 & ~containsHCR2 & ~containsHCR3;
only2     = containsHCR2 & ~containsHCR1 & ~containsHCR3;
only3     = containsHCR3 & ~containsHCR1 & ~containsHCR2;
both12    = containsHCR1 & containsHCR2 & ~containsHCR3;
both13    = containsHCR1 & containsHCR3 & ~containsHCR2;
both23    = containsHCR2 & containsHCR3 & ~containsHCR1;
all123    = containsHCR1 & containsHCR2 & containsHCR3;

% --- Display results ---
fprintf('\n--- Cell-Level Coexpression Summary (Mutually Exclusive) ---\n');
fprintf('Total DAPI (cells): %d\n\n', height(dapi));

fprintf('Only HCR1: %d\n', sum(only1));
fprintf('Only HCR2: %d\n', sum(only2));
fprintf('Only HCR3: %d\n', sum(only3));
fprintf('HCR1 + HCR2 only: %d\n', sum(both12));
fprintf('HCR1 + HCR3 only: %d\n', sum(both13));
fprintf('HCR2 + HCR3 only: %d\n', sum(both23));
fprintf('HCR1 + HCR2 + HCR3: %d\n', sum(all123));

% Double check totals
fprintf('\nSanity Check:\n');
fprintf('Total classified cells: %d (should match DAPI count)\n', ...
    sum(only1 | only2 | only3 | both12 | both13 | both23 | all123));

% Percentages for each HCR individually
numCellsWithHCR1 = sum(containsHCR1);
numCellsWithHCR2 = sum(containsHCR2);
numCellsWithHCR3 = sum(containsHCR3);

fprintf('\n--- Presence of Each HCR (regardless of coexpression) ---\n');
fprintf('DAPI cells with HCR1: %d (%.1f%%)\n', numCellsWithHCR1, 100 * numCellsWithHCR1 / height(dapi));
fprintf('DAPI cells with HCR2: %d (%.1f%%)\n', numCellsWithHCR2, 100 * numCellsWithHCR2 / height(dapi));
fprintf('DAPI cells with HCR3: %d (%.1f%%)\n', numCellsWithHCR3, 100 * numCellsWithHCR3 / height(dapi));
%% ccells colocalizations
% Extract only the DAPI ROIs with all 3 HCRs
coexpressingDapi = dapi(all123, :);

% Calculate radii
radii = sqrt(coexpressingDapi.Area / pi);

% Create figure
figure;
hold on;
axis equal;
title('Cells Coexpressing HCR1, HCR2, and HCR3');
xlabel('X');
ylabel('Y');

% Draw circles representing the cells
for i = 1:height(coexpressingDapi)
    x = coexpressingDapi.X(i);
    y = coexpressingDapi.Y(i);
    r = radii(i);
    theta = linspace(0, 2*pi, 100);
    fill(x + r*cos(theta), y + r*sin(theta), [1 0.5 0], 'FaceAlpha', 0.4, 'EdgeColor', 'k');
end

hold off;

%%
% File paths
hcr1Path = '/Users/elena_1/Downloads/gfi-mut7.csv';
hcr2Path = '/Users/elena_1/Downloads/lrrn3a-mut7.csv';
dapiPath = '/Users/elena_1/Downloads/dapi-mut7.csv';

% Read tables
hcr1 = readtable(hcr1Path);
hcr2 = readtable(hcr2Path);
dapi = readtable(dapiPath);

% Helper function to check if a dot is inside a circular ROI
isInside = @(x, y, cx, cy, r) sqrt((x - cx).^2 + (y - cy).^2) <= r;

% --- Count HCR1 dots inside DAPI cells ---
dotsInDapi_HCR1 = 0;
for i = 1:height(hcr1)
    x = hcr1.X(i);
    y = hcr1.Y(i);
    for j = 1:height(dapi)
        cx = dapi.X(j);
        cy = dapi.Y(j);
        r = sqrt(dapi.Area(j) / pi);  % radius from area
        if isInside(x, y, cx, cy, r)
            dotsInDapi_HCR1 = dotsInDapi_HCR1 + 1;
            break;  % Only count once
        end
    end
end

% --- Count HCR2 dots inside DAPI cells ---
dotsInDapi_HCR2 = 0;
for i = 1:height(hcr2)
    x = hcr2.X(i);
    y = hcr2.Y(i);
    for j = 1:height(dapi)
        cx = dapi.X(j);
        cy = dapi.Y(j);
        r = sqrt(dapi.Area(j) / pi);
        if isInside(x, y, cx, cy, r)
            dotsInDapi_HCR2 = dotsInDapi_HCR2 + 1;
            break;
        end
    end
end

% --- Output ---
fprintf('\n=== Total Dot Counts Inside DAPI Cells ===\n');
fprintf('HCR1 dots inside DAPI: %d\n', dotsInDapi_HCR1);
fprintf('HCR2 dots inside DAPI: %d\n', dotsInDapi_HCR2);


%% For only one channel
% File paths
hcr1Path = '/Users/elena_1/Desktop/PHD/Gfi1ab/REVISIONS/HCRquantifications/ptf1a/gfi1ab/fish1/ptf1a.csv';
dapiPath = '/Users/elena_1/Desktop/PHD/Gfi1ab/REVISIONS/HCRquantifications/ptf1a/gfi1ab/fish1/dapi-1.csv';

% Read data
hcr1 = readtable(hcr1Path);
dapi = readtable(dapiPath);

% Setup presence flag for each DAPI ROI
containsHCR1 = false(height(dapi),1);

% Function to check if point is within a DAPI "cell"
isInsideDapi = @(x, y, dapiX, dapiY, dapiRadius) ...
    sqrt((x - dapiX).^2 + (y - dapiY).^2) <= dapiRadius;

% Assign HCR1 dots to DAPI cells
for i = 1:height(hcr1)
    x = hcr1.X(i);
    y = hcr1.Y(i);
    for j = 1:height(dapi)
        dapiX = dapi.X(j);
        dapiY = dapi.Y(j);
        r = sqrt(dapi.Area(j) / pi); % Assume circular ROI
        if isInsideDapi(x, y, dapiX, dapiY, r)
            containsHCR1(j) = true;
            break; % A dot can only belong to one DAPI cell
        end
    end
end

% Results
numColocalized = sum(containsHCR1);
totalDAPI = height(dapi);
percentColocalized = 100 * numColocalized / totalDAPI;

% Display
fprintf('\n--- HCR1 and DAPI Colocalization ---\n');
fprintf('Total DAPI cells: %d\n', totalDAPI);
fprintf('DAPI cells with at least one HCR1 dot: %d (%.1f%%)\n', ...
    numColocalized, percentColocalized);


%% For 2

% File paths
hcrPath      = '/Users/elena_1/Downloads/gfi-1.csv';
dapiPath     = '/Users/elena_1/Downloads/dapi-1.csv';
cellposePath = '/Users/elena_1/Downloads/eom-1.csv';


% Read data
hcr      = readtable(hcrPath);
dapi     = readtable(dapiPath);
cellpose = readtable(cellposePath);

% Flags per HCR dot
insideDAPI     = false(height(hcr), 1);
insideCellpose = false(height(hcr), 1);

% Flags per DAPI cell: does it contain any HCR dot?
containsHCR_DAPI = false(height(dapi), 1);

% Function to check if a point is inside a circular ROI
isInside = @(x, y, roiX, roiY, roiRadius) ...
    sqrt((x - roiX).^2 + (y - roiY).^2) <= roiRadius;

% --- Check colocalization with DAPI ---
for i = 1:height(hcr)
    x = hcr.X(i);
    y = hcr.Y(i);
    for j = 1:height(dapi)
        r = sqrt(dapi.Area(j) / pi);
        if isInside(x, y, dapi.X(j), dapi.Y(j), r)
            insideDAPI(i) = true;
            containsHCR_DAPI(j) = true;  % mark DAPI cell
            break;
        end
    end
end

% --- Check colocalization with Cellpose ---
for i = 1:height(hcr)
    x = hcr.X(i);
    y = hcr.Y(i);
    for j = 1:height(cellpose)
        r = sqrt(cellpose.Area(j) / pi);
        if isInside(x, y, cellpose.X(j), cellpose.Y(j), r)
            insideCellpose(i) = true;
            break;
        end
    end
end

% --- Dot-based categories ---
onlyDAPI     = insideDAPI & ~insideCellpose;
onlyCellpose = insideCellpose & ~insideDAPI;
both         = insideDAPI & insideCellpose;
neither      = ~insideDAPI & ~insideCellpose;

% --- DAPI cell summary ---
numDapiCellsWithHCR = sum(containsHCR_DAPI);
totalDapiCells = height(dapi);
percentDapiWithHCR = 100 * numDapiCellsWithHCR / totalDapiCells;

% --- Print Results ---
fprintf('\n--- HCR Dot Colocalization Summary ---\n');
fprintf('Total HCR dots: %d\n\n', height(hcr));
fprintf('Dots in DAPI only: %d (%.1f%%)\n', sum(onlyDAPI), ...
    100 * sum(onlyDAPI) / height(hcr));
fprintf('Dots in Cellpose only: %d (%.1f%%)\n', sum(onlyCellpose), ...
    100 * sum(onlyCellpose) / height(hcr));
fprintf('Dots in both DAPI + Cellpose: %d (%.1f%%)\n', sum(both), ...
    100 * sum(both) / height(hcr));
fprintf('Dots in neither: %d (%.1f%%)\n', sum(neither), ...
    100 * sum(neither) / height(hcr));

fprintf('\n--- DAPI Cell-Level HCR Summary ---\n');
fprintf('Total DAPI cells: %d\n', totalDapiCells);
fprintf('DAPI cells with ≥1 HCR dot: %d (%.1f%%)\n', ...
    numDapiCellsWithHCR, percentDapiWithHCR);

%% too have ptf and dapi as cells
hcrPath      = '/Users/elena_1/Downloads/lrrn2-8.csv';
dapiPath     = '/Users/elena_1/Downloads/dapi-8.csv';
cellposePath = '/Users/elena_1/Downloads/ptf-8.csv';

% Read data
hcr      = readtable(hcrPath);
dapi     = readtable(dapiPath);
cellpose = readtable(cellposePath);

% Flags per HCR dot
insideDAPI     = false(height(hcr), 1);
insideCellpose = false(height(hcr), 1);

% Flags per ROI: does each cell contain at least one HCR dot?
containsHCR_DAPI     = false(height(dapi), 1);
containsHCR_Cellpose = false(height(cellpose), 1);

% Function to check if a point lies within a circular ROI
isInside = @(x, y, roiX, roiY, roiRadius) ...
    sqrt((x - roiX).^2 + (y - roiY).^2) <= roiRadius;

% --- Check colocalization with DAPI ---
for i = 1:height(hcr)
    x = hcr.X(i);
    y = hcr.Y(i);
    for j = 1:height(dapi)
        r = sqrt(dapi.Area(j) / pi);
        if isInside(x, y, dapi.X(j), dapi.Y(j), r)
            insideDAPI(i) = true;
            containsHCR_DAPI(j) = true;
            break;
        end
    end
end

% --- Check colocalization with Cellpose ---
for i = 1:height(hcr)
    x = hcr.X(i);
    y = hcr.Y(i);
    for j = 1:height(cellpose)
        r = sqrt(cellpose.Area(j) / pi);
        if isInside(x, y, cellpose.X(j), cellpose.Y(j), r)
            insideCellpose(i) = true;
            containsHCR_Cellpose(j) = true;
            break;
        end
    end
end

% --- Dot-level categories ---
onlyDAPI     = insideDAPI & ~insideCellpose;
onlyCellpose = insideCellpose & ~insideDAPI;
both         = insideDAPI & insideCellpose;
neither      = ~insideDAPI & ~insideCellpose;

% --- Cell-level summaries ---
numDapiCellsWithHCR     = sum(containsHCR_DAPI);
numCellposeCellsWithHCR = sum(containsHCR_Cellpose);

totalDapiCells     = height(dapi);
totalCellposeCells = height(cellpose);

% --- Print Results ---
fprintf('\n--- HCR Dot Colocalization Summary (dot-level) ---\n');
fprintf('Total HCR dots: %d\n\n', height(hcr));
fprintf('Dots in DAPI only: %d (%.1f%%)\n', sum(onlyDAPI), ...
    100 * sum(onlyDAPI) / height(hcr));
fprintf('Dots in Cellpose only: %d (%.1f%%)\n', sum(onlyCellpose), ...
    100 * sum(onlyCellpose) / height(hcr));
fprintf('Dots in both DAPI + Cellpose: %d (%.1f%%)\n', sum(both), ...
    100 * sum(both) / height(hcr));
fprintf('Dots in neither: %d (%.1f%%)\n', sum(neither), ...
    100 * sum(neither) / height(hcr));

fprintf('\n--- Cell-Level HCR Summary ---\n');
fprintf('Total DAPI cells: %d\n', totalDapiCells);
fprintf('DAPI cells with ≥1 HCR dot: %d (%.1f%%)\n', ...
    numDapiCellsWithHCR, 100 * numDapiCellsWithHCR / totalDapiCells);

fprintf('\nTotal Cellpose cells: %d\n', totalCellposeCells);
fprintf('Cellpose cells with ≥1 HCR dot: %d (%.1f%%)\n', ...
    numCellposeCellsWithHCR, 100 * numCellposeCellsWithHCR / totalCellposeCells);

%% to have ccolocalizations within and outside ptf cells
% File paths
hcr1Path     = '/Users/elena_1/Downloads/lrrn2-8.csv';
hcr2Path     = '/Users/elena_1/Downloads/lrrn3a-8.csv';
dapiPath     = '/Users/elena_1/Downloads/dapi-8.csv';
cellposePath = '/Users/elena_1/Downloads/ptf-8.csv';

% Read data
hcr1     = readtable(hcr1Path);
hcr2     = readtable(hcr2Path);
dapi     = readtable(dapiPath);
cellpose = readtable(cellposePath);

% Initialize flags per DAPI cell
containsHCR1 = false(height(dapi), 1);
containsHCR2 = false(height(dapi), 1);
isInCellpose = false(height(dapi), 1);  % whether this DAPI cell overlaps with Cellpose

% Point-in-circle helper
isInside = @(x, y, cx, cy, r) sqrt((x - cx).^2 + (y - cy).^2) <= r;

% --- Assign HCR1 dots to DAPI cells ---
for i = 1:height(hcr1)
    x = hcr1.X(i);
    y = hcr1.Y(i);
    for j = 1:height(dapi)
        r = sqrt(dapi.Area(j) / pi);
        if isInside(x, y, dapi.X(j), dapi.Y(j), r)
            containsHCR1(j) = true;
            break;
        end
    end
end

% --- Assign HCR2 dots to DAPI cells ---
for i = 1:height(hcr2)
    x = hcr2.X(i);
    y = hcr2.Y(i);
    for j = 1:height(dapi)
        r = sqrt(dapi.Area(j) / pi);
        if isInside(x, y, dapi.X(j), dapi.Y(j), r)
            containsHCR2(j) = true;
            break;
        end
    end
end

% --- Determine which DAPI cells overlap Cellpose-defined cells ---
for i = 1:height(dapi)
    x = dapi.X(i);
    y = dapi.Y(i);
    for j = 1:height(cellpose)
        r = sqrt(cellpose.Area(j) / pi);
        if isInside(x, y, cellpose.X(j), cellpose.Y(j), r)
            isInCellpose(i) = true;
            break;
        end
    end
end

% --- Define coexpression categories by DAPI cell ---
onlyHCR1  = containsHCR1 & ~containsHCR2;
onlyHCR2  = containsHCR2 & ~containsHCR1;
bothHCRs  = containsHCR1 & containsHCR2;
neither   = ~containsHCR1 & ~containsHCR2;

% Now split these categories into inside/outside Cellpose
onlyHCR1_in     = onlyHCR1 & isInCellpose;
onlyHCR1_out    = onlyHCR1 & ~isInCellpose;
onlyHCR2_in     = onlyHCR2 & isInCellpose;
onlyHCR2_out    = onlyHCR2 & ~isInCellpose;
both_in         = bothHCRs & isInCellpose;
both_out        = bothHCRs & ~isInCellpose;

% --- Results ---
fprintf('\n--- HCR1 & HCR2 Colocalization in DAPI Cells ---\n');
fprintf('Total DAPI cells: %d\n\n', height(dapi));

fprintf('Only HCR1 inside Cellpose: %d\n', sum(onlyHCR1_in));
fprintf('Only HCR1 outside Cellpose: %d\n', sum(onlyHCR1_out));

fprintf('Only HCR2 inside Cellpose: %d\n', sum(onlyHCR2_in));
fprintf('Only HCR2 outside Cellpose: %d\n', sum(onlyHCR2_out));

fprintf('Both HCR1 + HCR2 inside Cellpose: %d\n', sum(both_in));
fprintf('Both HCR1 + HCR2 outside Cellpose: %d\n', sum(both_out));


