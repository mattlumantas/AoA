r1 = [33 58 31.77; 117 19 46.78];
r2 = [33 58 31.38; 117 19 45.83];
r3 = [33 58 31.00; 117 19 46.95];

t1 = [33 58 31.38; 117 19 46.41];
t2 = [33 58 31.38; 117 19 46.77];
 t3 = [33 58 31.15; 117 19 46.47];
 t4 = [33 58 31.38; 117 19 46.18];

r1_sec = r1(:,3);
r2_sec = r2(:,3);
r3_sec = r3(:,3);

t1_sec = t1(:,3);
t2_sec = t2(:,3);
t3_sec = t3(:,3);
t4_sec = t4(:,3);

r1t1_raw_az = angle((r1_sec(2)-t1_sec(2)) +1j*(r1_sec(1)-t1_sec(1)))*180/pi;
r1t2_raw_az = angle((r1_sec(2)-t2_sec(2)) +1j*(r1_sec(1)-t2_sec(1)))*180/pi;
r1t3_raw_az = angle((r1_sec(2)-t3_sec(2)) +1j*(r1_sec(1)-t3_sec(1)))*180/pi;
r1t4_raw_az = angle((r1_sec(2)-t4_sec(2)) +1j*(r1_sec(1)-t4_sec(1)))*180/pi;

r2t1_raw_az = angle((r2_sec(2)-t1_sec(2)) +1j*(r2_sec(1)-t1_sec(1)))*180/pi;
r2t2_raw_az = angle((r2_sec(2)-t2_sec(2)) +1j*(r2_sec(1)-t2_sec(1)))*180/pi;
r2t3_raw_az = angle((r2_sec(2)-t3_sec(2)) +1j*(r2_sec(1)-t3_sec(1)))*180/pi;
r2t4_raw_az = angle((r2_sec(2)-t4_sec(2)) +1j*(r2_sec(1)-t4_sec(1)))*180/pi;

r3t1_raw_az = angle((r3_sec(2)-t1_sec(2)) +1j*(r3_sec(1)-t1_sec(1)))*180/pi;
r3t2_raw_az = angle((r3_sec(2)-t2_sec(2)) +1j*(r3_sec(1)-t2_sec(1)))*180/pi;
r3t3_raw_az = angle((r3_sec(2)-t3_sec(2)) +1j*(r3_sec(1)-t3_sec(1)))*180/pi;
r3t4_raw_az = angle((r3_sec(2)-t4_sec(2)) +1j*(r3_sec(1)-t4_sec(1)))*180/pi;

r1t2_az = r1t1_raw_az - r1t2_raw_az;
r1t3_az = r1t1_raw_az - r1t3_raw_az;
r1t4_az = r1t1_raw_az - r1t4_raw_az;

r2t2_az = r2t1_raw_az - r2t2_raw_az;
r2t3_az = r2t1_raw_az - r2t3_raw_az;
r2t4_az = r2t1_raw_az - r2t4_raw_az;

r3t2_az = r3t1_raw_az - r3t2_raw_az;
r3t3_az = r3t1_raw_az - r3t3_raw_az;
r3t4_az = r3t1_raw_az - r3t4_raw_az;

r1t2_ = -41;
r1t3_ = -8;
r1t4_ = 14;

r2t2_ = 1;
r2t3_ = 26;
r2t4_ = 0;

r3t2_ = 24;
r3t3_ = -16;
r3t4_ = -4;

r1_angles = [r1t2_az; r1t3_az; r1t4_az] % +-+
r2_angles = [r2t2_az; r2t3_az; r2t4_az] % +-+
r3_angles = [r3t2_az; r3t3_az; r3t4_az] % -+-