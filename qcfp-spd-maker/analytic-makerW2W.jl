
numberPoints=10000 #6

# frequency units - reciprocal centimeters
frequency_step = 1

spd_values = zeros(numberPoints)


# select the model by uncommenting required lines




for index = 1:numberPoints
    frequency = index*frequency_step


    #####################
    # generalized Drude model
    if true
        # 30 cm-1 "reorganization" and 100 fs decay time
        drude_lambda = 30
        drude_gamma = 5308.1/100
        drude_parameter_n = 1
        spd_values[index] = 2.0*drude_lambda* ( drude_gamma*frequency/(frequency^2 + drude_gamma^2) )^drude_parameter_n
    end

    #####################
    # generalized ohmic model (includes fractional model)
    if false
        # 30 cm-1 "reorganization" and 100 fs decay time
        ohmic_lambda = 30
        ohmic_gamma = 5308.1/100
        ohmic_parameter_n = 0.5
        spd_values[index] = ohmic_lambda* exp( -frequency/ohmic_gamma ) * (frequency / ohmic_gamma )^ohmic_parameter_n
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
io = open("spd_dataset.txt", "w");
print(io,"# Spectral density file" ,'\n')
print(io,"# Number of points" ,'\n')
print(io,numberPoints,'\n')
print(io,"# Initial frequency" ,'\n')
print(io,"0" ,'\n')
print(io,"# Step size" ,'\n')
print(io,frequency_step,'\n')
print(io,"# The very function" ,'\n')
print(io,"0" ,'\n')
for index = 1:(numberPoints-1)
    print(io,spd_values[index] ,'\n')
end
close(io)
