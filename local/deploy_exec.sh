#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"
cd ..
export PYTHON_POD_LIST=`kubectl get pods -n data-tooling | grep colossal-ai-temp | grep Running | awk '{ print $1 }' | grep -v NAME`
echo $PYTHON_POD_LIST


echo "$PYTHON_POD_LIST" | while IFS= read -r PYTHON_POD
do
    echo '====================='
    echo "Processing pod: $PYTHON_POD"


    file_list=()

    file_list+=($(find ./data/ -name "dev*.json" | xargs ls -lt |  awk '{print $9}'  ))


    file_list+=(

    )

    echo ${file_list[@]}

    for file in ${file_list[@]}; do
      file_folder=$(dirname $file)
      echo kubectl cp  --retries=10 --no-preserve -n data-tooling ./$file ${PYTHON_POD}:/Workspace/felix/Few-shot-NL2SQL-with-prompting/${file_folder}/
      kubectl cp  --retries=10 --no-preserve -n data-tooling ./$file ${PYTHON_POD}:/Workspace/felix/Few-shot-NL2SQL-with-prompting/${file_folder}/
      echo $file
    done


    echo 'END' at $(date)

done
# kubectl cp exec-service-python-5f6947dc59-hhbtt:/home/ubix/app/del_summary.csv ./del_summary.csv

