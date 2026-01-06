% Absolute Mass Change per lobe are the inputs

% Lobe segmentation can be done manually or using existing softwares. 
% Mass change values are computed by summing HU-density values between
% corresponding inhale/exhale lobes. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function sol = peDriver(POS,NEG)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[pn,m] = size(POS); nn = size(NEG,1);

% Bound the variables to have some physical meaning
LB = zeros(m,1); UB = max(POS(:))*ones(m,1);

% Set up the particle swarm optimizer
options = optimoptions('particleswarm', 'Display', 'off','FunctionTolerance',1e-14);

% Optimization/Validation sets
minVal = inf; val = 0; maxIter = 50; 
pidx = randperm(pn); tp = pidx(end-9:end); pidx = pidx(1:end-10); 
nidx = randperm(nn); tn = nidx(end-9:end); nidx = nidx(1:end-10); 


for i = 1:maxIter
   [x,fVal] = particleswarm( @(x) objective(x,POS(pidx,:),NEG(nidx,:)),m,LB,UB,options);     
   val = max(objective(x,POS(tp,:),NEG(tn,:)),fVal); % Final score = min(sensitivity,specificity)
  
   % Check if best so far
   if(val < minVal), sol = x; minVal = val; end

   % Check if satisifies opt/validation criteria
   if(minVal < -0.7), break; end
end
