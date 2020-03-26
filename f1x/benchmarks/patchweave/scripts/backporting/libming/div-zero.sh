bug_id=div-zero
project_name=libming
dir_name=$1/backport/$project_name/$bug_id


project_url=https://github.com/libming/libming.git
pa=$project_name-0.4.7
pb=$project_name-0.4.8
pc=$project_name-0.4.6

pa_commit=80ebea9
pb_commit=b0704f80
pc_commit=ming-0_4_6


mkdir -p $dir_name
cd $dir_name
git clone $project_url $pc


cd $pc
git checkout $pc_commit

