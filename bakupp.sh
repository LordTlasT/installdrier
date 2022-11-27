#!/usr/bin/env bash
working_dir="$PWD"
clear
awk 'BEGIN{print("------ config_list ------")} {print i++ ":\t" $0}' config_list
echo

bkp_name="$(date +%y%m%d)_bakuppp"
if [[ -d /tmp/${bkp_name} ]];
then
    echo "Folder at: /tmp/${bkp_name}"
    echo "already exists."
    read -p "delete? [y/N]:" input
    [[ "${input}" == "y" ]] && rm -rf /tmp/${bkp_name} || exit 1
    clear
fi
bkp_dir_path=/tmp/$bkp_name
i=0
while read line
do
    ((i++))
    if [[ "$line" == "" ]]; then
        i=0
    fi
    if [[ $i -eq 1 ]]; then
        bkp_dest_dir="$(echo $line | cut -d '/' -f 2-)"
        bkp_dest_dir="$bkp_dir_path/$bkp_dest_dir"
        eval "mkdir -p ${bkp_dest_dir} 2> /dev/null"
        source_dir="${line}"
        eval "cd $line"
    elif [[ $i -gt 1 ]]; then
        echo "Copying from ${source_dir}"
        echo -e "$line \\n"
        eval "cp -r ${line} ${bkp_dest_dir} 2> /dev/null"
    fi
done < config_list
cd /tmp
echo "Building Archive..."
echo -n "size: "
du -h -d 0 "${bkp_name}" | cut -f 1
# With progress bar
tar cf - "${bkp_name}" -P \
    | pv -s $(du -sb "${bkp_name}/" \
    | awk '{print $1}') \
    | gzip > "${bkp_name}.tar.gz"
rm -rf /tmp/"${bkp_name}"
cd "${working_dir}"
mv "/tmp/${bkp_name}.tar.gz" .
du -h -d 0 "${bkp_name}.tar.gz" | cut -f 1

echo "Done!"
