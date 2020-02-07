
numberPoints=10000000 #6

time_step = 1 # femtoseconds

temperature = 300 # Kelvin




cfun_values = zeros(numberPoints)
# converting temperature in Kelvin to thermal energy
temperature = 0.6950303 * temperature


for index = 1:numberPoints
    time = (index-1)*time_step


    #####################
    # Drude model
    if false
        # 30 cm-1 "reorganization" and 100 fs decay time
        drude_lambda = 30
        drude_gamma = 1.0/100.0
        cfun_values[index] = 2.0*temperature*drude_lambda* exp( - time*drude_gamma )
    end

    #####################
    # Gaussian model
    if false
        # 30 cm-1 "reorganization" and 100 fs decay time
        ga_lambda = 30
        ga_gamma = 1.0/100.0
        cfun_values[index] = 2.0*temperature*ga_lambda* exp( - (time*ga_gamma)^2 )
    end

    #####################
    # fractional model 1
    if false
        # 30 cm-1 "reorganization" and 30 fs delay time
        fr_lambda = 30
        fr_gamma = 1.0/40.0
        fr_parameter_mu = 0.8
        if index == 1
            cfun_values[1] = 2.0*temperature*fr_lambda
        else
            cfun_values[index] = 2.0*temperature*fr_lambda * (tanh( time*fr_gamma ) / (time*fr_gamma ))^(1.0-fr_parameter_mu)
        end
    end

    #####################
    # fractional model 2
    if true
        # 30 cm-1 "reorganization" and 30 fs delay time
        fr_lambda = 30
        fr_gamma = 1.0/40.0
        fr_parameter_mu = 0.8
        if index == 1
            cfun_values[1] = 2.0*temperature*fr_lambda
        else
            cfun_values[index] = 2.0*temperature*fr_lambda * (1.0 / (time*fr_gamma +1.0))^(1.0-fr_parameter_mu)
        end
    end


end


##output
## Spectral density file
## Number of points
#100000
## Initial frequency
#0
## Step size
#0.1
## The very function
#0.
#0.003999984000064
#0.007999872002047968
#0.01199956801555144
#0.015998976065531807
#0.019998000199980003
#0.023996544497592347
#...


# Printing
io = open("cfun_dataset.txt", "w");
io1 = open("cfun_function.txt", "w");
print(io,"# Classical correlation function file" ,'\n')
print(io,"# Number of points" ,'\n')
print(io,numberPoints,'\n')
print(io,"# Initial time" ,'\n')
print(io,"0" ,'\n')
print(io,"# Time step size" ,'\n')
print(io,time_step,'\n')
print(io,"# The very function" ,'\n')
for index = 1:numberPoints
    print(io1,time_step*(index-1),' ',cfun_values[index] ,'\n')
    print(io,cfun_values[index] ,'\n')
end
close(io1)
close(io)
