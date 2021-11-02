#!/bin/bash
i=0
cb=0
while C= read -r line; do
 echo "Branch read :$line"
 bn[i]=$line
 ((++i))
done < "$1"
echo
echo "number of branches"
echo $i
echo "now displaying"
while [[ cb -lt i ]]; do
  echo "${bn[cb]}"
 ((++cb))
done
echo
#Check for merge conflict
cd /home/comp1/Desktop
rm -rf project
git clone git@github.com:sweetyypareek/project.git
cd project
for (( i=0; i<$cb-1; i++ ))
do 
 for (( j=$i+1; j<$cb; j++ ))
 do
  git checkout ${bn[j]}
  git checkout ${bn[i]}
  git checkout -b Temp_${bn[j]}_${bn[i]}
  v_cfc=$(git merge --no-ff ${bn[j]});
  if [[ `(echo $v_cfc | grep 'CONFLICT')` ]];then
   echo "THERE IS CONFLICT BETWEEN ${bn[i]} and ${bn[j]} "
   git reset
   git stash
  else
   echo "THERE IS NO CONFLICT"
  fi;
 done;
done; 
