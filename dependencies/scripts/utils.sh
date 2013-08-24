try () {
  "$@" || exit -1
}

# one method to deduplicate some symbol in libraries
function deduplicate() {
  fn=$(basename $1)
  echo "== Trying to remove duplicate symbol in $1"
  try mkdir ddp
  try cd ddp
  try ar x $1
  try ar rc $fn *.o
  try ranlib $fn
  try mv -f $fn $1
  try cd ..
  try rm -rf ddp
}
