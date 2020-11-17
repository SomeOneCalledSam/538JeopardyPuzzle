function [avg_winnings, total_winnings] = JeopardyPuzzle_538(order)
% function [avg total_winnings] = 538expressriddle(order)
%   DESCRIPTION
%   Function to solve the 538 Express Riddle from Friday, 11/13, linked    
%   here: https://fivethirtyeight.com/features/can-you-snatch-defeat-from-the-jaws-of-victory/
%
%   INPUT:
%    order: put in string for horizontal, vertical, or both
%       horizontal - assumes you start in the top left corner and then move
%       horizontal through each row
%       vertical - assumes you start in the top left corner and then move
%       vertically through each row
%       random - choose at random, runs 10000 samples instead (graph not helpful)
%       both - shows the results for both horizontal and vertical in a
%              graph, returns the average difference between each value,
%              horizontal - vertical
%
%   OUTPUT:
%     avg - average amount of money won
%     total_winnings - array with the amount of winnings depending on where
%      the daily double appears (each index corresponds to at what point
%      the daily double is chosen)
%     Graph - showing total_winnings plotted against the daily double
%             position
%
%   EXAMPLE:
%     JeopardyPuzzle_538("vertical")
%     JeopardyPuzzle_538("horizontal")
%     JeopardyPuzzle_538("both")
%
% written by Sam Cryan, 11/16

if order == "both"
    [avg_winningsv, total_winningsv] = JeopardyPuzzle_538("vertical");
    hold on
    [avg_winningsh, total_winningsh] = JeopardyPuzzle_538("horizontal");
    legend("vertical","horizontal",'Location','NorthWest');
    avg_winnings = avg_winningsh - avg_winningsv;
    total_winnings = total_winningsh - total_winningsv;
    hold off
else
    length = 25;
    if order == "random"
        data = [200 200 200 200 200 400 400 400 400 400 600 600 600 600 600 1000 1000 1000 1000 1000];
        length = 10000;
    end
    
winnings = zeros(length,25);
total_winnings = zeros(1,length);

for dailydouble = 1:length
for i = 1:25
    if mod(dailydouble,26) == i
        if (sum(winnings(dailydouble,1:i)) < 1000)
            bid = 1000;
        else
            bid = sum(winnings(dailydouble,1:i));
        end
        winnings(dailydouble,i) = winnings(dailydouble,i) + bid;
    else
        if order == "horizontal"
            bid = ((floor((i-1)/5)+1)*200);
        elseif order == "vertical"
            bid = (mod(i-1,5)+1)*200;
        elseif order == "random"
            bid = datasample(data,1,'Replace',false);
        end
    winnings(dailydouble,i) = winnings(dailydouble,i) + bid;
    end
end
    total_winnings(dailydouble) = sum(winnings(dailydouble,:));
end
avg_winnings = mean(total_winnings);
figure(1)
plot(1:length,total_winnings,'LineWidth',2)
set(gca,'XMinorTick', 'on','YGrid','on','XGrid','off','FontSize',16)
xlabel("Daily Double's appearance");
ylabel('Amount of Winnings');
legend(order,'Location','NorthWest');
end