%parameters
receiver_locations = [0 0; 10 0; -10 0];
receiver_azimuths = [39 20 1];
transmitter_locations = [30 59; 29 18];
multipath_locations = [28 50; 19 27];
multipath_reflections = [.7 .2];

num_elements = 4;
carrierF = 9e8;
carrierA = sqrt(2);
wavelength = physconst('LightSpeed')/carrierF;
toneF = 4e4;
toneA = sqrt(2);
IQrate = 1e6;
samples = 16384;
t = (1:samples)./IQrate;

signal = carrierA*exp(1j*2*pi*carrierF*t)+ toneA*exp(1j*2*pi*toneF*t);


%initialize receivers
for i = 1:size(receiver_locations,1)
receivers(i) = struct('array',phased.ULA('NumElements',num_elements,...
                                         'ElementSpacing',wavelength/2),...
                      'azimuth',receiver_azimuths(i),...
                      'location',receiver_locations(i,:),...
                      'received',[]...
                     );
end

%initialize transmitters
for i = 1:size(transmitter_locations,1)
    transmitters(i) = struct('location',transmitter_locations(i,:),...
                             'signal',signal);
end

%initialize multipath sources
for i = 1:size(multipath_locations,1)
    multipaths(i) = struct('location',multipath_locations(i,:),...
                           'reflectionA',multipath_reflections(i),...
                           'echos',zeros(1,size(signal,2)));
    for l = 1:size(transmitters,2)
        dist=pdist([multipaths(i).location' transmitters(l).location'],'euclidean');
        phase = dist*2*pi/wavelength;
        multipaths(i).echos(l,:) = signal*exp(1j*phase);
    end
end

%impinge receivers
for i = 1:size(receivers,2)
    received_signal = [];
    angles = [];
    for l = size(multipaths,2)
        received_signal = [received_signal; multipaths(l).echos];
        temp_angle = multipaths(l).location - receivers(i).location;
        angles = 
    end
    for l = size(transmitters,2)
        received_signal = [received_signal; transmitters(l).signal];
    end
    receivers(i).received = 

%beamform receivers

%plot azimuths