#!/bin/bash
#Simple script to run our test program on gem5 with different parameters and save the results
#Folders ~/test1, ~/test1/freq, ~/test1/mem, ~/test1/freq/minor, ~/test1/freq/timing,
#~/test1/mem/minor and ~/test1/mem/timing subfolders  must exist, along with a times.txt
#file on each timing and minor subfolder. For the script to run properly no other files/folders must exist in
#the minor and timing subfolders and all times.txt files must be empty


#Run for different frequencies
echo "Frequencies: "
#Run for MinorCPU model
echo "Minor: "
i=64
while [ $i -le 4096 ]
do
	#Run program, copy stats.txt and save the number of ticks at times.txt
	./build/ARM/gem5.opt configs/example/se.py --cpu-type=MinorCPU --cpu-clock="${i}MHz" --caches -c ~/test2_arm
	mkdir ~/test1/freq/minor/$i/
	cp ~/Desktop/gem5/m5out/stats.txt ~/test1/freq/minor/$i/
	echo -n "$i     	" >> ~/test1/freq/minor/times.txt
	cat ~/test1/freq/minor/$i/stats.txt | grep "sim_ticks" >> ~/test1/freq/minor/times.txt
	i=$(( $i * 2 ))
done
#Run for TimingSimpleCPU model
i=64
while [ $i -le 4096 ]
do
	#Run program, copy stats.txt and save the number of ticks at times.txt
        ./build/ARM/gem5.opt configs/example/se.py --cpu-type=TimingSimpleCPU --cpu-clock="${i}MHz" --caches -c ~/test2_arm
        mkdir ~/test1/freq/timing/$i/
        cp ~/Desktop/gem5/m5out/stats.txt ~/test1/freq/timing/$i/
        echo -n "$i             " >> ~/test1/freq/timing/times.txt
        cat ~/test1/freq/timing/$i/stats.txt | grep "sim_ticks" >> ~/test1/freq/timing/times.txt
	i=$(( $i * 2 ))
done

#Create array with different memory types we want to test
declare -a memTypes=("HBM_1000_4H_1x128" "DDR3_2133_8x8" "HBM_1000_4H_1x64" "LPDDR3_1600_1x32" "WideIO_200_1x128" "DDR4_2400_8x8" "DDR3_1600_8x8" "DDR4_2400_4x16" "DDR4_2400_16x4" "SimpleMemory" "LPDDR2_S4_1066_1x32")

#Run for TimingSimpleCPU model
for i in "${memTypes[@]}"
do
	#Run program, copy stats.txt and save the number of ticks at times.txt
	./build/ARM/gem5.opt configs/example/se.py --cpu-type=TimingSimpleCPU --mem-type="$i" --caches -c ~/test2_arm
        mkdir ~/test1/mem/timing/$i/
        cp ~/Desktop/gem5/m5out/stats.txt ~/test1/mem/timing/$i/
        echo -n "$i             " >> ~/test1/mem/timing/times.txt
        cat ~/test1/mem/timing/$i/stats.txt | grep "sim_ticks" >> ~/test1/mem/timing/times.txt
done

#Run for MinorCPU model
for i in "${memTypes[@]}"
do
	#Run program, copy stats.txt and save the number of ticks at times.txt
        ./build/ARM/gem5.opt configs/example/se.py --cpu-type=MinorCPU --mem-type="$i" --caches -c ~/test2_arm
        mkdir ~/test1/mem/minor/$i/
        cp ~/Desktop/gem5/m5out/stats.txt ~/test1/mem/minor/$i/
        echo -n "$i             " >> ~/test1/mem/minor/times.txt
        cat ~/test1/mem/minor/$i/stats.txt | grep "sim_ticks" >> ~/test1/mem/minor/times.txt
done
