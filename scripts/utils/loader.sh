#----------------------------
#------ SCRIPTS LOADER ------
#----------------------------
function load_scripts() {
  local folder=$1
  local files=$(find $folder -type f -name *.sh)

  #echo "find $folder -type f -name '.sh'"
  #echo $files
 
  for file in $files; do
    echo $file
    . $file
  done 
}
