fname = input('Enter your first name: ', 's'); % prompt user for first name and store as string
surname = input ('Enter your last name: ', 's'); % prompt user for last name and store as string
fullname = fname + " " + surname; % concatenate first and last name with space in between

num_nonspace = sum(~isspace(fullname)); % sum the number of non-space characters

% conditions based on the # characters in the user's full name
if num_nonspace < 25
    disp('OK then.')

elseif num_nonspace >= 25
    disp('Whoa, that is a long name!')
    
elseif num_nonspace == 0
    disp('So you are anonymous, OK')
end

% display a message containing the length of the user's full name
out = strcat('Your first and last names have a total of ', 32, num2str(num_nonspace), ' characters.');
disp(out)