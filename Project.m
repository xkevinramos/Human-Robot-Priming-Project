% Clear the workspace and the screen
close all;
clear all;
clearvars;

Screen('Preference', 'SkipSyncTests', 1);  

% Define black, white and greyq
black = BlackIndex(0);
white = WhiteIndex(0);
grey = white / 2;

% Define images
myimg1 = imread('Human_hand_1','jpg');
myimg2 = imread('Human_hand_2', 'jpg');
myimg3 = imread('Robot_hand_1','jpg');
myimg4 = imread('Robot_hand_2','jpg');

% Stores 12 human images, 12 robot images
image_array = [{myimg1} {myimg1} {myimg1} {myimg1} {myimg1} {myimg1} {myimg2} {myimg2} {myimg2} {myimg2} {myimg2} {myimg2} {myimg3} {myimg3} {myimg3} {myimg3} {myimg3} {myimg3} {myimg4} {myimg4} {myimg4} {myimg4} {myimg4} {myimg4}]; 

% Open an on screen window and color it black
[window, windowRect] = Screen('OpenWindow', 0, black , []);

% Get the size of the on screen window in pixels
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Get the centre coordinate of the window in pixels
[xCenter, yCenter] = RectCenter(windowRect);

% Instructions to be displayed to subject
line1 = 'Each trial will begin with a picture of either a human or a robot.';
line2 = '\n \nAfter two seconds of viewing the picture, it will be replaced'; 
line3 = '\n \nby a word at the center of the screen.';
line4 = '\n \nThis word will be either a real word or a fake word.';
line5 = '\n \nPress 1 if it is a real word. Press 0 if it is a fake word.';
line6 = '\n \nPress any key when you are ready to begin.';

% matrices containing positive, negative, and neutral words
positive_words = ["affection", "paradise", "heaven", "excitement"];
negative_words = ["abduct" , "failure", "disaster", "loneliness"];
neutral_words = ["computer", "highway", "indifferent", "convention"];

% fake words
nonwords = ["snoothed", "scruzzed", "plofts", "ghypts", "sprifths", "snoathed", "thwoosts", "mordes", "splarbed", "phrolved", "kinsed", "tunged"];

% combine all the words
words = [positive_words, negative_words, neutral_words, nonwords];

% Create struct myWords with fields that will store trial information
myWords.words = words;
myWords.category = zeros(1,24);
myWords.RT = zeros(1,24);
myWords.response = zeros(1,24);
myWords.image = zeros(1,24); % 1 if human image or 0 if robot image
myWords.accuracy = zeros(1,24);


% 1 = positive, 2 = negative, 3 = neutral, 4 = nonWord
myWords.category(1:4) = 1;
myWords.category(5:8) = 2;
myWords.category(9:13) = 3;
myWords.category(14:24) = 4;

% Used to randomize order of trials
order = randperm(length(myWords.words));

% Fill in image array
for i = 1:24
    if (order(i) <= 12)
        myWords.image(i) = 1; % human
    else
        myWords.image(i) = 0; % robot
    end
end

% Draw all the text in one go
Screen('TextSize', window, 30);
DrawFormattedText(window, [line1 line2 line3 line4 line5 line6], 'center', screenYpixels * 0.25, white);

% Flip to the screen
Screen('Flip', window);

% Wait for a keyboard button press
KbStrokeWait;

% Iterate through 24 trials 
for i = 1:24
    % Show image
    mytex = Screen('MakeTexture', window, image_array{order(i)});
    Screen('DrawTexture', window, mytex);
    Screen('Flip', window);
    WaitSecs(2);  
    
    % Show word
    Screen('TextSize', window, 70);  
    DrawFormattedText(window, char(myWords.words(order(i))), 'center', 'center', screenYpixels * 0.25, white);
    
    tic; % start timer
    
    % Flip to the screen
    Screen('Flip', window);
    % Waits for subject to press key and stores it
    [ch, when] = GetChar([0], [0]);
    myWords.RT(order(i)) = toc; % stop timer
    myWords.response(order(i)) = str2double(ch) ; % store response    
end

% Calculate accuracy
for i = 1:24
    if (myWords.response(i) == myWords.image(i))
        myWords.accuracy(i) = 1;
    end
end

% Postive words reaction time
posReaction = 0; 
counter = 0; % number of correct responses
for i = 1:4
    if (myWords.accuracy(i) == 1)
        counter = counter + 1;
        posReaction = posReaction + myWords.RT(i);
    end
end

% Accounts for 0 correct responses case
if (counter ~= 0)
    posReaction = posReaction / counter;
else
    posReaction = -1;
end

% Negative words reaction time
negReaction = 0;
counter = 0; % number of correct responses
for i = 5:8
    if (myWords.accuracy(i) == 1)
        counter = counter + 1;
        negReaction = negReaction + myWords.RT(i);
    end
end

% Accounts for 0 correct responses case
if (counter ~= 0)
    negReaction = negReaction / counter;
else
    negReaction = -1;
end

% Neutral words reaction time
neutralReaction = 0;
counter = 0; % number of correct responses
for i = 9:12
    if (myWords.accuracy(i) == 1)
        counter = counter + 1;
        neutralReaction = neutralReaction + myWords.RT(i);
    end
end

% Accounts for 0 correct responses case
if (counter ~= 0)
    neutralReaction = neutralReaction / counter;
else
    neutralReaction = -1;
end

%nonwords reaction time
nonReaction = 0;
counter = 0; % number of correct responses
for i = 13:24
    if (myWords.accuracy(i) == 1)
        counter = counter + 1;
        nonReaction = nonReaction + myWords.RT(i);
    end
end

if (counter ~= 0)
    nonReaction = nonReaction / counter;
else
    nonReaction = -1;
end

% Reaction time for human, emotional words
humReaction = 0;
counter = 0;  % number of correct responses
for i = 1:8
    if (myWords.response(i) == 1 && myWords.image(i) == 1)
        counter = counter + 1;
        humReaction = humReaction + myWords.RT(i);
    end
end

% If subject is wrong on all human or robot trials, record -1 as the reaction time
if(humReaction == 0)
    humReaction = -1;
else
    humReaction = humReaction / counter;
end


% Reaction time for robot, neutral words
robReaction = 0;
counter = 0; % number of correct responses
for i = 9:24
    if (myWords.response(i) == 1 && myWords.image(i) == 0)
        counter = counter + 1;
        robReaction = robReaction + myWords.RT(i);
    end
end

% If subject is wrong on all human or robot trials, record -1 as the reaction time
if(robReaction == 0)
    robReaction = -1;
else
    robReaction = robReaction / counter;
end

% Wait for a keyboard button press
Screen('CloseAll');

% Display stats to subject
disp(['Average positive reaction: ', num2str(posReaction)]);
disp(['Average negative reaction: ', num2str(negReaction)]);
disp(['Average neutral reaction: ', num2str(neutralReaction)]);
disp(['Average neutral reaction time: ', num2str(nonReaction)]);
disp(['Average human reaction for emotional words: ', num2str(humReaction)]);
disp(['Average robot reaction for neutral/non words: ', num2str(robReaction)]);

% File writing to record data
fid = fopen('final_data.txt', 'at');

% Format data written to file
fprintf(fid, '%+.3f,%+9.3f,%+9.3f,%+8.3f,%+8.3f,%+10.3f\n', posReaction, negReaction, neutralReaction, nonReaction, humReaction, robReaction);

% Close file
fclose(fid);