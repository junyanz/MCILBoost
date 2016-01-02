disp('*****************************************************');
PARAMS = SetParamsToy;
disp('train a MCIL-Boost model'); 
MCILBoost(PARAMS);
PARAMS.mode = 'test';
disp('test a MCIL-Boost model'); 
MCILBoost(PARAMS);
disp('*****************************************************');