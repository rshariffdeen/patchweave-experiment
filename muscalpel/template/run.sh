#!/bin/bash

ulimit -s unlimited

./check.sh
OUT=$?

if [ $OUT -eq 1 ];then
   echo "All dependencies are installed! We haven't check your hard drive type. If you are not using SSD, then the timing results may be affected. The experiment will run now..."
else
   echo "You are missing some dependendencies! Results may be affected."
   read -p "Do you still want to continue? (y/n)?"
   if [ $REPLY == "n" ]; then
	echo "Exiting..."
	exit 1
   fi
fi

rm -r -f Host_BENEFICIARY
cd Experiment
cd Transplant
rm -r -f Host_BENEFICIARY TEMP-* TransplantCode-* Temp/*
cd ..


./gentrans --seeds_file Transplant/seed-1.in --compiler_options Transplant/CFLAGS --host_target $1 --donor_target $2 --donor_folder Transplant/Donor/ --workspace Transplant/ --core_function $3  --host_project Transplant/Host

cd Transplant
cp -r -f Host_BENEFICIARY ../../
rm -r -f Host_BENEFICIARY TEMP-* TransplantCode-* Temp/*
cd ../../
