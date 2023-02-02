config_file="./config"
line_num=1
while read line; do
  path=$(echo "${line}" | awk -F "=" '{print $2}' | awk '{print $1}')
  current_line=$(echo "${line}" | awk -F "=" '{print $3}' | awk '{print $1}')
  quote=$(sed -n "${current_line}p" $path)
  color=$(sed -n "${line_num}p" "./colours")
  echo -e $color$quote"\033[0m"

  total_lines=$(wc -l $path | awk '{print $1}')
  if [ $current_line -lt $total_lines ]; then
    current_line=$((current_line + 1))
  else
    current_line=1
  fi

  sed -i "${line_num}s|.*|path=${path} current_line=${current_line}|" $config_file

  line_num=$((line_num+1))
done < "${config_file}"
