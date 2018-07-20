% This is "FRONT-END" side of application. %
% All back-end processing in SalaryCalculator class. %
% There is also possibility to add basic menu and other features. % 

tic %starting timer

% Assigning class % 
Salary = SalaryCalculator;

% Calling function to get current dat % 
Salary.GetCurrentDate();

% Preparing data for write % 
Salary.PrepareData();

% Writting data to CSV file % 
Salary.WriteCSV();

disp('Output file was successfully generated!');

toc %ending timer