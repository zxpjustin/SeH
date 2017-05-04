function [ curTimeStr ] = getTimeStr(  )
%GETTIMESTR Summary of this function goes here
%   获取时间字符串

curTimeStr = [num2str(year(now)),'-',num2str(month(now)),'-',num2str(day(now)),'-',num2str(hour(now)),'-',num2str(minute(now)),'-',num2str(floor(second(now)))];


end

