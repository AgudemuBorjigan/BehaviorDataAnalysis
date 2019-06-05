function avg = meanWithNan(array)
avg = mean(array(~isnan(array)));
end