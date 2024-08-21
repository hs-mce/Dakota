% system(['conda activate lammps-env']);
clear all; clc;

A = 2.591061; d = 4.076980; rend=5;
c=4.20; c0 = 1.2157373; c1 = 0.0271471; c2 = -0.1217350; c3 = 0; c4 = 0;

input_array = [A d rend];
potential_params = [c c0 c1 c2 c3 c4];
pert = 1.0e-2;

original_fs(A, d, rend, potential_params);
% system(['lmp -in in.elastic']);
system(['lmp -in bcc_disc_edge_new.in'])
post_process_script;

% saving the values without perturbation
KE_0 = KE;
PE_0 = PE;

KE_pert = zeros(length(input_array), length(KE));
PE_pert = zeros(length(input_array), length(PE));
KE_pert_pot_params = zeros(length(potential_params), length(KE));
PE_pert_pot_params = zeros(length(potential_params), length(PE));

for i = 1:length(input_array)

    perturbation_of_param = pert*input_array(i);                       
    input_array(i) = input_array(i) + perturbation_of_param;
    
    % updating params
    A = input_array(1);
    d = input_array(2);
    rend = input_array(3);

    % computing the new KE, PE
    original_fs(A, d, rend, potential_params);
    system(['lmp -in in.elastic']);
    post_process_script;

    % gettin derivative
    KE_pert(i, :) = (KE - KE_0)/(perturbation_of_param);
    PE_pert(i, :) = (PE - PE_0)/(perturbation_of_param);

    input_array(i) = input_array(i) - perturbation_of_param;

end


for i = 1:length(potential_params)

    perturbation_of_param = pert*potential_params(i);                       
    potential_params(i) = potential_params(i) + perturbation_of_param;

    % computing the new KE, PE
    original_fs(A, d, rend, potential_params);
    system(['lmp -in in.elastic']);
    post_process_script;

    % gettin derivative
    KE_pert_pot_params(i, :) = (KE - KE_0)/(perturbation_of_param);
    PE_pert_pot_params(i, :) = (PE - PE_0)/(perturbation_of_param);

    potential_params(i) = potential_params(i) - perturbation_of_param;

end