function test_suite = test_SSP
%function test_suite = test_SSP
% A set of verification tests for the RK-opt package.
% Currently this tests SSP coefficient optimization and
% accuracy optimization, but not under constraints on the
% stability polynomial.
initTestSuite;

% Check the solution obtained with fmincon nested in a while loop
% =============================================================
function test_SSP32
tol = 1.e-14;
rk=rk_opt(3,2,'erk','ssp','startvec','smart','write_to_file',0);
A = [0 0 0; 0.5 0 0; 0.5 0.5 0];
r = 2.;

assertElementsAlmostEqual(rk.r,r);
assertElementsAlmostEqual(rk.A,A);


function test_SSP43
rk=rk_opt(4,3,'erk','ssp','startvec','smart','write_to_file',0);
b = [1./6 1./6 1./6 1./2]';
r = 2.;

assertElementsAlmostEqual(rk.r,r);
assertElementsAlmostEqual(rk.b,b);


function test_SDIRK_SSP22
rk=rk_opt(2,2,'sdirk','ssp','startvec','random','write_to_file',0);
b = [1./2 1./2]';
r = 4.;

assertElementsAlmostEqual(rk.r,r);
assertElementsAlmostEqual(rk.b,b);


function test_DIRK_SSP22
tol = 1.e-7;
rk=rk_opt(2,2,'dirk','ssp','startvec','smart','write_to_file',0);

b = [1./2 1./2]';
r = 4.;

if abs(rk.r-r)>tol || max(max(abs(rk.b-b)))>tol
    error('Failed to find optimal DIRK SSP(2,2) method. This occasionally happens; try running the tests again.')
end


function test_RK22_acc
x=[0.117831902493812 0.187227391881097   0.812772608118903  -0.099952256513284 -0.010000000000000];
rk=rk_opt(2,2,'erk','acc','startvec',x,'write_to_file',0);
b = [0.25 0.75]';

assertElementsAlmostEqual(rk.errcoeff,1./6);
assertElementsAlmostEqual(rk.b,b,'absolute',1.e-5);


% Multistep RK tests
function test_SSPTSRK2
tol = 1.e-14;
s=randi(3)+1;
rk=rk_opt(s,2,'emsrk2','ssp','k',2,'write_to_file',0,'min_amrad',s-1);
assertElementsAlmostEqual(rk.r,sqrt(s*(s-1)));



% Check the solution obtained with fmincon called by multistart solver
% both in serial and in parallel.
% ====================================================================
function test_SSP32_multistart
tol = 1.e-14;
rk=rk_opt(3,2,'erk','ssp','startvec','smart','write_to_file',0);
A = [0 0 0; 0.5 0 0; 0.5 0.5 0];
r = 2.;

assertElementsAlmostEqual(rk.r,r);
assertElementsAlmostEqual(rk.A,A);


function test_SSP32_multistart_parallel
tol = 1.e-14;
rk=rk_opt(3,2,'erk','ssp','startvec','smart','np',2,'write_to_file',0);
A = [0 0 0; 0.5 0 0; 0.5 0.5 0];
r = 2.;

assertElementsAlmostEqual(rk.r,r);
assertElementsAlmostEqual(rk.A,A);


function test_SSP43_multistart
rk=rk_opt(4,3,'erk','ssp','startvec','smart','np',1,'write_to_file',0);
b = [1./6 1./6 1./6 1./2]';
r = 2.;

assertElementsAlmostEqual(rk.r,r);
assertElementsAlmostEqual(rk.b,b);


function test_SSP43_multistart_parallel
rk=rk_opt(4,3,'erk','ssp','startvec','smart','np',2,'write_to_file',0);
b = [1./6 1./6 1./6 1./2]';
r = 2.;

assertElementsAlmostEqual(rk.r,r);
assertElementsAlmostEqual(rk.b,b);


function test_SDIRK_SSP22_multistart
rk=rk_opt(2,2,'sdirk','ssp','startvec','random','np',1,'write_to_file',0);
b = [1./2 1./2]';
r = 4.;

assertElementsAlmostEqual(rk.r,r);
assertElementsAlmostEqual(rk.b,b);


function test_SDIRK_SSP22_multistart_parallel
rk=rk_opt(2,2,'sdirk','ssp','startvec','random','np',2,'write_to_file',0);
b = [1./2 1./2]';
r = 4.;

assertElementsAlmostEqual(rk.r,r);
assertElementsAlmostEqual(rk.b,b);


function test_DIRK_SSP22_multistart
tol = 1.e-7;
rk=rk_opt(2,2,'dirk','ssp','startvec','smart','np',1,'write_to_file',0);

b = [1./2 1./2]';
r = 4.;

if abs(rk.r-r)>tol || max(max(abs(rk.b-b)))>tol
    error('Failed to find optimal DIRK SSP(2,2) method. This occasionally happens; try running the tests again.')
end


function test_DIRK_SSP22_multistart_parallel
tol = 1.e-7;
rk=rk_opt(2,2,'dirk','ssp','startvec','smart','np',2,'write_to_file',0);

b = [1./2 1./2]';
r = 4.;

if abs(rk.r-r)>tol || max(max(abs(rk.b-b)))>tol
    error('Failed to find optimal DIRK SSP(2,2) method. This occasionally happens; try running the tests again.')
end


function test_RK22_acc_multistart
x=[0.117831902493812 0.187227391881097   0.812772608118903  -0.099952256513284 -0.010000000000000];
rk=rk_opt(2,2,'erk','acc','startvec',x,'np',1,'write_to_file',0);
b = [0.25 0.75]';

assertElementsAlmostEqual(rk.errcoeff,1./6);
assertElementsAlmostEqual(rk.b,b,'absolute',1.e-5);


function test_RK22_acc_multistart_parallel
x=[0.117831902493812 0.187227391881097   0.812772608118903  -0.099952256513284 -0.010000000000000];
rk=rk_opt(2,2,'erk','acc','startvec',x,'np',2,'write_to_file',0);
b = [0.25 0.75]';

assertElementsAlmostEqual(rk.errcoeff,1./6);
assertElementsAlmostEqual(rk.b,b,'absolute',1.e-5);
