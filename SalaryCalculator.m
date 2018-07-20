classdef SalaryCalculator < handle

    properties
        Months,
        CurrentDate,
        CsvData,
    end
 
    methods
        
        % Get current date %
        function obj = GetCurrentDate(obj) 
            Date = today('datetime'); % date object
            [y,m,d] = ymd(Date); % convert date object to y,m,d
            obj.CurrentDate = [y, m, d];
        end
        
        % Assign month name for month number %         
        function [MonthName] = ShowMonthName(obj, MonthNo)
                
            obj.Months = {'January', 'February', 'March', 'April', 'May', 'June', ...
            'July', 'August', 'September', 'October', 'November', 'December'};
            
            if (MonthNo > 12)
               error('Check the month number');
            end
        
            MonthName = obj.Months{MonthNo};
        end
        
        % Get date when salary should be paid %         
        function [SalaryDate] = GetSalaryDate(~, year, month)
            
            % Get the last business day of the month 
            Date = lbusdate(year, month);    
            
            SalaryDate = datetime(datestr(Date)); %output date object
        end
        
        % Get bonus payment date %         
        function [BonusPayment] = GetBonusDate(~, year, month)
            BONUSDAY = 12; % Const for payment day
            
            Date = datetime(year, month, BONUSDAY);
            
            % check if business day            
            if (isbusday(Date))
                
                BonusPayment = Date; 
                
            else
                % if not business day get first Tuesday after 12th.                 
                DayNumber = 0;
                NewDate = Date;
                
                while DayNumber ~= 3
                    NewDate = NewDate + caldays(1);
                    DayNumber = weekday(NewDate);
                end
                
               BonusPayment = NewDate;
               
            end
            
            
        end
        
        % preparing data for CSV file, assigning to cell array %         
        function PrepareData(obj)
            
            MONTHDATA = 12; % period for salaries
            
            StartDate = datetime(obj.CurrentDate); % current date object
            SalaryMonths = dateshift(StartDate, 'start', 'month', 0:MONTHDATA); % Get 12 months in foward
            
            for i = 1:numel(SalaryMonths)
               
               % Getting name of the month               
               SalaryMonthNo = obj.GetSalaryDate(SalaryMonths(i).Year, SalaryMonths(i).Month).Month;
               
               obj.CsvData{1, i} = obj.ShowMonthName(SalaryMonthNo); % assinging month name
               
               %assigning salary date
               obj.CsvData{2, i} = obj.GetSalaryDate(SalaryMonths(i).Year, SalaryMonths(i).Month);
               
               %assigning bonus date
               obj.CsvData{3, i} = obj.GetBonusDate(SalaryMonths(i).Year, SalaryMonths(i).Month); 
            
            end
            
        end
       
        % Writting all data to CSV file %         
        function WriteCSV(obj)
            
            NAME = 'output.csv'; %output file name
                        
            filename = fopen(NAME ,'w'); % creating and opening file
            
            % Creating header for CSV            
            CsvHeader = 'Month,Salary date,Bonus date\n';
            
            fprintf(filename, CsvHeader); %writting header
            
            for i = 1:numel(obj.CsvData(1,:))
                %  writting rest of the data to CSV               
                fprintf(filename, '%s, %s, %s,\n', obj.CsvData{1, i},...
                    obj.CsvData{2, i}, obj.CsvData{3, i});
            end
            
        end
        
    end
   
end
